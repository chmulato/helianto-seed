package com.iservport.home.controller;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.helianto.core.domain.City;
import org.helianto.core.domain.Country;
import org.helianto.core.domain.Entity;
import org.helianto.core.domain.Identity;
import org.helianto.core.domain.Operator;
import org.helianto.core.domain.State;
import org.helianto.core.repository.CityRepository;
import org.helianto.core.repository.CountryRepository;
import org.helianto.core.repository.IdentityRepository;
import org.helianto.core.repository.OperatorRepository;
import org.helianto.core.repository.StateRepository;
import org.helianto.install.service.AbstractEntityInstallStrategy;
import org.helianto.install.service.EntityInstallService;
import org.helianto.install.service.UserInstallService;
import org.helianto.user.domain.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Service;

/**
 * Entity prototype generation.
 * 
 * @author mauriciofernandesdecastro
 */
@Service
@PropertySource("classpath:/META-INF/app.properties")
public class EntityByPrincipalInstallStrategy 
	extends AbstractEntityInstallStrategy
	implements InitializingBean
{
	
	private static final Logger logger = LoggerFactory.getLogger(EntityByPrincipalInstallStrategy.class);
	
	private static final String DEFAULT_CONTEXT_NAME = "DEFAULT";
	
	private static final String DEFAULT_CONTEXT_DATA_PATH = "/META-INF/data/";
	
	private static final String DEFAULT_COUNTRY_FILE = "countries.xml";
	
	private static final String DEFAULT_COUNTRY = "1058";
	
	private static final String DEFAULT_STATE_FILE = "states-1058.xml";
	
    private static  final String INITIAL_SECRET = "123rooT#";
    
    protected String contextDataPath;
    
	@Inject
	private Environment env;
	
	@Inject
	private CountryParser countryParser;
	
	@Inject
	private StateParser stateParser;
	
	@Inject
	private CityParser cityParser;
	
	@Inject
	private OperatorRepository contextRepository;
	
	@Inject
	private CountryRepository countryRepository;
	
	@Inject
	private StateRepository stateRepository;
	
	@Inject
	private CityRepository cityRepository;
	
	@Inject
	private IdentityRepository identityRepository;
	
	@Inject
	private IdentityCrypto identityCrypto; 
	
	@Inject
	private  UserInstallService userInstallService;
	
	@Inject
	private EntityInstallService entityInstallService;
	
	@Override
	public void afterPropertiesSet() throws Exception {
		contextDataPath = env.getProperty("helianto.contextDataPath", DEFAULT_CONTEXT_DATA_PATH);
		String contextName = env.getProperty("helianto.defaultContextName", DEFAULT_CONTEXT_NAME);
		String contextDataLocation = env.getProperty("helianto.defaultContextName", DEFAULT_CONTEXT_NAME);

		Operator context = contextRepository.findByOperatorName(contextName);
		if (context==null) {
			context = contextRepository.saveAndFlush(new Operator(contextName));
			logger.info("Created {}.", context);
			Country country = installCountries(context);
			City city = installStatesAndCities(context, country);
			runOnce(context, city);
		}
	}
	
	/**
	 * Install countries, return the root country.
	 * 
	 * @param context
	 * @param contextDataPath
	 */
	protected Country installCountries(Operator context) {
		String countryFile = env.getProperty("helianto.countryFile", DEFAULT_COUNTRY_FILE);
		String defaultCountry = env.getProperty("helianto.defaultCountry", DEFAULT_COUNTRY);
		
		// All countries
		Resource countryResource = new ClassPathResource(contextDataPath+countryFile);
		List<Country> countries = countryParser.parseCountries(context, countryResource);
		List<Country> managedCountries = countryRepository.save(countries);
		logger.info("Saved {} countries.", managedCountries.size());
		
		// Our country
		Country country = countryRepository.findByOperatorAndCountryCode(context, defaultCountry);
		return country;
	}
	
	/**
	 * Install states and cities, return the root city.
	 * 
	 * @param context
	 * @param contextDataPath
	 */
	protected City installStatesAndCities(Operator context, Country country) {
		String stateFile = env.getProperty("helianto.stateFile", DEFAULT_STATE_FILE);
		String rootEntityStateCode = env.getRequiredProperty("rootEntityStateCode");
		String rootEntityCityCode = env.getRequiredProperty("rootEntityCityCode");
		
		if (country==null) {
			throw new IllegalArgumentException("Please, provide required country to allow for default city resolution.");
		}
		
		// States
		Resource stateResource = new ClassPathResource(contextDataPath+stateFile);
		List<State> states = stateParser.parseStates(context, country, stateResource);
		List<State> managedStates = stateRepository.save(states);
		logger.info("Saved {} states.", managedStates.size());
		State state = stateRepository.findByContextAndStateCode(context, rootEntityStateCode);

		// Cities
		if (state==null) {
			throw new IllegalArgumentException("Please, provide required sate to allow for default city resolution.");
		}
		
		try {
			for (State s: managedStates) {
				Resource cityResource = new ClassPathResource(resolveCityDataPath(country, s));
				List<City> cities = cityParser.parseCities(context, s, cityResource);
				cityRepository.save(cities);
				logger.info("Saved {} cities.", cities.size());	
			}
		} catch (Exception e) {
			logger.info("Error saving cities.");	
		}
		
		City city = cityRepository.findByContextAndCityCode(context, rootEntityStateCode);
		if(city==null){
			throw new IllegalArgumentException("Please, provide required data to allow for default city resolution.");
		}
		return city;
		
	}
	
	/**
	 * Convenient to resolve city files location.
	 * 
	 * @param country
	 * @param state
	 */
	protected String resolveCityDataPath(Country country, State state) {
		return contextDataPath+country.getCountryCode()+"/cities-"+state.getStateCode()+".xml";
	}
	
	/**
	 * Run once at installation
	 */
	protected void runOnce(Operator context, City rootCity) {
		String rootEntityAlias = env.getProperty("helianto.rootEntityAlias", DEFAULT_CONTEXT_NAME);
		String rootPrincipal = env.getRequiredProperty("helianto.rootPrincipal");
		String noReplyEmail = env.getProperty("helianto.noReplyEmail", rootPrincipal);
		String rootFirstName = env.getRequiredProperty("helianto.rootFirstName");
		String rootLastName = env.getRequiredProperty("helianto.rootLastName");
		String rootDisplayName = env.getProperty("helianto.rootDisplayName", rootFirstName);
		String initialSecret = env.getProperty("iservport.initialSecret", INITIAL_SECRET);
		String rootEntityStateCode = env.getRequiredProperty("rootEntityStateCode");
		
		// Root entity
		Entity rootEntity = new Entity(context, rootEntityAlias);
		rootEntity.setCity(rootCity);
		rootEntity = entityInstallService.installEntity(rootEntity);
		Identity rootIdentity = identityRepository.findByPrincipal(rootPrincipal);
		if(rootIdentity==null){
			rootIdentity= new Identity(rootPrincipal);
			rootIdentity.setDisplayName(rootDisplayName);
			rootIdentity.getPersonalData().setFirstName(rootFirstName);
			rootIdentity.getPersonalData().setLastName(rootLastName);
			rootIdentity = identityRepository.saveAndFlush(rootIdentity);
			logger.info("Created root identity {}.", rootIdentity);	
			identityCrypto.createIdentitySecret(rootIdentity, initialSecret, false);
			
		}
		// Root user
		User rootUser = userInstallService.installUser(rootEntity, rootIdentity.getPrincipal());
		runAfterInstall(context, rootEntity, rootUser);
	}
	
	protected void runAfterInstall(Operator context, Entity rootEntity, User rootUser) {
	}
	
	@Override
	public List<Entity> generateEntityPrototypes(Object... params) {
		if (params!=null && params.length>0 && params[0] instanceof Identity) {
			Identity identity = (Identity) params[0];
			List<Entity> entityList = new ArrayList<>();
			entityList.add(createPrototype(identity.getPrincipal(), identity.getIdentityName(), 'F'));		
			return entityList;
		}	
		throw new IllegalArgumentException("Identity required.");
	}

}

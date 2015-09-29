package com.iservport.home.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.helianto.core.domain.City;
import org.helianto.core.domain.Country;
import org.helianto.core.domain.Entity;
import org.helianto.core.domain.Identity;
import org.helianto.core.domain.KeyType;
import org.helianto.core.domain.Operator;
import org.helianto.core.domain.State;
import org.helianto.core.repository.CityRepository;
import org.helianto.core.repository.CountryRepository;
import org.helianto.core.repository.IdentityRepository;
import org.helianto.core.repository.KeyTypeRepository;
import org.helianto.core.repository.OperatorRepository;
import org.helianto.core.repository.StateRepository;
import org.helianto.install.service.AbstractEntityInstallStrategy;
import com.iservport.home.controller.LocalEntityInstallService;
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

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.type.TypeFactory;

/**
 * Entity prototype generation.
 * 
 * @author mauriciofernandesdecastro
 */
@Service
public class EntityByPrincipalInstallStrategy 
	extends AbstractEntityInstallStrategy
	implements InitializingBean
{
	
	private static final Logger logger = LoggerFactory.getLogger(EntityByPrincipalInstallStrategy.class);
	
	private static final String KEY_TYPE_PATH_FILE = "/META-INF/data/keyType/";
	
    protected String contextDataPath;
    
	@Inject
	private ObjectMapper mapper;
	
	@Inject
	private KeyTypeRepository keyTypeRepository;
	
	/**
	 * Brasil.
	 */
	protected String getDefaultCountry() {
		return "1058";
	}
	
	/**
	 * Estados são lidos a partir deste arquivo.
	 */
	protected String getDefaultStateFile() {
		return "states-1058.xml";
	}
	
	/**
	 * Senha inicial.
	 */
	protected String getInitialSecret() {
		return "123rooT#";
	}
	
	protected void runOnce(Operator context, Entity rootEntity, User rootUser) {
		try {
			createKeyTypes(context);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public List<Entity> generateEntityPrototypes(Object... params) {
		if (params!=null && params.length>0 && params[0] instanceof Identity) {
			Identity identity = (Identity) params[0];
			List<Entity> entityList = new ArrayList<>();
			entityList.add(createPrototype(identity.getOptionalSourceAlias(), "", 'C'));
			return entityList;
		}
		throw new IllegalArgumentException("SignupForm required.");

	}

	public void createKeyTypes(Operator context) throws JsonParseException, JsonMappingException, IOException{
		logger.debug("Creating Key types for {}.", context);
		ClassPathResource resource =  new ClassPathResource(KEY_TYPE_PATH_FILE+"keyTypes.json");
		ArrayList<KeyType> user = 
				mapper.readValue(resource.getFile(), TypeFactory.defaultInstance().constructCollectionType(List.class,  
				KeyType.class));
			if(context!=null){
			for (KeyType keyType : user) {
				logger.debug("Search ketType to context {} with keyCode {}.", context, keyType.getKeyCode());
				KeyType exists = keyTypeRepository.findByOperatorAndKeyCode(context, keyType.getKeyCode());
				//update
				if(exists!=null){
					exists.setKeyCode(keyType.getKeyCode());
					exists.setKeyGroup(keyType.getKeyGroup());
					exists.setKeyName(keyType.getKeyName());
					exists.setPurpose(keyType.getPurpose());
					exists.setSynonyms(keyType.getSynonyms());
					keyTypeRepository.saveAndFlush(exists);
					logger.debug("update ketType to context {} with keyCode {} to {} .", context, exists.getKeyCode(), keyType);
				}
				//save
				else{
					keyType.setOperator(context);
					keyType = keyTypeRepository.saveAndFlush(keyType);
					logger.debug("saved ketType  {} .", keyType);

				}
			}
		}else{
			//TODO create?
		}
		
	}


}

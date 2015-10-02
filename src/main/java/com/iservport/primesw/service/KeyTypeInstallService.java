package com.iservport.primesw.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.helianto.core.domain.KeyType;
import org.helianto.core.domain.Operator;
import org.helianto.core.repository.KeyTypeRepository;
import org.helianto.core.repository.OperatorRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.core.env.Environment;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.type.TypeFactory;

/**
 * Serviço para instalação padrão.
 * 
 * @author Eldevan Nery Junior
 *
 */
@Service 
public class KeyTypeInstallService implements InitializingBean {
	
	private static final Logger logger = LoggerFactory.getLogger(KeyTypeInstallService.class);
	
	private static final String keyTypePathFile = "/META-INF/data/keyType/";
	
	@Inject
	private ObjectMapper mapper;
	
	@Inject
	private KeyTypeRepository keyTypeRepository;
	
	@Inject 
	private OperatorRepository contextRepository;
	
	@Inject
	private Environment environment;
	
	@Override
	public void afterPropertiesSet() throws Exception {
		String contextName = environment.getProperty("testIt.defaultContextName", "DEFAULT");
		Operator context = contextRepository.findByOperatorName(contextName);
		
		if (context==null) {
			context = contextRepository.saveAndFlush(new Operator(contextName));
			logger.info("Created {}.", context);
		}
		createKeyTypes(context);
	}
	
	public void createKeyTypes(Operator context) throws JsonParseException, JsonMappingException, IOException{
		logger.debug("Creating Key types for {}.", context);
		ClassPathResource resource =  new ClassPathResource(keyTypePathFile+"keyTypes.json");
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

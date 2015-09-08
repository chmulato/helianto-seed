package com.iservport.client.service;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.helianto.core.domain.KeyType;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.env.Environment;
import org.springframework.core.io.ClassPathResource;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.ClientHttpRequestInterceptor;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.JsonFactory;
import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.JsonParser.Feature;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.type.TypeFactory;
import com.iservport.config.BasicAuthInterceptor;

public class RestTemplateAuth {
	
	@Inject
	private Environment env;
	
	@Inject 
	private RestTemplate rest;
	
	@Value("${helianto.basic.auth.user:helianto}") 
	private String basicAuthUser;
	
	@Value("${helianto.basic.auth.secret:helianto}") 
	private String basicAuthSecret;
	
	//allow json comments Feature.ALLOW_COMMENTS
	ObjectMapper mapper = new ObjectMapper(new JsonFactory().configure(Feature.ALLOW_COMMENTS, true)).configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
	
	@Test
	public void test() {
		RestTemplate restTemplate = new RestTemplate();
		final List<ClientHttpRequestInterceptor> interceptors = new ArrayList<ClientHttpRequestInterceptor>();
	    interceptors.add(new BasicAuthInterceptor(basicAuthUser, basicAuthSecret));
	    restTemplate.setInterceptors(interceptors);

	    ResponseEntity<String> response = (ResponseEntity<String>)
	    	restTemplate.exchange("https://primecontrol.visualstudio.com/DefaultCollection/Agile_Teste/_apis/wit/queries?$depth=1&api-version=1.0",
	    			HttpMethod.GET	, null, String.class);
	    System.err.println(response.getBody());
		
		
	}
	
	@Test
	public void testMapper() throws JsonParseException, JsonMappingException, IOException{
		ClassPathResource resource =  new ClassPathResource("/META-INF/data/keyType/keyTypes.json");
		ArrayList<KeyType> user = 
				mapper.readValue(resource.getFile(), TypeFactory.defaultInstance().constructCollectionType(List.class,  
				KeyType.class));
		for (KeyType keyType : user) {
			System.err.println("KeyCode : "+keyType.getKeyCode()
					+", KeyGroup : "+keyType.getKeyGroup()
					+", KeyName : "+keyType.getKeyName()
					+", Puspose : "+keyType.getPurpose()
					+", Synonyms : "+keyType.getSynonyms());
		}
		assertNotNull(user);
		assertTrue(user.size()==3); 
	}
	
	

}

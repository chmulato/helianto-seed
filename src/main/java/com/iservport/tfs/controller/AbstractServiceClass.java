package com.iservport.tfs.controller;

import java.util.Arrays;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

/**
 *  
 * @author Eldevan Nery Junior
 *
 */
@Service
public abstract class AbstractServiceClass{
	
	protected static final Logger logger = LoggerFactory.getLogger(AbstractServiceClass.class);
	
	protected static final String tfsUrl = ".visualstudio.com";
	
	@Inject
	protected RestTemplate restTemplate;
	
	/**
	 * HttpEntity para chamadas GET 
	 */
	protected HttpEntity<?> getHttpEntity(){
		HttpHeaders headers = new HttpHeaders();
		return new HttpEntity<>(headers);
	}

	protected HttpEntity<?> getHttpEntityJson(){
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		headers.setAccept(Arrays.asList(MediaType.APPLICATION_JSON));
		return new HttpEntity<>(headers);
	}

	
	/**
	 * 
	 * HttpEntity para chamadas POST e tipo de conteúdo {@link MediaType#APPLICATION_FORM_URLENCODED}
	 * 
	 * @param map
	 */
	protected HttpEntity<?> getHttpEntityForm(MultiValueMap<String, String> map){
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
		headers.setAccept(Arrays.asList(MediaType.APPLICATION_JSON));
		return new HttpEntity<>(map, headers);
	}
	
	/**
	 * 
	 * HttpEntity para chamadas POST e tipo de conteúdo {@link MediaType#MULTIPART_FORM_DATA}
	 * 
	 * @param data
	 * @return
	 */
	protected HttpEntity<?> getHttpEntityFormData(MultiValueMap<String, Object> data){
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.MULTIPART_FORM_DATA);
		return new HttpEntity<>(data, headers);
	}
	
	/**
	 * Realiza a chamada 'REST'
	 * 
	 * @param builder
	 * @param method
	 * @param httpEntity
	 * @param clazz
	 * 
	 */
	protected ResponseEntity<?> getResponseEntity(UriComponentsBuilder builder, HttpMethod method, HttpEntity<?> httpEntity,Class<?> clazz){
		String url = builder.build().encode().toUri().toString().replaceFirst("www.", "");
		logger.debug("uri to exchange {}", url);
		return restTemplate.exchange(url, method, httpEntity, clazz);
	}

}

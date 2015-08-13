package com.iservport.client.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.inject.Inject;

import org.junit.Test;
import org.springframework.core.env.Environment;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.ClientHttpRequestInterceptor;
import org.springframework.web.client.RestTemplate;

import com.iservport.config.BasicAuthInterceptor;

public class RestTemplateAuth {
	
	@Inject
	private Environment env;
	
	@Inject 
	private RestTemplate rest;
	
	@Test
	public void test() {
		RestTemplate restTemplate = new RestTemplate();
		final List<ClientHttpRequestInterceptor> interceptors = new ArrayList<ClientHttpRequestInterceptor>();
	    interceptors.add(new BasicAuthInterceptor("iservport", "1240micR@"));
	    restTemplate.setInterceptors(interceptors);

	    ResponseEntity<String> response = (ResponseEntity<String>)
	    	restTemplate.exchange("https://primecontrol.visualstudio.com/DefaultCollection/Agile_Teste/_apis/wit/queries?$depth=1&api-version=1.0",
	    			HttpMethod.GET	, null, String.class);
	    System.err.println(response.getBody());
	}

}

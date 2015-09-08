package com.iservport.config;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.env.Environment;
import org.springframework.http.client.ClientHttpRequestInterceptor;
import org.springframework.web.client.RestTemplate;

@Configuration
public class TestItContextConfig {

	@Inject
	private Environment environment;
	
	@Bean
	public RestTemplate restTemplate() {
		RestTemplate restTemplate = new RestTemplate();
		final List<ClientHttpRequestInterceptor> interceptors = new ArrayList<ClientHttpRequestInterceptor>();
	    interceptors.add(new BasicAuthInterceptor(environment.getProperty("tfs.username"), environment.getProperty("tfs.password")));
	    restTemplate.setInterceptors(interceptors);
		return restTemplate;
	}
	
}

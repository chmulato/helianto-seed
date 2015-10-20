package com.iservport.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.oxm.jaxb.Jaxb2Marshaller;

import com.iservport.primesw.client.PrimeSwClient;

/**
 * Configuração do endpoint SOAP para FolhaService.
 * 
 * @author mauriciofernandesdecastro
 */
@Configuration
public class PrimeSWConfig {
	
	public static final String primeSwServiceEndpoint = "https://srep.primesw.com.br/primecontrol_gateway/folha?WSDL";

	public static final String primeSwWSDL = "com.iservport.primesw.wsdl";

	@Bean
	public Jaxb2Marshaller marshaller() {
		Jaxb2Marshaller marshaller = new Jaxb2Marshaller();
		marshaller.setContextPath(primeSwWSDL);
		return marshaller;
	}

	@Bean
	public PrimeSwClient primeSwClient(Jaxb2Marshaller marshaller) {
		PrimeSwClient client = new PrimeSwClient();
		client.setDefaultUri(primeSwServiceEndpoint);
		client.setMarshaller(marshaller);
		client.setUnmarshaller(marshaller);
		return client;
	}

}
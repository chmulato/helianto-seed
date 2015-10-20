package com.iservport.home.controller;

import javax.inject.Inject;

import org.springframework.core.env.Environment;
import org.springframework.stereotype.Component;

/**
 * Entity properties.
 * 
 * @author mauriciofernandesdecastro
 */
@Component
public class TestItProperties {

    private final String defaultAlias;
    
    private final String rootPrincipal;
    
    private final String noReplyEmail;
    
    private final String rootFirstName;
    
    private final String rootLastName;
    
    private final String initialSecret;
 
    /**
     * Constructor.
     */
    @Inject
    public TestItProperties(Environment env) {
		this.defaultAlias = env.getProperty("iservport.defaultAlias", "primecontrol.com.br");
		this.rootPrincipal = env.getProperty("iservport.rootPrincipal", "everton@primecontrol.com.br");
		this.noReplyEmail = env.getProperty("iservport.noReplyEmail", "everton@primecontrol.com.br");
		this.rootFirstName = env.getProperty("iservport.rootFirstName", "Everton");
		this.rootLastName = env.getProperty("iservport.rootLastName", "Arantes");
		this.initialSecret = env.getProperty("iservport.initialSecret", "123456");
    }

	public String getDefaultAlias() {
		return defaultAlias;
	}

	public String getRootPrincipal() {
		return rootPrincipal;
	}
	
	public String getNoReplyEmail() {
		return noReplyEmail;
	}

	public String getRootFirstName() {
		return rootFirstName;
	}

	public String getRootLastName() {
		return rootLastName;
	}
    
	public String getInitialSecret() {
		return initialSecret;
	}
    
	public String getRootFullName() {
		return rootFirstName.trim()+" "+rootLastName;
	}
    
}

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
public class EntityProperties {

    private final String defaultAlias;
    
    private final String rootPrincipal;
    
    private final String rootFirstName;
    
    private final String rootLastName;
 
    /**
     * Constructor.
     */
    @Inject
    public EntityProperties(Environment env) {
		this.defaultAlias = env.getProperty("iservport.defaultAlias", "helianto.org");
		this.rootPrincipal = env.getProperty("iservport.rootPrincipal", "contact@helianto.org");
		this.rootFirstName = env.getProperty("iservport.rootFirstName", "Maurício");
		this.rootLastName = env.getProperty("iservport.rootLastName", "Fernandes de Castro");
    }

	public String getDefaultAlias() {
		return defaultAlias;
	}

	public String getRootPrincipal() {
		return rootPrincipal;
	}

	public String getRootFirstName() {
		return rootFirstName;
	}

	public String getRootLastName() {
		return rootLastName;
	}
    
}

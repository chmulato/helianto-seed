package com.iservport.home.controller;

import javax.inject.Inject;

import org.springframework.core.env.Environment;
import org.springframework.stereotype.Component;

/**
 * Application properties.
 * 
 * @author mauriciofernandesdecastro
 */
@Component
public final class ApplicationProperties {
 
    private final String contextName;
    
    private final String dataPath;
    
    private final String countryFile;
    
    private final String defaultCountry;
    
    private final String stateFile;
    
    private final String defaultState;
    
    private final String defaultCity;
    
    private final String jndiName;
    
    private final String s3AccessKey;
    
    private final String s3SecretKey;
    
    /**
     * Constructor.
     */
    @Inject
    public ApplicationProperties(Environment env) {
		this.contextName = env.getRequiredProperty("iservport.defaultContextName");
		this.dataPath = env.getProperty("iservport.dataPath", "/META-INF/data/");
		this.countryFile = env.getProperty("iservport.countryFile", "countries.xml");
		this.defaultCountry = env.getProperty("iservport.defaultCountry", "1058");
		this.stateFile = env.getProperty("iservport.stateFile", "states-1058.xml");
		this.defaultState = env.getProperty("iservport.defaultState", "PR");
		this.defaultCity = env.getProperty("iservport.defaultCity", "4106902");
		this.jndiName = env.getProperty("iservport.jndi", "jdbc/iservportDB");
		this.s3AccessKey = env.getProperty("iservport.s3.accessKey");
		this.s3SecretKey = env.getProperty("iservport.s3.secretKey");
    }

	public String getContextName() {
		return contextName;
	}

	public String getCountryFile() {
		return countryFile;
	}

	public String getCountryFilePath() {
		return dataPath+countryFile;
	}

	public String getDefaultCountry() {
		return defaultCountry;
	}

	public String getStateFile() {
		return stateFile;
	}

	public String getStateFilePath() {
		return dataPath+stateFile;
	}

	public String getDefaultState() {
		return defaultState;
	}

	public String getDefaultCityFolderPath() {
		return dataPath+defaultCountry;
	}
 
	public String getDefaultCity() {
		return defaultCity;
	}
	
	public String getJndiName() {
		return jndiName;
	}
	
	public String getS3AccessKey() {
		return s3AccessKey;
	}
	
	public String getS3SecretKey() {
		return s3SecretKey;
	}
 
}
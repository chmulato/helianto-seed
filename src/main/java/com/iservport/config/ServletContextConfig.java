package com.iservport.config;

import org.helianto.seed.AbstractServletContextConfig;
import org.helianto.seed.MultiHttpSecurityConfig;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.transaction.annotation.EnableTransactionManagement;


/**
 * Configuracao Java.
 * 
 * @author mauriciofernandesdecastro
 */
@Configuration
@EnableTransactionManagement
@Import({ RootContextConfig.class, MultiHttpSecurityConfig.class })
public class ServletContextConfig extends AbstractServletContextConfig {
	
}

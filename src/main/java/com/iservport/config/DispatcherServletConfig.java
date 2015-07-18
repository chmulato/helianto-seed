package com.iservport.config;

import org.helianto.config.AbstractDispatcherServletConfig;
import org.helianto.config.AbstractServletContextConfig;

/**
 * Dispatcher servlet.
 * 
 * @author mauriciofernandesdecastro
 */
public class DispatcherServletConfig 
	extends AbstractDispatcherServletConfig
{

	@Override
	protected Class<? extends AbstractServletContextConfig> getServletContextConfigClass() {
		return ServletContextConfig.class;
	}

}

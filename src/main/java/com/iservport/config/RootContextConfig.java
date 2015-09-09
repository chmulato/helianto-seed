package com.iservport.config;

import org.helianto.core.config.HeliantoServiceConfig;
import org.helianto.network.service.RootQueryService;
import org.helianto.seed.AbstractRootContextConfig;
import org.helianto.user.service.UserQueryService;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

/**
 * Configurações Java em geral.
 * 
 * @author mauriciofernandesdecastro
 */
@Configuration
@EnableWebMvc
@Import({HeliantoServiceConfig.class, PrimeSWConfig.class})
@ComponentScan(
		basePackages = {
				"org.helianto.*.sender"
				, "com.iservport.*.repository"
				, "com.iservport.*.service"
				, "com.iservport.*.controller"
				, "org.helianto.*.controller"
				, "com.iservport.*.sender"
		})
@EnableJpaRepositories(
		basePackages={
				"com.iservport.*.repository", "org.helianto.*.repository"
		})
public class RootContextConfig extends AbstractRootContextConfig {

	/**
	 * Override to set packages to scan.
	 */
	protected String[] getPacakgesToScan() {
		return new String[] {"org.helianto.*.domain", "com.iservport.*.domain"};
	}
	
	@Override
	public RootQueryService rootQueryService() {
		return new RootQueryService(InternalEntityType.values());
	}
			
	@Override
	public UserQueryService userQueryService() {
		return new UserQueryService(InternalUserType.values());
	}
	
}


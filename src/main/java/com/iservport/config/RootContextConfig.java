package com.iservport.config;

import javax.sql.DataSource;

import org.helianto.core.config.HeliantoServiceConfig;
import org.helianto.install.service.EntityInstallStrategy;
import org.helianto.network.service.RootQueryService;
import org.helianto.seed.AbstractRootContextConfig;
import org.helianto.user.service.UserQueryService;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.DependsOn;
import org.springframework.context.annotation.Import;
import org.springframework.context.annotation.PropertySource;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

import com.iservport.install.service.KeyTypeInstallService;
import com.iservport.install.strategy.EntityByDomainInstallStrategy;
import com.mchange.v2.c3p0.ComboPooledDataSource;

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
@PropertySource("classpath:/META-INF/app.properties")
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
	
	@Bean
	public EntityInstallStrategy entityInstallStrategy() {
		System.err.println("--------!!");
		return new EntityByDomainInstallStrategy();
	}
	
	@Bean
	@DependsOn("entityInstallStrategy")
	public KeyTypeInstallService keyTypeInstallService() {
		return new KeyTypeInstallService();
	}
	
//	@Bean
//	public DataSource dataSource() {
//		try {
//			ComboPooledDataSource ds = new ComboPooledDataSource();
//			ds.setDriverClass(this.env.getProperty("helianto.db.driverClassName", "com.mysql.jdbc.Driver"));
//			ds.setJdbcUrl(this.env.getProperty("helianto.db.url","jdbc:mysql://localhost:3306/phase23?autoreconnect=true"));
//			ds.setUser(this.env.getProperty("helianto.db.username", "root"));
//			ds.setPassword(this.env.getProperty("helianto.db.password", "admin"));
//			ds.setAcquireIncrement(5);
//			ds.setIdleConnectionTestPeriod(60);
//			ds.setMaxPoolSize(100);
//			ds.setMaxStatements(50);
//			ds.setMinPoolSize(10);
//			return ds;
//		} catch (Exception e) {
//			throw new RuntimeException(e);
//		}
//	}

}

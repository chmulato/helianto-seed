package com.iservport.testit;

import javax.inject.Inject;
import javax.persistence.EntityManagerFactory;
import javax.sql.DataSource;

import org.helianto.core.config.HeliantoServiceConfig;
import org.helianto.core.sender.NotificationSender;
import org.helianto.core.sender.UserConfirmationSender;
import org.helianto.core.test.TestDataSourceConfig;
import org.helianto.network.service.RootQueryService;
import org.helianto.seed.AbstractContextConfig;
import org.helianto.seed.OAuth2ServerConfig;
import org.helianto.seed.SecurityWebConfig;
import org.helianto.sendgrid.config.SendGridConfig;
import org.helianto.user.service.UserQueryService;
import org.hibernate.ejb.HibernatePersistence;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.orm.jpa.JpaVendorAdapter;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

import com.iservport.config.InternalEntityType;
import com.iservport.config.InternalUserType;

/**
 * Configuração de teste.
 * 
 * @author mauriciofernandesdecastro
 *
 */
@Configuration
@Import({TestDataSourceConfig.class
		, HeliantoServiceConfig.class
		, SecurityWebConfig.class
		, OAuth2ServerConfig.class
		, SendGridConfig.class})
@ComponentScan(
		basePackages = {
				"com.iservport.*.repository"
				, "com.iservport.*.service"
				, "com.iservport.*.controller"
				, "org.helianto.*.controller"
				, "com.iservport.*.sender"
		})
@EnableJpaRepositories(
		basePackages={
				"com.iservport.*.repository", "org.helianto.*.repository"
		})
@PropertySource("classpath:/test.properties")
public class TestConfig extends AbstractContextConfig {
	
	@Inject
	private DataSource dataSource;
	
	@Inject
	private JpaVendorAdapter vendorAdapter;
	
	/**
	 * Substitui a configuração original do <code>EntityManagerFactory</code>
	 * para incluir novos pacotes onde pesquisar por entidades persistentes.
	 */
	@Bean 
	public EntityManagerFactory entityManagerFactory() {
		LocalContainerEntityManagerFactoryBean bean = new LocalContainerEntityManagerFactoryBean();
		bean.setDataSource(dataSource);
		bean.setPackagesToScan("org.helianto.*.domain", "com.iservport.*.domain");
		bean.setJpaVendorAdapter(vendorAdapter);
		bean.setPersistenceProvider(new HibernatePersistence());
		bean.afterPropertiesSet();
        return bean.getObject();
	}
	
	@Autowired
	private Environment env;
	
	@Bean 
	public RootQueryService rootQueryService() {
		return new RootQueryService(InternalEntityType.values());
	}
			
	@Bean 
	public UserQueryService userQueryService() {
		System.out.println("HERE");
		return new UserQueryService(InternalUserType.values());
	}
			
	/**
	 * Password encoder.
	 */
	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}
	
	/**
	 * Notification sender.
	 */
	@Bean
	public NotificationSender notificationSender() {
		return new NotificationSender();
	}
	
	/**
	 * User confirmation sender.
	 */
	@Bean
	public UserConfirmationSender userConfirmationSender() {
		return new UserConfirmationSender(env);
	}
	
//	/**
//	 * Registra um script loader.
//	 */
//	@Bean
//	public ScriptLoader scriptLoader() {
//		return new DefaultScriptLoaderBean();
//	}
//	
//	@Bean
//	public FileStorage fileStorage() {
//		return new S3FileStorage(env.getProperty("iservport.s3.accessKey"), env.getProperty("iservport.s3.secretKey"), "iservport");
//	}
//
//	@Bean
//	public TikaConfig tikaConfig() throws TikaException, IOException {
//		return new TikaConfig();
//	}
//	
//    /**
//     * User installer bean.
//     */
//    @Bean
//    public UserInstall userInstall(){
//		return new UserInstallImpl();
//    }
//    
//    @Bean
//    public CodeFormatter codeFormatter() {
//    	return new DefaultCodeFormatter();
//    }
//    
//    @Bean
//    public Validator validator() {
//    	return new Validator() {
//			
//			@Override
//			public void validate(Object target, Errors errors) {
//			}
//			
//			@Override
//			public boolean supports(Class<?> clazz) {
//				return true;
//			}
//		};
//    }
    
}

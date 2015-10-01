package org.helianto.seed;

import javax.inject.Inject;
import javax.naming.NamingException;
import javax.persistence.EntityManagerFactory;
import javax.sql.DataSource;

import org.helianto.core.config.HeliantoServiceConfig;
import org.helianto.install.service.EntityInstallStrategy;
import org.helianto.sendgrid.config.SendGridConfig;
import org.hibernate.ejb.HibernatePersistence;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.core.env.Environment;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.orm.jpa.vendor.HibernateJpaVendorAdapter;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

import com.mchange.v2.c3p0.ComboPooledDataSource;



/**
 * Basic Java configuration. 
 * 
 * @author mauriciofernandesdecastro
 */
@Configuration
@EnableWebMvc
@Import({HeliantoServiceConfig.class, SendGridConfig.class, OAuth2ClientConfig.class})
@ComponentScan(
	basePackages = {
		"org.helianto.*.controller"
})
@EnableJpaRepositories(
    basePackages={"org.helianto.*.repository"})
public abstract class AbstractRootContextConfig extends AbstractContextConfig {
	
	@Inject
	protected Environment env;
	
	/**
	 * Override to set packages to scan.
	 */
	protected String[] getPacakgesToScan() {
		return new String[] {"org.helianto.*.domain"};
	}
	
	/**
	 * Entity manager factory.
	 */
	@Bean 
	public EntityManagerFactory entityManagerFactory() {
		HibernateJpaVendorAdapter vendor = new HibernateJpaVendorAdapter();
		vendor.setGenerateDdl(env.getProperty("helianto.sql.generateDdl", Boolean.class, Boolean.TRUE));
		vendor.setDatabasePlatform(env.getProperty("helianto.db.dialect", "org.hibernate.dialect.MySQL5Dialect"));

		LocalContainerEntityManagerFactoryBean bean = new LocalContainerEntityManagerFactoryBean();
		bean.setDataSource(dataSource());
		bean.setPackagesToScan(getPacakgesToScan());
		bean.setJpaVendorAdapter(vendor);
		bean.setPersistenceProvider(new HibernatePersistence());
		bean.afterPropertiesSet();
        return bean.getObject();
	}
	
//	/**
//	 * Simple data source.
//	 * 
//	 * @throws NamingException 
//	 * @throws IllegalArgumentException 
//	 */
//	@Bean
//	public DataSource dataSource() throws IllegalArgumentException {
//        DriverManagerDataSource dataSource = new DriverManagerDataSource();
//        
//        dataSource.setDriverClassName(env.getRequiredProperty("helianto.db.driver"));
//        dataSource.setUrl(env.getRequiredProperty("helianto.db.url"));
//        dataSource.setUsername(env.getRequiredProperty("helianto.db.username"));
//        dataSource.setPassword(env.getRequiredProperty("helianto.db.password"));
//         
//        return dataSource;
//	}
//	
	/**
	 * Data source.
	 */
	@Bean
	public DataSource dataSource() {
		try {
			ComboPooledDataSource ds = new ComboPooledDataSource();
			ds.setDriverClass(env.getProperty("helianto.jdbc.driverClassName", "org.hsqldb.jdbcDriver"));
			ds.setJdbcUrl(env.getProperty("helianto.jdbc.url", "jdbc:hsqldb:file:target/testdb/db2;shutdown=true"));
			ds.setUser(env.getProperty("helianto.jdbc.username", "sa"));
			ds.setPassword(env.getProperty("helianto.jdbc.password", ""));
			ds.setAcquireIncrement(5);
			ds.setIdleConnectionTestPeriod(60);
			ds.setMaxPoolSize(100);
			ds.setMaxStatements(50);
			ds.setMinPoolSize(10);
			return ds;
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * Subclasses must define how business entities will be named and installed.
	 */
	public abstract EntityInstallStrategy entityInstallStrategy();
	
}

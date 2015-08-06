package com.iservport.config;

import java.io.Serializable;
import java.util.Arrays;

import javax.inject.Inject;
import javax.naming.NamingException;
import javax.persistence.EntityManagerFactory;
import javax.sql.DataSource;

import org.helianto.config.AbstractRootContextConfig;
import org.helianto.core.config.HeliantoServiceConfig;
import org.helianto.core.internal.KeyNameAdapter;
import org.helianto.network.service.KeyNameAdapterArray;
import org.helianto.user.repository.UserKeyNameAdapterArray;
import org.hibernate.ejb.HibernatePersistence;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.http.MediaType;
import org.springframework.http.converter.ByteArrayHttpMessageConverter;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.ResourceHttpMessageConverter;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.http.converter.xml.MarshallingHttpMessageConverter;
import org.springframework.jndi.JndiObjectFactoryBean;
import org.springframework.orm.jpa.JpaVendorAdapter;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.web.client.RestOperations;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * Configurações Java em geral.
 * 
 * @author mauriciofernandesdecastro
 */
@Configuration
@EnableWebMvc
@Import({HeliantoServiceConfig.class})
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
public class RootContextConfig extends AbstractRootContextConfig {
	
	protected String[] getPacakgesToScan() {
		return new String[] {"org.helianto.*.domain", "com.iservport.*.domain"};
	}
	
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
		bean.setPackagesToScan(getPacakgesToScan());
		bean.setJpaVendorAdapter(vendorAdapter);
		bean.setPersistenceProvider(new HibernatePersistence());
		bean.afterPropertiesSet();
        return bean.getObject();
	}
	
	/**
	 * Para conexão com fontes de dados via JNDI.
	 * 
	 * @throws IllegalArgumentException
	 * @throws NamingException
	 */
	@Bean
	public Object jndiObjectFactoryBean() throws IllegalArgumentException, NamingException {
		JndiObjectFactoryBean jndiFactory = new JndiObjectFactoryBean();
		jndiFactory.setJndiName("jdbc/iservportDB");
		jndiFactory.setResourceRef(true);
		jndiFactory.afterPropertiesSet();
		return jndiFactory.getObject();
	}
	
	/**
	 * Cria lista de categorias da rede de negócios.
	 */
	@Bean
	public KeyNameAdapterArray keyNameAdapterArray() {
		return new KeyNameAdapterArray() {
			@Override
			public KeyNameAdapter[] values() {
				return InternalEntityType.values();
			}
		};
	}
	
	/**
	 * Cria lista de categorias de usuários.
	 */
	@Bean
	public UserKeyNameAdapterArray userKeyNameAdapterArray() {
		return new UserKeyNameAdapterArray() {
			@Override
			public KeyNameAdapter[] values() {
				return InternalUserType.values();
			}
		};
	}
	
	/**
	 * Internal entity types.
	 * 
	 * @author mauriciofernandesdecastro
	 */
	static enum InternalEntityType implements KeyNameAdapter {
		
		CUSTOMER('C', "Clientes")
		, AGENT('A', "Agentes");
		
		private char value;
		private String desc;
		
		/**
		 * Constructor.
		 * 
		 * @param value
		 */
		private InternalEntityType(char value, String desc) {
			this.value = value;
			this.desc = desc;
		}
		
		public Serializable getKey() {
			return this.value;
		}
		
		@Override
		public String getCode() {
			return value+"";
		}
		
		@Override
		public String getName() {
			return desc;
		}
	}

	/**
	 * Internal user types.
	 * 
	 * @author mauriciofernandesdecastro
	 */
	static enum InternalUserType implements KeyNameAdapter {
		
		USER('A', "Usuários")
		, ADMIN('G', "Administradores");
		
		private char value;
		private String desc;
		
		/**
		 * Constructor.
		 * 
		 * @param value
		 */
		private InternalUserType(char value, String desc) {
			this.value = value;
			this.desc = desc;
		}
		
		public Serializable getKey() {
			return this.value;
		}
		
		@Override
		public String getCode() {
			return value+"";
		}
		
		@Override
		public String getName() {
			return desc;
		}
	}

    @Bean
    public RestOperations restOperations() {
        RestTemplate rest = new RestTemplate();
        //this is crucial!
        rest.getMessageConverters().add(0, mappingJackson2HttpMessageConverter());
        rest.getMessageConverters().add(1, new ClassFormHttpMessageConverter());
        return rest;
    }

    @Bean
    public MappingJackson2HttpMessageConverter mappingJackson2HttpMessageConverter() {
        MappingJackson2HttpMessageConverter converter = new MappingJackson2HttpMessageConverter();
		ObjectMapper mapper = new ObjectMapper();
		mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
		mapper.configure(DeserializationFeature.ACCEPT_SINGLE_VALUE_AS_ARRAY, true);

		converter.setObjectMapper(mapper);
		converter.setSupportedMediaTypes(Arrays.asList(MediaType.APPLICATION_JSON,APPLICATION_JSON_UTF8));
        return converter;
    }

    private HttpMessageConverter<Object> createXmlHttpMessageConverter() {
        MarshallingHttpMessageConverter xmlConverter =
          new MarshallingHttpMessageConverter();
        
 
        return xmlConverter;
    }

	public ClassFormHttpMessageConverter() {
		this.supportedMediaTypes.add(MediaType.APPLICATION_FORM_URLENCODED);
		this.supportedMediaTypes.add(MediaType.MULTIPART_FORM_DATA);

		this.partConverters.add(new ByteArrayHttpMessageConverter());
		StringHttpMessageConverter stringHttpMessageConverter = new StringHttpMessageConverter();
		stringHttpMessageConverter.setWriteAcceptCharset(false);
		this.partConverters.add(stringHttpMessageConverter);
		this.partConverters.add(new ResourceHttpMessageConverter());
	}

}

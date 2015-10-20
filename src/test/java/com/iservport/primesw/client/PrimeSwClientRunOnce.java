package com.iservport.primesw.client;

import static org.junit.Assert.assertNotNull;

import java.util.Date;

import javax.inject.Inject;
import javax.xml.datatype.DatatypeConfigurationException;

import org.helianto.core.domain.Entity;
import org.helianto.core.domain.Identity;
import org.helianto.core.domain.KeyType;
import org.helianto.core.domain.Operator;
import org.helianto.core.domain.PublicEntity;
import org.helianto.core.domain.PublicEntityKey;
import org.helianto.core.repository.EntityRepository;
import org.helianto.core.repository.IdentityRepository;
import org.helianto.core.repository.KeyTypeRepository;
import org.helianto.core.repository.OperatorRepository;
import org.helianto.core.repository.PublicEntityKeyRepository;
import org.helianto.core.repository.PublicEntityRepository;
import org.helianto.core.test.TestDataSourceConfig;
import org.helianto.user.domain.User;
import org.helianto.user.domain.UserKey;
import org.helianto.user.repository.UserRepository;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import com.iservport.config.PrimeSWConfig;
import com.iservport.primesw.repository.UserKeyRepository;
import com.iservport.testit.TestConfig;

/**
 * 
 * @author mauriciofernandesdecastro
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes={TestDataSourceConfig.class, TestConfig.class, PrimeSWConfig.class})
@Transactional
public class PrimeSwClientRunOnce {
	
	@Inject
	private PrimeSwClient primeSwClient;

	@Inject
	private OperatorRepository contextRepository;

	@Inject
	private EntityRepository entityRepository;

	@Inject
	private PublicEntityRepository publicEntityRepository;

	@Inject
	private PublicEntityKeyRepository publicEntityKeyRepository;

	@Inject
	private IdentityRepository identiyRepository;

	@Inject
	private UserRepository userRepository;

	@Inject
	private KeyTypeRepository keyTypeRepository;

	@Inject
	private UserKeyRepository userKeyRepository;

	@Test
	public void test() throws DatatypeConfigurationException {
		assertNotNull(primeSwClient);
		primeSwClient.setDefaultUri("http://localhost:8088/mockfolhaSoapBinding");

		Operator context = contextRepository.saveAndFlush(new Operator("TEST"));
		Entity entity = entityRepository.saveAndFlush(new Entity(context, "DEFAULT"));
		PublicEntity publicEntity = publicEntityRepository.saveAndFlush(new PublicEntity(entity));
		Identity identity = identiyRepository.saveAndFlush(new Identity("principal"));
		User user = userRepository.saveAndFlush(new User(entity, identity));
		KeyType cnpj = keyTypeRepository.saveAndFlush(new KeyType(context, "CNPJ"));
		PublicEntityKey publicEntityKey = publicEntityKeyRepository.saveAndFlush(new PublicEntityKey(publicEntity, cnpj, "74.578.472/0001-62"));
		KeyType pis = keyTypeRepository.saveAndFlush(new KeyType(context, "PIS"));
		UserKey userKey = userKeyRepository.saveAndFlush(new UserKey(user, pis, "120.4186.531-0"));
		
		primeSwClient.readWorkingHours(user.getId(), new Date(1000L));
	}

}

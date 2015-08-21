package com.iservport.user.repository;

import java.io.Serializable;
import java.util.Date;

import org.helianto.core.domain.Identity;
import org.helianto.core.repository.IdentityRepository;
import org.helianto.core.test.AbstractJpaRepositoryIntegrationTest;
import org.helianto.user.domain.User;
import org.helianto.user.repository.UserRepository;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import com.iservport.testit.TestConfig;
import com.iservport.user.domain.UserJournal;

/**
 * 
 * @author mauriciofernandesdecastro
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes={TestConfig.class})
@Transactional
public class UserJournalRepositoryTests extends
	AbstractJpaRepositoryIntegrationTest<UserJournal, UserJournalRepository> {

	@Autowired
	private UserJournalRepository repository;
	
	@Autowired
	private IdentityRepository identityRepository;
	
	@Autowired
	private UserRepository userRepository;
	
	@Override
	protected UserJournalRepository getRepository() {
		return repository;
	}
	
	private Identity identity;
	
	private User user;
	
	private Date now = new Date();
	
	@Override
	protected UserJournal getNewTarget() {
		identity = identityRepository.saveAndFlush(new Identity("principal"));
		user = userRepository.saveAndFlush(new User(entity, identity));
		return new UserJournal(user, now);
	}
	
	@Override
	protected Serializable getTargetId(UserJournal target) {
		return target.getId();
	}
	
	@Override
	protected UserJournal findByKey() {
		return getRepository().findByUserAndIssueDate(user, now);
	}

}

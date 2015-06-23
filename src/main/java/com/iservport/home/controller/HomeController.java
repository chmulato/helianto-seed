package com.iservport.home.controller;

import java.util.List;

import javax.inject.Inject;

import org.helianto.core.internal.SimpleCounter;
import org.helianto.core.repository.EntityReadAdapter;
import org.helianto.core.repository.EntityRepository;
import org.helianto.user.repository.UserReadAdapter;
import org.helianto.user.repository.UserRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Controlador home.
 * 
 * @author mauriciofernandesdecastro
 */
public class HomeController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Inject
	private EntityRepository entityRepository;
	
	@Inject
	private UserRepository userRepository;
	
/**	@Inject
	private ContentKnowledgeRepository contentKnowledgeRepository;
	
	@Inject
	private ContentStatsRepository contentStatsRepository;
**/	
	/**
	 * Entity.
	 * 
	 * @param entityId
	 */
	protected EntityReadAdapter entity(int entityId) {
		EntityReadAdapter adapter = entityRepository.findAdapter(entityId);
		logger.debug("Entity found: {}.", adapter);
		return adapter;
	}
	
	/**
	 * User.
	 * 
	 * @param userId
	 */
	protected UserReadAdapter user(int userId) {
		UserReadAdapter adapter = userRepository.findAdapter(userId);
		logger.debug("User found: {}.", adapter);
		return adapter;
	}
	
	/**
	 * Knowledge user stats.
	 * 
	 * @param userId
	 */
/**	protected List<ContentKnowledgeLevelCounter> knowledgeStats(int userId) {
		return contentKnowledgeRepository.findUserContentKnowledgeByKnowlegeLevel(userId);
	}
**/	
	/**
	 * Content user stats.
	 * 
	 * @param entityId
	 */
/**	protected List<SimpleCounter> contentStats(int entityId) {
		return contentStatsRepository.countPublishedContentByEntityGroupByContentType(entityId);
	}
**/	
}

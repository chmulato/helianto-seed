package com.iservport.home.controller;

import javax.inject.Inject;

import org.helianto.core.domain.Entity;
import org.helianto.core.domain.Operator;
import org.helianto.core.repository.EntityRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

/**
 * Entity installation service.
 * 
 * @author mauriciofernandesdecastro
 */
@Service
public class LocalEntityInstallService {
	
	private static final Logger logger = LoggerFactory.getLogger(LocalEntityInstallService.class);
	
	@Inject
	private EntityRepository entityRepository;

	/**
	 * Assure the prototyped entity is persistent.
	 * 
	 * @param contextName
	 * @param entityAlias
	 * @param entityName
	 */
	public Entity installEntity(Operator context, Entity prototype) {
		if (context==null) {
			throw new IllegalArgumentException("Unable to find context");
		}
		Entity entity = entityRepository.findByContextNameAndAlias(context.getOperatorName(), prototype.getAlias());
		if (entity==null) {
			// TODO replace operator with context
			logger.info("Will install entity for context {} and alias {}.", context.getOperatorName(), prototype.getAlias());
			entity = entityRepository.saveAndFlush(new Entity(context, prototype));
		}
		else {
			logger.debug("Found existing entity for context {} and alias {}.", context.getOperatorName(), prototype.getAlias());
		}
		return entity;
	}
	
}

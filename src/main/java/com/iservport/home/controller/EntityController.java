package com.iservport.home.controller;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.helianto.core.repository.EntityReadAdapter;
import org.helianto.core.repository.EntityRepository;
import org.helianto.security.internal.UserAuthentication;
import org.helianto.security.repository.UserAuthorityReadAdapter;
import org.helianto.user.repository.UserReadAdapter;
import org.helianto.user.repository.UserRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Controlador para entidade e usuário atuais.
 * 
 * @author mauriciofernandesdecastro
 */
@Controller
@RequestMapping("/entity")
public class EntityController {

	private static final Logger logger = LoggerFactory.getLogger(EntityController.class);
	
	@Inject
	private EntityRepository entityRepository;
	
	@Inject
	private UserRepository userRepository;
	
//	@Inject
//	private UserAuthorityRepository userAuthorityRepository;
	
	@PreAuthorize("isAuthenticated()")
	@RequestMapping(value={"/", ""}, method= RequestMethod.GET)
	@ResponseBody
	public EntityReadAdapter entity(UserAuthentication userAuthentication) {
		EntityReadAdapter adapter = entityRepository.findAdapter(userAuthentication.getEntityId());
		logger.debug("Entity found: {}.", adapter);
		return adapter;
	}
	
	/**
	 * User.
	 * 
	 * @param userId
	 */
	@PreAuthorize("isAuthenticated()")
	@RequestMapping(value="/user", method= RequestMethod.GET)
	@ResponseBody
	public UserReadAdapter user(Integer userId) {
		UserReadAdapter adapter = userRepository.findAdapter(userId);
		logger.debug("User found: {}.", adapter);
		return adapter;
	}
	
	/**
	 * Authorities.
	 *
	 * GET		/entity/auth
	 */
	@PreAuthorize("isAuthenticated()")
	@RequestMapping(value={"/auth"}, method=RequestMethod.GET)
	@ResponseBody
	public List<UserAuthorityReadAdapter> auth(UserAuthentication userAuthentication) {
		return auth(userAuthentication.getUserId(), 0);
	}

	/**
	 * Authorities.
	 *
	 * GET		/entity/auth?userId
	 */
	@PreAuthorize("isAuthenticated()")
	@RequestMapping(value={"/auth"}, method=RequestMethod.GET, params="userId")
	@ResponseBody
	public List<UserAuthorityReadAdapter> auth(UserAuthentication userAuthentication
			, @RequestParam Integer userId
			, @RequestParam(required = false, defaultValue = "0") Integer pageNumber) {
		return auth(userId, pageNumber);
	}
	
	/**
	 * Authorities.
	 * 
	 * @param userId
	 * @param pageNumber
	 */
	// TODO refactor
	private List<UserAuthorityReadAdapter> auth(Integer userId, Integer pageNumber) {
		List<UserAuthorityReadAdapter> authList = new ArrayList<>();
		authList.add(new UserAuthorityReadAdapter(0, 0, "USER", "READ"));
		return authList;
	}

	
}

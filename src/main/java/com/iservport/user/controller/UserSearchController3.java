package com.iservport.user.controller;

import javax.inject.Inject;

import org.helianto.security.internal.UserAuthentication;
import org.helianto.user.domain.User;
import org.helianto.user.repository.UserReadAdapter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.iservport.user.service.UserCommand2Service;
import com.iservport.user.service.UserQuery2Service;
import com.iservport.user.service.UserQuery2Service.IdentityUserCreateResponse;

/**
 * Controlador de busca de usuários.
 * 
 * @author mauriciofernandesdecastro
 */
@RequestMapping(value={"/app/user3"})
@Controller
@PreAuthorize("isAuthenticated()")
public class UserSearchController3 
{

	private static final Logger logger = LoggerFactory.getLogger(UserSearchController3.class);
	
	@Inject
	private UserQuery2Service userQueryService;
	
	@Inject
	private UserCommand2Service userCommandService;
	
	/**
	 * Página de Usuários.
	 * 
	 * GET		/app/user/
	 */
	@RequestMapping(value={"/", ""}, method=RequestMethod.GET)
	public String home(UserAuthentication userAuthentication, Model model, @RequestParam(required=false) Integer externalId) {
		logger.info("User id: {} loading user page.", userAuthentication.getUserId());
		model.addAttribute("baseName", "user");
		if (externalId!=null) {
			model.addAttribute("externalId", externalId);
		}
		return "frame-bootstrap";
	}
		
	
	//// Usuários ////


	/**
	 * Novo usuário.
	 *
	 * POST		/app/user/?userGroupId
	 */
	@RequestMapping(value={"/", ""}, method=RequestMethod.POST, params={"userGroupId"})
	@ResponseBody
	public UserReadAdapter userNew(UserAuthentication userAuthentication, @RequestParam Integer userGroupId) {
		return new UserReadAdapter(0, userGroupId, "", "", 'A', 'N');
	}

	/**
	 * Usuário.
	 *
	 * GET 	/app/user/?userId
	 */
	@RequestMapping(value={"/", ""}, method=RequestMethod.GET, params={"userId"})
	@ResponseBody
	public User userOne(@RequestParam Integer userId) {
		return userQueryService.userOne(userId);
	}

	/**
	 * Atualizar usuário.
	 *
	 * PUT 	/app/user/
	 */
	@RequestMapping(value={"/", ""}, method=RequestMethod.PUT, consumes=MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public User user(UserAuthentication userAuthentication, @RequestBody UserReadAdapter command) {
		return userCommandService.user(userAuthentication, command);
	}

	/**
	 * Ativa usuário.
	 *
	 * PUT 	/app/user/
	 */
	@RequestMapping(value={"/activate"}, method=RequestMethod.PUT, consumes=MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public User userActivate(UserAuthentication userAuthentication, @RequestBody User command) {
		return userCommandService.userActivate(userAuthentication, command);
	}

	/**
	 * Verifica se irá criar novo usuário.
	 *
	 * POST		/app/user/group?qualifierValue
	 */
	@RequestMapping(value={"/", ""}, method=RequestMethod.POST, params={"search","novo"})
	@ResponseBody
	public IdentityUserCreateResponse userSearchNew(UserAuthentication userAuthentication, @RequestParam String search) {
		return userQueryService.createNewUser(search, userAuthentication.getEntityId());
	}

}

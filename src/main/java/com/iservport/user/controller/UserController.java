package com.iservport.user.controller;

import java.util.List;

import javax.inject.Inject;

import org.helianto.core.internal.QualifierAdapter;
import org.helianto.security.internal.UserAuthentication;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.iservport.user.service.UserCommandService;
import com.iservport.user.service.UserQueryService;


/**
 * Controlador de usuários.
 * 
 * @author mauriciofernandesdecastro
 */
@Controller
@RequestMapping("/api/user")
public class UserController {

	@Inject
	private UserQueryService userQueryService;
	
	@Inject
	private UserCommandService userCommandService;
	
	/**
	 * Lista qualificadores.
	 * 
	 * GET		/app/user/qualifier
	 */
	@PreAuthorize("isAuthenticated()")
	@RequestMapping(value={"/qualifier"}, method=RequestMethod.GET)
	@ResponseBody                                                           
	public List<QualifierAdapter> qualifier(UserAuthentication userAuthentication) {
		return userQueryService.qualifierList(userAuthentication.getEntityId());
	}
	
}

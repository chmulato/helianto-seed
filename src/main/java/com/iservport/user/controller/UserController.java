package com.iservport.user.controller;

import java.util.List;

import javax.inject.Inject;

import org.helianto.core.internal.QualifierAdapter;
import org.helianto.security.internal.UserAuthentication;
import org.helianto.user.repository.UserReadAdapter;
import org.springframework.data.domain.Page;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.iservport.user.service.UserCommandService;
import com.iservport.user.service.UserQueryService;


/**
 * User controller.
 * 
 * @author mauriciofernandesdecastro
 */
@Controller
@RequestMapping("/api/user")
@PreAuthorize("isAuthenticated()")
public class UserController {

	@Inject
	private UserQueryService userQueryService;
	
	@Inject
	private UserCommandService userCommandService;
	
	/**
	 * List qualifiers.
	 * 
	 * GET		/api/user/qualifier
	 */
	@RequestMapping(value={"/qualifier"}, method=RequestMethod.GET)
	@ResponseBody                                                           
	public List<QualifierAdapter> qualifier(UserAuthentication userAuthentication) {
		return userQueryService.qualifierList(userAuthentication.getEntityId());
	}
	
	/**
	 * List users.
	 * 
	 * GET		/api/user/?userType&userStates&pageNumber
	 */
	@RequestMapping(value={"/"}, method=RequestMethod.GET, params={"userType"})
	@ResponseBody                                                           
	public Page<UserReadAdapter> userList(UserAuthentication userAuthentication, @RequestParam Character userType
			, @RequestParam String userStates, @RequestParam(defaultValue="0") Integer pageNumber) {
		return userQueryService.userList(userAuthentication.getEntityId(), userType, userStates, pageNumber);
	}
	
}

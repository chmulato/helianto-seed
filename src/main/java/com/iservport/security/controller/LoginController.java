package com.iservport.security.controller;

import org.helianto.core.domain.Entity;
import org.helianto.core.repository.EntityRepository;

import org.helianto.security.internal.UserAuthentication;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Controlador de login.
 * 
 * @author mauriciofernandesdecastro
 */
@Controller
@RequestMapping(value={"/login"})
public class LoginController {
	
	@Autowired 
	private EntityRepository entityRepository;
	
	/**
	 * Apresenta tela de login.
	 */
	@RequestMapping(value={"/", ""}, method=RequestMethod.GET)
	public String signin( String error, Model model, @RequestParam(required = false) String logout ) {
		model.addAttribute("baseName", "security");
		if (error!=null && error.equals("1")) {
			model.addAttribute("error", "1");
		}
		return "/security/login";
	}

	
	/**

	 * Logout.
	 * 
	 * GET		/logout
	 */
	@PreAuthorize("isAuthenticated()")
	@RequestMapping(value="/logout",method= RequestMethod.GET)
	public String logout(UserAuthentication userAuthentication) {
		SecurityContextHolder.clearContext();	
		return "redirect:/";
	}
	
	/**
      refs/remotes/iserv/master
	 * Logotipo de abertura.
	 * 
	 * @param model
	 */
	@RequestMapping(value="/logo", method=RequestMethod.GET)
	@ResponseBody
	public String logo() {
		String logo = "/images/logo/logo-iserv.png";
	
		Entity entity = entityRepository.findOne(1);
		if (entity!=null && !entity.getExternalLogoUrl().isEmpty()) {
			logo =  entity.getExternalLogoUrl();
		}
		
		return "{\"logo\":\""+logo+"\"}";
	}
	
	
}

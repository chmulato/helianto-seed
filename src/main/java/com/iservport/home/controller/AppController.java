package com.iservport.home.controller;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Controlador das páginas iniciais do aplicativo.
 * 
 * @author mauriciofernandesdecastro
 */
@Controller
@RequestMapping("/")
@PreAuthorize("isAuthenticated()")
public class AppController {
	
	/**
	 * Menu home.
	 * 
	 * @param model
	 */
	@RequestMapping(value={"/", ""}, method=RequestMethod.GET)
	public String empty(Model model) {
		return home(model);
	}

	/**
	 * Menu home.
	 * 
	 * @param model
	 */
	@RequestMapping(value={"/home", "/home/"}, method=RequestMethod.GET)
	public String home(Model model) {
		return response(model, "home");
	}

	/**
	 * Menu projetos.
	 * 
	 * @param model
	 */
	@RequestMapping(value={"/report", "/report/"}, method=RequestMethod.GET)
	public String report(Model model) {
		return response(model, "report");
	}
	
	/**
	 * Menu Execução.
	 * 
	 * @param model
	 */
	@RequestMapping(value={"/run", "/run/"}, method=RequestMethod.GET)
	public String run(Model model) {
		return response(model, "run");
	}
	
	/**
	 * Menu Bugs.
	 * 
	 * @param model
	 */
	@RequestMapping(value={"/action", "/action/"}, method=RequestMethod.GET)
	public String action(Model model) {
		return response(model, "action");
	}

	/**
	 * Menu Usuários.
	 * 
	 * @param model
	 */
	@RequestMapping(value={"/user", "/user/"}, method=RequestMethod.GET)
	public String user(Model model) {
		return response(model, "user");
	}

	/**
	 * Menu Categorias.
	 * 
	 * @param model
	 */
	@RequestMapping(value={"/category", "/category/"}, method=RequestMethod.GET)
	public String category(Model model) {
		return response(model, "category");
	}
	
	/**
	 * Default response.
	 * 
	 * @param model
	 * @param baseName
	 */
	protected String response(Model model, String baseName) {
		model.addAttribute("baseName", baseName);
		return "frame-bootstrap";
	}
	
}

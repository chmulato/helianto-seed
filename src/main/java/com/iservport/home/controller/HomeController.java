package com.iservport.home.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Controlador home.
 * 
 * @author mauriciofernandesdecastro
 */
@Controller
@RequestMapping("/app")
public class HomeController {
	
	@RequestMapping(value="/home", method=RequestMethod.GET)
	public String home(Model model) {
		model.addAttribute("baseName", "home");
		return "frame-bootstrap";
	}

}

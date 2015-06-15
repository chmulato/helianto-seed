package com.iservport.action.controller;

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
public class ActionController {
	
	@RequestMapping(value="/action", method=RequestMethod.GET)
	public String action(Model model) {
		model.addAttribute("baseName", "action");
		return "frame-bootstrap";
	}

}

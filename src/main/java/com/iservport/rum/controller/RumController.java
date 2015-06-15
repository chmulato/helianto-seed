package com.iservport.rum.controller;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;



/**
 * Controlador de ordens.
 * 
 * @author mauriciofernandesdecastro
 */
@Controller
@RequestMapping("/app")
public class RumController {
	
	@RequestMapping(value="/rum", method=RequestMethod.GET)
	public String rum(Model model) {
		model.addAttribute("baseName", "rum");
		return "frame-bootstrap";
	}

	
}

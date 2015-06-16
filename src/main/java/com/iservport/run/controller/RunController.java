package com.iservport.run.controller;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;



/**
 * Controlador de execução.
 * 
 * @author mauriciofernandesdecastro
 */
@Controller
@RequestMapping("/app")
public class RunController {
	
	@RequestMapping(value="/run", method=RequestMethod.GET)
	public String run(Model model) {
		model.addAttribute("baseName", "run");
		return "frame-bootstrap";
	}

	
}

package com.iservport.report.controller;


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
public class ReportController {
	
	@RequestMapping(value="/report", method=RequestMethod.GET)
	public String report(Model model) {
		model.addAttribute("baseName", "report");
		return "frame-bootstrap";
	}
	
}

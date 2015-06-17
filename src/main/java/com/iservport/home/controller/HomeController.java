package com.iservport.home.controller;

import org.helianto.security.internal.UserAuthentication;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
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
@RequestMapping("/api/home")
public class HomeController {
	
}

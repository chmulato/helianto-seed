package com.iservport.home.controller;

import java.util.List;

import javax.inject.Inject;

import org.helianto.security.internal.UserAuthentication;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.iservport.report.domain.Project;
import com.iservport.report.service.ProjectQueryService;

/**
 * Controlador Home
 * 
 * @author mauriciofernandesdecastro
 */
@RestController
@RequestMapping("/api/home")
@PreAuthorize("isAuthenticated()")
public class HomeController {
	
	@Inject
	private ProjectQueryService projectQueryService;

	/**
	 * Lista projetos por identidade.
	 *
	 * GET       /api/home/project
	 */
	@RequestMapping(value={"/project"}, method=RequestMethod.GET)
	public List<Project> project(UserAuthentication userAuthentication) {
		return projectQueryService.projectList(userAuthentication.getUserId() ,userAuthentication.getEntityId(), userAuthentication.getIdentityId());
	}
	
	/**
	 * Atualizar projeto com checkin.
	 *
	 * PUT 	/api/home/project
	 */
	@RequestMapping(value={"/project"}, method=RequestMethod.PUT, consumes="application/json")
	public Project projectNew(UserAuthentication userAuthentication, @RequestBody Project project) {
		return projectQueryService.projectChecked(userAuthentication.getUserId(), project);
	}
	
}

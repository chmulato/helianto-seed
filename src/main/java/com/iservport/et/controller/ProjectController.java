package com.iservport.et.controller;

import javax.inject.Inject;

import org.helianto.security.internal.UserAuthentication;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.iservport.et.domain.ETProject;
import com.iservport.et.service.ETProjectCommandService;
import com.iservport.et.service.ETProjectQueryService;

/**
 * Projects controller.
 * 
 * @author mauriciofernandesdecastro
 */
@Controller
@RequestMapping("/api/project")
@PreAuthorize("isAuthenticated()")
public class ProjectController {
	
	@Inject
	private ETProjectQueryService projectQueryService;

	@Inject
	private ETProjectCommandService projectCommandService;

	/**
	 * Get a project.
	 *
	 * GET /{id}
	 */
	@RequestMapping(value = { "/projectCode" }, method = RequestMethod.GET)
	@ResponseBody
	public ETProject projectPipe(UserAuthentication userAuthentication, @PathVariable String projectCode) {
		return projectQueryService.project(projectCode);
	}

}

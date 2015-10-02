package com.iservport.report.controller;

import java.util.List;

import javax.inject.Inject;

import org.helianto.core.internal.QualifierAdapter;
import org.helianto.security.internal.UserAuthentication;
import org.springframework.data.domain.Page;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.iservport.report.domain.Project;
import com.iservport.report.service.ProjectCommandService;
import com.iservport.report.service.ProjectQueryService;

/**
 * Controlador de projetos
 * 
 * @author mauriciofernandesdecastro
 */
@RestController
@RequestMapping("/api/report/project")
@PreAuthorize("isAuthenticated()")
public class ProjectSearchController {

	@Inject 
	private ProjectCommandService projectCommandService;
	
	@Inject 
	private ProjectQueryService projectQueryService;
	
	// Qualificadores
	
	/**
	 * Lista qualificadores.
	 * 
	 * GET		/api/report/project/qualifier
	 */
	@RequestMapping(value={"/qualifier"}, method=RequestMethod.GET)
	public List<QualifierAdapter> qualifier(UserAuthentication userAuthentication) {
		return projectQueryService.qualifier(userAuthentication.getEntityId());
	}
	
	// Projetos

	/**
	 * Lista projetos por categoria.
	 *
	 * GET       /api/report/project?qualifierValue
	 */
	@RequestMapping(method=RequestMethod.GET, params={"qualifierValue"})
	public Page<Project> project(UserAuthentication userAuthentication
			, @RequestParam Integer qualifierValue, @RequestParam(defaultValue="0") Integer pageNumber
			, @RequestParam(defaultValue="25") Integer itemsPerPage) {
		return projectQueryService.projectPage(userAuthentication.getEntityId(), qualifierValue, pageNumber, itemsPerPage);
	}

	/**
	 * Novo Projeto.
	 *
	 * POST		/api/report/project?qualifierValue
	 */
	@RequestMapping(method=RequestMethod.POST , params={"qualifierValue"})
	public Project projectNew(UserAuthentication userAuthentication, @RequestParam Integer qualifierValue) {
		return new Project(userAuthentication.getEntityId(), userAuthentication.getIdentityId(), qualifierValue, 0, 0);
	}

	/**
	 * Projeto.
	 *
	 * GET 	/api/report/project?projectId
	 */
	@RequestMapping(method=RequestMethod.GET, params={"projectId"})
	public Project folderOpen(UserAuthentication userAuthentication, @RequestParam Integer projectId) {
		return  projectQueryService.project(userAuthentication.getEntityId(), projectId);
	}	

	/**
	 * Atualizar projeto.
	 *
	 * PUT 	/api/report/project
	 */
	@RequestMapping(method=RequestMethod.PUT, consumes="application/json")
	public Project projectNew(UserAuthentication userAuthentication, @RequestBody Project command) {
		return  projectCommandService.project(userAuthentication.getUserId(), command);
	}

}

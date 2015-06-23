package com.iservport.report.controller;

import javax.inject.Inject;

import org.helianto.security.internal.UserAuthentication;
import org.helianto.task.repository.FolderReadAdapter;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.iservport.report.service.ReportCommandService;
import com.iservport.report.service.ReportQueryService;


/**
 * controlador de projetos
 * 
 * @author mauriciofernandesdecastro
 */
@Controller
@RequestMapping("/api/report")
public class ReportSearchController {
	
	@Inject ReportCommandService reportCommandService;
	
	@Inject ReportQueryService reportQueryService;
	
	
	/**
	 * Atualizar pasta.
	 *
	 * PUT 	/app/report/folder
	 */
	@PreAuthorize("isAuthenticated()")
	@RequestMapping(value={"/folder"}, method=RequestMethod.PUT, consumes="application/json")
	@ResponseBody
	public FolderReadAdapter folder(UserAuthentication userAuthentication, @RequestBody FolderReadAdapter command) {
		//System.err.print(command);
		System.err.printf(command.getFolderCode());
		System.err.printf(command.getFolderName());
		System.err.printf(command.getNumberPrefix());
		System.err.printf(command.getNumberSuffix());
	

	
		return  reportCommandService.folder(command, userAuthentication);
	}

}
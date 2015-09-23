package com.iservport.report.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.helianto.core.internal.QualifierAdapter;
import org.helianto.security.internal.UserAuthentication;
import org.helianto.task.repository.FolderReadAdapter;
import org.helianto.task.repository.ReportAdapter;
import org.helianto.task.repository.ReportPhaseAdapter;
import org.helianto.user.domain.User;
import org.helianto.user.service.UserQueryService;
import org.joda.time.DateTime;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.data.domain.Page;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.iservport.report.domain.Project;
import com.iservport.report.domain.ReportBaseLine;
import com.iservport.report.domain.ReportData;
import com.iservport.report.repository.ProjectReadAdapter;
import com.iservport.report.repository.ReportReviewReadAdapter;
import com.iservport.report.repository.StaffMemberReadAdapter;
import com.iservport.report.service.ProjectCommandService;
import com.iservport.report.service.ReportBaseLineCommandService;
import com.iservport.report.service.ReportBaseLineQueryService;
import com.iservport.report.service.ReportCommandService;
import com.iservport.report.service.ReportDataCommandService;
import com.iservport.report.service.ReportDataQueryService;
import com.iservport.report.service.ReportQueryService;


/**
 * controlador de projetos
 * 
 * @author mauriciofernandesdecastro
 */
@RestController
@RequestMapping("/api/report/phase")
@PreAuthorize("isAuthenticated()")
public class ReportPhaseController {
	
	private static final Logger logger = LoggerFactory.getLogger(ReportPhaseController.class);

	@Inject 
	private ReportCommandService reportCommandService;
		
	@Inject 
	private ReportQueryService reportQueryService;
		
	/**
	 * Seleciona reportPhase por folder id.
	 *
	 * GET       /api/report/phase?folderId
	 */

	@RequestMapping(method=RequestMethod.GET, params={"folderId"})
	public ReportPhaseAdapter reportPhaseOne(UserAuthentication userAuthentication, @RequestParam Integer folderId) {
		return reportQueryService.reportPhaseOpen(folderId);
	}
	
	/**
	 * Novo reportPhase.
	 *
	 * POST		/api/report/phase?folderId
	 */

	@RequestMapping(method=RequestMethod.POST , params={"folderId"})
	public ReportPhaseAdapter reportPhaseNew(UserAuthentication userAuthentication, @RequestParam Integer folderId) {
		return reportCommandService.reportPhaseNew(folderId);
	}
	
	/**
	 * Atualiza reportPhase.
	 *
	 * PUT		/api/report
	 */

	@RequestMapping(method=RequestMethod.PUT , consumes="application/json")
	public ReportPhaseAdapter reportPhase(UserAuthentication userAuthentication, @RequestBody ReportPhaseAdapter command) {
		return reportCommandService.reportPhase(command);
	}
	
}

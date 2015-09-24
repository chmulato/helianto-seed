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
@RequestMapping("/api/report/staff")
@PreAuthorize("isAuthenticated()")
public class ReportStaffController {
	
	private static final Logger logger = LoggerFactory.getLogger(ReportStaffController.class);

	@Inject 
	private ReportCommandService reportCommandService;
		
	@Inject 
	private ReportQueryService reportQueryService;
	
	@Inject 
	private UserQueryService userQueryService;
	
	/**
	 * Lista membros da equipe.
	 *
	 * GET		/api/report/staff?folderId
	 */
	
	@RequestMapping(method=RequestMethod.GET, params={"folderId"})
	public Page<StaffMemberReadAdapter> staffMember(@RequestParam Integer folderId, 
			@RequestParam(required = false, defaultValue = "0") Integer pageNumber) {
		return reportQueryService.staffMemberList(folderId, pageNumber);
	}
	
	
	/**
	 * Novo membro da equipe.
	 *
	 * POST		/api/report/staff?folderId
	 */
	
	@RequestMapping(method=RequestMethod.POST , params={"folderId"})
	public StaffMemberReadAdapter staffMemberNew(@RequestParam Integer folderId) {
		return reportCommandService.staffMemberNew(folderId);
	}
	
	/**
	 * Membro da equipe.
	 *
	 * GET 	/app/report/staff?staffMemberId
	 */
	
	@RequestMapping(method=RequestMethod.GET, params={"staffMemberId"})
	public StaffMemberReadAdapter staffMemberOpen(@RequestParam Integer staffMemberId) {
		return reportQueryService.staffMemberOpen(staffMemberId);
	}
	
	/**
	 * Remove membro da equipe.
	 *
	 * DELETE 	/api/report/staffMember?staffMemberId
	 */
	
	@RequestMapping(method=RequestMethod.DELETE, params={"targetId"})
	public String staffMemberDelete(@RequestParam Integer targetId) {
		return reportCommandService.staffMemberDelete(targetId);
	}
	
	/**
	 * Atualizar membro da equipe.
	 *
	 * PUT 	/api/report/staff
	 */
	@RequestMapping(method=RequestMethod.PUT, consumes="application/json")
	public StaffMemberReadAdapter staffMember(@RequestBody StaffMemberReadAdapter command) {
		return reportCommandService.staffMember(command);
	}
	
	@RequestMapping(method=RequestMethod.GET, params={"users"})
	public List<User> getUserList(UserAuthentication userAuthentication) {
		return reportQueryService.getUserList(userAuthentication);
	}
	
	@RequestMapping(method=RequestMethod.GET, params={"users", "search", "searchFolderId"})
	public List<User> getUserList(UserAuthentication userAuthentication, @RequestParam String search, @RequestParam Integer searchFolderId) {
		return reportQueryService.getUserListSearch(userAuthentication, search, searchFolderId);
	}
	
	@RequestMapping(method=RequestMethod.GET, params={"users", "userId"})
	public User getUser(UserAuthentication userAuthentication, @RequestParam Integer userId) {
		return userQueryService.user(userAuthentication.getEntityId(), userId);
	}
		
}

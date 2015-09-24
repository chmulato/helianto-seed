package com.iservport.report.controller;

import java.util.List;

import javax.inject.Inject;

import org.helianto.security.internal.UserAuthentication;
import org.helianto.task.domain.StaffMember;
import org.helianto.user.domain.User;
import org.helianto.user.service.UserQueryService;
import org.springframework.data.domain.Page;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.iservport.report.service.ReportStaffCommandService;
import com.iservport.report.service.ReportStaffQueryService;


/**
 * Controlador de equipe do projeto.
 * 
 * @author mauriciofernandesdecastro
 */
@RestController
@RequestMapping("/api/report/staff")
@PreAuthorize("isAuthenticated()")
public class ReportStaffController {
	
	@Inject 
	private ReportStaffCommandService reportStaffCommandService;
		
	@Inject 
	private ReportStaffQueryService reportStaffQueryService;
	
	@Inject 
	private UserQueryService userQueryService;
	
	/**
	 * Lista membros da equipe.
	 *
	 * GET		/api/report/staff?folderId
	 */
	@RequestMapping(method=RequestMethod.GET, params={"folderId"})
	public Page<StaffMember> staffMember(@RequestParam Integer folderId, 
			@RequestParam(required = false, defaultValue = "0") Integer pageNumber) {
		return reportStaffQueryService.staffMemberList(folderId, pageNumber);
	}
	
	/**
	 * Novo membro da equipe.
	 *
	 * POST		/api/report/staff?folderId
	 */
	@RequestMapping(method=RequestMethod.POST , params={"folderId"})
	public StaffMember staffMemberNew(@RequestParam Integer folderId) {
		StaffMember staffMember = new StaffMember();
		staffMember.setReportFolderId(folderId);
		return staffMember;
	}
	
	/**
	 * Membro da equipe.
	 *
	 * GET 	/app/report/staff?staffMemberId
	 */
	
	@RequestMapping(method=RequestMethod.GET, params={"staffMemberId"})
	public StaffMember staffMemberOpen(@RequestParam Integer staffMemberId) {
		return reportStaffQueryService.staffMemberOpen(staffMemberId);
	}
	
	/**
	 * Atualizar membro da equipe.
	 *
	 * PUT 	/api/report/staff
	 */
	@RequestMapping(method=RequestMethod.PUT, consumes="application/json")
	public StaffMember staffMember(@RequestBody StaffMember command) {
		return reportStaffCommandService.staffMember(command);
	}
	
	/**
	 * Remove membro da equipe.
	 *
	 * DELETE 	/api/report/staffMember?staffMemberId
	 */
	@RequestMapping(method=RequestMethod.DELETE, params={"targetId"})
	public String staffMemberDelete(@RequestParam Integer targetId) {
		return reportStaffCommandService.staffMemberDelete(targetId);
	}
	
	/**
	 * Lista usuários.
	 * 
	 * @param userAuthentication
	 */
	@RequestMapping(method=RequestMethod.GET, params={"users"})
	public List<User> getUserList(UserAuthentication userAuthentication) {
		return reportStaffQueryService.getUserList(userAuthentication);
	}
	
	/**
	 * Pesquisa usuários.
	 * 
	 * @param userAuthentication
	 * @param search
	 * @param searchFolderId
	 */
	@RequestMapping(method=RequestMethod.GET, params={"users", "search", "searchFolderId"})
	public List<User> getUserList(UserAuthentication userAuthentication, @RequestParam String search, @RequestParam Integer searchFolderId) {
		return reportStaffQueryService.getUserListSearch(userAuthentication, search, searchFolderId);
	}
	
	/**
	 * Retorna um usuário.
	 * 
	 * @param userAuthentication
	 * @param userId
	 */
	@RequestMapping(method=RequestMethod.GET, params={"users", "userId"})
	public User getUser(UserAuthentication userAuthentication, @RequestParam Integer userId) {
		return userQueryService.user(userAuthentication.getEntityId(), userId);
	}
		
}

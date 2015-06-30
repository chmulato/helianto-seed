package com.iservport.report.controller;

import java.util.List;

import javax.inject.Inject;

import org.helianto.core.internal.QualifierAdapter;
import org.helianto.security.internal.UserAuthentication;
import org.helianto.task.repository.FolderReadAdapter;
import org.helianto.task.repository.ReportAdapter;
import org.helianto.task.repository.ReportPhaseAdapter;
import org.helianto.user.repository.UserReadAdapter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.iservport.report.repository.StaffMemberReadAdapter;
import com.iservport.report.service.ReportCommandService;
import com.iservport.report.service.ReportQueryService;
import com.iservport.user.service.UserQueryService;


/**
 * controlador de projetos
 * 
 * @author mauriciofernandesdecastro
 */
@Controller
@RequestMapping("/api/report")
public class ReportSearchController {
	
	 private static final Logger logger = LoggerFactory.getLogger(ReportSearchController.class);

	@Inject ReportCommandService reportCommandService;
	
	@Inject ReportQueryService reportQueryService;
	
	@Inject UserQueryService userQueryService;
	
	/**
	 * Atualizar pasta.
	 *
	 * PUT 	/api/report/folder
	 */
	
	@PreAuthorize("isAuthenticated()")
	@RequestMapping(value={"/folder"}, method=RequestMethod.PUT, consumes="application/json")
	@ResponseBody
	public FolderReadAdapter folder(UserAuthentication userAuthentication, @RequestBody FolderReadAdapter command) {
	
		return  reportCommandService.folder(command, userAuthentication);
	}

	// Qualificadores
	
	/**
	 * Lista qualificadores.
	 * 
	 * GET		/api/report/qualifier
	 */
	@PreAuthorize("isAuthenticated()")
	@RequestMapping(value={"/qualifier"}, method=RequestMethod.GET)
	@ResponseBody                                                           
	public List<QualifierAdapter> qualifier(UserAuthentication userAuthentication) {
		return reportQueryService.qualifier(userAuthentication.getEntityId());
	}
	
	// Pastas

		/**
		 * Lista pastas por qualificador.
		 *
		 * GET       /api/report/folder?qualifierValue
		 */
		@PreAuthorize("isAuthenticated()")
		@RequestMapping(value={"/folder"}, method=RequestMethod.GET, params={"qualifierValue"})
		@ResponseBody
		public Page<FolderReadAdapter> folder(UserAuthentication userAuthentication, @RequestParam Integer qualifierValue, @RequestParam(defaultValue="0") Integer pageNumber) {
			return reportQueryService.folder(userAuthentication.getEntityId(), qualifierValue, pageNumber);
		}

		/**
		 * Nova pasta.
		 *
		 * POST		/api/report/folder?qualifierValue
		 */
		@PreAuthorize("isAuthenticated()")
		@RequestMapping(value={"/folder"}, method=RequestMethod.POST , params={"qualifierValue"})
		@ResponseBody
		public FolderReadAdapter folderNew(@RequestParam Integer qualifierValue) {
			return reportCommandService.folderNew(qualifierValue);
		}

		/**
		 * Pasta.
		 *
		 * GET 	/api/report/folder?folderId
		 */
		@PreAuthorize("isAuthenticated()")
		@RequestMapping(value={"/folder"}, method=RequestMethod.GET, params={"folderId"})
		@ResponseBody
		public FolderReadAdapter folderOpen(@RequestParam Integer folderId) {
			return reportCommandService.folderOpen(folderId);
		}

		/**
		 * Lista reports por pastas.
		 *
		 * GET       /api/report?id
		 */
		@PreAuthorize("isAuthenticated()")
		@RequestMapping(value={"/", ""}, method=RequestMethod.GET, params={"id"})
		@ResponseBody
		public ReportAdapter reportOne(UserAuthentication userAuthentication, @RequestParam Integer id) {
			return reportQueryService.reportOne(id);
		}
		
		/**
		 * return reporter from report.
		 *
		 * GET       /api/report?reportId
		 */
		@PreAuthorize("isAuthenticated()")
		@RequestMapping(value={"/", ""}, method=RequestMethod.GET, params={"reportId"})
		@ResponseBody
		public String reporter(@RequestParam Integer reportId) {
			return "{\"reporterId\":"+reportQueryService.reporter(reportId)+"}";
		}
		
		/**
		 * seleciona reportPhase por id.
		 *
		 * GET       /api/report/phase?id
		 */
		@PreAuthorize("isAuthenticated()")
		@RequestMapping(value={"/phase"}, method=RequestMethod.GET, params={"id"})
		@ResponseBody
		public ReportPhaseAdapter reportPhaseOne(UserAuthentication userAuthentication, @RequestParam Integer id) {
			return reportQueryService.reportPhaseOpen(id);
		}
		
		/**
		 * Atualiza reportPhase.
		 *
		 * PUT		/api/report
		 */
		@PreAuthorize("isAuthenticated()")
		@RequestMapping(value={"/phase"}, method=RequestMethod.PUT , consumes="application/json")
		@ResponseBody
		public ReportPhaseAdapter reportPhase(UserAuthentication userAuthentication, @RequestBody ReportPhaseAdapter command) {
			return reportCommandService.reportPhase(command);
		}
		
		/**
		 * Novo reportPhase.
		 *
		 * POST		/api/report/phase?folderId
		 */
		@PreAuthorize("isAuthenticated()")
		@RequestMapping(value={"/phase"}, method=RequestMethod.POST , params={"folderId"})
		@ResponseBody
		public ReportPhaseAdapter reportPhaseNew(UserAuthentication userAuthentication, @RequestParam Integer folderId) {
			return reportCommandService.reportPhaseNew(folderId);
		}
		
		// Membros da equipe

		/**
		 * Lista membros da equipe.
		 *
		 * GET		/api/report/staffMember?folderId
		 */
		@PreAuthorize("isAuthenticated()")
		@RequestMapping(value={"/staffMember"}, method=RequestMethod.GET, params={"folderId"})
		@ResponseBody
		public Page<StaffMemberReadAdapter> staffMember(@RequestParam Integer folderId, 
				@RequestParam(required = false, defaultValue = "0") Integer pageNumber) {
			return reportQueryService.staffMemberList(folderId, pageNumber);
		}
		
		/**
		 * Novo membro da equipe.
		 *
		 * POST		/api/report/staffMember?folderId
		 */
		@PreAuthorize("isAuthenticated()")
		@RequestMapping(value={"/staffMember"}, method=RequestMethod.POST , params={"folderId"})
		@ResponseBody
		public StaffMemberReadAdapter staffMemberNew(@RequestParam Integer folderId) {
			return reportCommandService.staffMemberNew(folderId);
		}

		/**
		 * Membro da equipe.
		 *
		 * GET 	/app/report/staffMember?staffMemberId
		 */
		@PreAuthorize("isAuthenticated()")
		@RequestMapping(value={"/staffMember"}, method=RequestMethod.GET, params={"staffMemberId"})
		@ResponseBody
		public StaffMemberReadAdapter staffMemberOpen(@RequestParam Integer staffMemberId) {
			return reportQueryService.staffMemberOpen(staffMemberId);
		}

		/**
		 * Remove membro da equipe.
		 *
		 * DELETE 	/api/report/staffMember?staffMemberId
		 */
		@PreAuthorize("isAuthenticated()")
		@RequestMapping(value={"/staffMember"}, method=RequestMethod.DELETE, params={"targetId"})
		@ResponseBody
		public String staffMemberDelete(@RequestParam Integer targetId) {
			return reportCommandService.staffMemberDelete(targetId);
		}

		/**
		 * Atualizar membro da equipe.
		 *
		 * PUT 	/api/report/staffMember
		 */
		@PreAuthorize("isAuthenticated()")
		@RequestMapping(value={"/staffMember"}, method=RequestMethod.PUT, consumes="application/json")
		@ResponseBody
		public StaffMemberReadAdapter staffMember(@RequestBody StaffMemberReadAdapter command) {
			return reportCommandService.staffMember(command);
		}
		
		//
		
		@PreAuthorize("isAuthenticated()")
		@RequestMapping(value={"/staffMember"}, method=RequestMethod.GET, params={"users"})
		@ResponseBody
		public List<UserReadAdapter> getUserList(UserAuthentication userAuthentication) {
			return userQueryService.getUserList(userAuthentication);
		}
		
		@PreAuthorize("isAuthenticated()")
		@RequestMapping(value={"/staffMember"}, method=RequestMethod.GET, params={"users", "search", "searchFolderId"})
		@ResponseBody
		public List<UserReadAdapter> getUserList(UserAuthentication userAuthentication, @RequestParam String search, @RequestParam Integer searchFolderId) {
			return reportQueryService.getUserListSearch(userAuthentication, search, searchFolderId);
		}
		
		@PreAuthorize("isAuthenticated()")
		@RequestMapping(value={"/staffMember"}, method=RequestMethod.GET, params={"users", "userId"})
		@ResponseBody
		public UserReadAdapter getUser(@RequestParam Integer userId) {
			return userQueryService.getUser(userId);
		}
		
}

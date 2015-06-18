package com.iservport.report.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;



/**
 * Controlador de ordens.
 * 
 * @author mauriciofernandesdecastro
 */
@Controller
@RequestMapping("/api/report")
public class ReportController {
}
//	@Inject ReportQueryService reportQueryService;
	
	// Membros da equipe

		/**
		 * Novo membro da equipe.
		 *
		 * POST		/app/report/staffMember?folderId
		 */
/**		@PreAuthorize("isAuthenticated()")
		@RequestMapping(value={"/staffMember"}, method=RequestMethod.POST , params={"folderId"})
		@ResponseBody
		public StaffMemberReadAdapter staffMemberNew(@RequestParam Integer folderId) {
			return reportCommandService.staffMemberNew(folderId);
		}
**/
		/**
		 * Membro da equipe.
		 *
		 * GET 	/app/report/staffMember?staffMemberId
		 */
/**		@PreAuthorize("isAuthenticated()")
		@RequestMapping(value={"/staffMember"}, method=RequestMethod.GET, params={"staffMemberId"})
		@ResponseBody
		public StaffMemberReadAdapter staffMemberOpen(@RequestParam Integer staffMemberId) {
			return reportQueryService.staffMemberOpen(staffMemberId);
		}
**/
		/**
		 * Remove membro da equipe.
		 *
		 * DELT 	/app/report/staffMember?staffMemberId
		 */
/**		@PreAuthorize("isAuthenticated()")
		@RequestMapping(value={"/staffMember"}, method=RequestMethod.DELETE, params={"targetId"})
		@ResponseBody
		public String staffMemberDelete(@RequestParam Integer targetId) {
			return reportCommandService.staffMemberDelete(targetId);
		}
**/
		/**
		 * Atualizar membro da equipe.
		 *
		 * PUT 	/app/report/staffMember
		 */
/**		@PreAuthorize("isAuthenticated()")
		@RequestMapping(value={"/staffMember"}, method=RequestMethod.PUT, consumes="application/json")
		@ResponseBody
		public StaffMemberReadAdapter staffMember(@RequestBody StaffMemberReadAdapter command) {
			return reportCommandService.staffMember(command);
		}
		
		@PreAuthorize("isAuthenticated()")
		@RequestMapping(value={"/staffMember"}, method=RequestMethod.GET, params={"folderId"})
		@ResponseBody
		public Page<StaffMemberReadAdapter> staffMember(@RequestParam Integer folderId, 
				@RequestParam(required = false, defaultValue = "0") Integer pageNumber) {
			return reportQueryService.staffMemberList(folderId, pageNumber);
		}
		
		@PreAuthorize("isAuthenticated()")
		@RequestMapping(value={"/staffMember"}, method=RequestMethod.GET, params={"users"})
		@ResponseBody
		public List<UserReadAdapter> getUserList(UserAuthentication userAuthentication) {
			return reportQueryService.getUserList(userAuthentication);
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
			return reportQueryService.getUser(userId);
		}

	
	
}
**/
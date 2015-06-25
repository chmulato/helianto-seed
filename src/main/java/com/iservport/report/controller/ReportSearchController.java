package com.iservport.report.controller;

import java.util.List;

import javax.inject.Inject;

import org.helianto.core.internal.QualifierAdapter;
import org.helianto.security.internal.UserAuthentication;
import org.helianto.task.repository.FolderReadAdapter;
import org.helianto.task.repository.ReportAdapter;
import org.helianto.task.repository.ReportPhaseAdapter;
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
	
	 private static final Logger logger = LoggerFactory.getLogger(ReportSearchController.class);

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
	
		return  reportCommandService.folder(command, userAuthentication);
	}

	// Qualificadores
	
	/**
	 * Lista qualificadores.
	 * 
	 * GET		/app/report/qualifier
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
		 * GET       /app/report/folder?qualifierValue
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
		 * POST		/app/report/folder?qualifierValue
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
		 * GET 	/app/report/folder?folderId
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
		 * GET       /app/report?id
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
		 * GET       /app/report?reportId
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
		 * GET       /app/report/phase?id
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
		 * PUT		/app/report
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
		 * POST		/app/report/phase?folderId
		 */
		@PreAuthorize("isAuthenticated()")
		@RequestMapping(value={"/phase"}, method=RequestMethod.POST , params={"folderId"})
		@ResponseBody
		public ReportPhaseAdapter reportPhaseNew(UserAuthentication userAuthentication, @RequestParam Integer folderId) {
			return reportCommandService.reportPhaseNew(folderId);
		}
		
	
}
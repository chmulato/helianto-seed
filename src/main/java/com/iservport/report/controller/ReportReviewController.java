package com.iservport.report.controller;

import javax.inject.Inject;

import org.helianto.security.internal.UserAuthentication;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.iservport.report.repository.ReportReviewReadAdapter;
import com.iservport.report.service.ReportCommandService;
import com.iservport.report.service.ReportQueryService;


/**
 * controlador de projetos
 * 
 * @author mauriciofernandesdecastro
 */
@RestController
@RequestMapping("/api/report/review")
@PreAuthorize("isAuthenticated()")
public class ReportReviewController {
	
	private static final Logger logger = LoggerFactory.getLogger(ReportSearchController.class);

	@Inject 
	private ReportCommandService reportCommandService;
		
	@Inject 
	private ReportQueryService reportQueryService;
	
	/**
	 * Lista monitoramento.
	 *
	 * GET		/api/report/report/review?reportId
	 */

	@RequestMapping(method=RequestMethod.GET, params={"reportId"})
	public Page<ReportReviewReadAdapter> reportReview(@RequestParam Integer reportId, @RequestParam(required = false, defaultValue = "0") Integer pageNumber) {
		return reportQueryService.reportReview(reportId, pageNumber);
	}

	/**
	 * Novo monitoramento.
	 *
	 * POST		/api/report/report/review?reportId
	 */

	@RequestMapping(method=RequestMethod.POST , params={"reportId"})
	public ReportReviewReadAdapter reportReviewNew(UserAuthentication userAuthentication, @RequestParam Integer reportId) {
		return reportCommandService.reportReviewNew(reportId, userAuthentication.getIdentityId());
	}

	/**
	 * Monitoramento.
	 *
	 * GET 	/api/report/report/review?reportReviewId
	 */

	@RequestMapping(method=RequestMethod.GET, params={"reportReviewId"})
	public ReportReviewReadAdapter reportReviewOpen(@RequestParam Integer reportReviewId) {
		return reportQueryService.reportReviewOpen(reportReviewId);
	}

	/**
	 * Atualizar monitoramento.
	 *
	 * PUT 	/api/report/report/review
	 */

	@RequestMapping(method=RequestMethod.PUT, consumes="application/json")
	public ReportReviewReadAdapter reportReview(UserAuthentication userAuthentication, @RequestBody ReportReviewReadAdapter command) {
		return reportCommandService.reportReview(command, userAuthentication.getEntityId());
	}
	
}

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
@RequestMapping("/api/report")
@PreAuthorize("isAuthenticated()")
public class ReportSearchController {
	
	private static final Logger logger = LoggerFactory.getLogger(ReportSearchController.class);

	@Inject 
	private ReportCommandService reportCommandService;
		
	@Inject 
	private ReportQueryService reportQueryService;
	
	@Inject
	private ReportBaseLineCommandService reportBaseLineCommandService;
	
	@Inject
	private ReportDataCommandService reportDataCommandService;
	
	@Inject
	private ReportBaseLineQueryService reportBaseLineQueryService;
	
	@Inject
	private ReportDataQueryService reportDataQueryService;
	
	/**
	 * Lista reports por pastas.
	 *
	 * GET       /api/report?folderId
	 */

	@RequestMapping(method=RequestMethod.GET, params={"folderId"})
	@ResponseBody
	public ReportAdapter reportOne(UserAuthentication userAuthentication, @RequestParam Integer folderId) {
		return reportQueryService.reportOne(folderId);
	}
	
	/**
	 * return reporter from report.
	 *
	 * GET       /api/report?reportId
	 */

	@RequestMapping(method=RequestMethod.GET, params={"reportId"})
	@ResponseBody
	public String reporter(@RequestParam Integer reportId) {
		return "{\"reporterId\":"+reportQueryService.reporter(reportId)+"}";
	}
	
		/**
		 * Gráfico de burn-up.
		 *
		 * GET 	/api/report/graph/?baseLineId
		 */
	
		@RequestMapping(value={"/graph"}, method=RequestMethod.GET, params={"baseLineId"})
		@ResponseBody
		public List<Map<String,Object>>  graph(@RequestParam Integer baseLineId) {
			try {
				return testGraph();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			throw new IllegalArgumentException();
//			return reportQueryService.reportBaseLine(baseLineId);
		}
		
		private List<Map<String,Object>> testGraph() throws IOException {
			Resource testResource = new ClassPathResource("/testData.txt");
			InputStream input = testResource.getInputStream();
			BufferedReader buffer = new BufferedReader(new InputStreamReader(input));
			List<String> lines = new ArrayList<>();
			while (true) {
				String line = buffer.readLine();
				if (line==null) break;
				lines.add(line);
			}
			List<Map<String,Object>> graph = new ArrayList<>();
			DateTime start = new DateTime();
			for (int i = 0; i<lines.size(); i++) {
				Map<String,Object> aux = new HashMap<>();
				aux.put("x", start.plus(i).getMillis());
				aux.put("y", Integer.parseInt(lines.get(i)));
				graph.add(aux);
			}
			return graph;
		}
		
		//baseLine
		
		/**
		 *
		 * GET 	/api/report/baseLine?baseLineId
		 */
	
		@RequestMapping(value={"/baseLine"}, method=RequestMethod.GET, params={"baseLineId"})
		@ResponseBody
		public ReportBaseLine baseLineOpen(@RequestParam Integer baseLineId) {
			return reportBaseLineQueryService.getOne(baseLineId);
		}
		
		/**
		 *
		 * PUT 	/api/report/baseLine
		 */
	
		@RequestMapping(value={"/baseLine"}, method=RequestMethod.PUT, consumes="application/json")
		@ResponseBody
		public ReportBaseLine reportReview(UserAuthentication userAuthentication, @RequestBody ReportBaseLine command) {
			return reportBaseLineCommandService.baseLine(userAuthentication, command);
		}
		
		/**
		 *
		 * GET		/api/report/
		 */
	
		@RequestMapping(value={"/baseLine"}, method=RequestMethod.GET, params={"reportFolderId"})
		@ResponseBody
		public Page<ReportBaseLine> baseLine(
				@RequestParam Integer reportFolderId
				, @RequestParam(defaultValue = "1") Integer pageNumber
				, @RequestParam(defaultValue = "20") Integer size) {
			return reportBaseLineQueryService.list(reportFolderId, pageNumber, size);
		}

		/**
		 *
		 * POST		/api/report/
		 */
	
		@RequestMapping(value={"/baseLine"}, method=RequestMethod.POST , params={"reportFolderId"})
		@ResponseBody
		public ReportBaseLine baseLineNew(UserAuthentication userAuthentication, @RequestParam Integer reportFolderId) {
			return reportBaseLineCommandService.newReportBaseLine(reportFolderId);
		}

	//Data
		
		
		/**
		 *
		 * GET 	/api/report/data?dataId
		 */
	
		@RequestMapping(value={"/data"}, method=RequestMethod.GET, params={"dataId"})
		@ResponseBody
		public ReportData dataOpen(@RequestParam Integer dataId) {
			return reportDataQueryService.getOne(dataId);
		}
		
		/**
		 *
		 * GET		/api/data/
		 */
	
		@RequestMapping(value={"/data"}, method=RequestMethod.GET, params={"reportBaseLineId"})
		@ResponseBody
		public Page<ReportData> dataList(
				@RequestParam Integer reportBaseLineId
				, @RequestParam(defaultValue = "1") Integer pageNumber
				, @RequestParam(defaultValue = "20") Integer size) {
			return reportDataQueryService.list(reportBaseLineId, pageNumber, size);
		}

		/**
		 *
		 * POST		/api/data/
		 */
	
		@RequestMapping(value={"/data"}, method=RequestMethod.POST , params={"reportBaseLineId"})
		@ResponseBody
		public ReportData dataNew(UserAuthentication userAuthentication, @RequestParam Integer reportBaseLineId) {
			return reportDataCommandService.newReportData(reportBaseLineId);
		}

		/**
		 *
		 * PUT 	/api/report/data
		 */
	
		@RequestMapping(value={"/data"}, method=RequestMethod.PUT, consumes="application/json")
		@ResponseBody
		public ReportData reportReview(UserAuthentication userAuthentication, @RequestBody ReportData command) {
			return reportDataCommandService.reportData(command);
		}
		
		
}

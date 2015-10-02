package com.iservport.tfs.controller;

import org.helianto.security.internal.UserAuthentication;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.UriComponentsBuilder;

/**
 * Work items queries controller.
 * 
 * @author Eldevan Nery Junior
 */
@Controller
@RequestMapping("/query")
@PreAuthorize("isAuthenticated()")
public class WorkItemQueriesController extends AbstractServiceClass{

	private static final String queryUrl = "/_apis/wit/queries";
	
	/**
	 * Get a list of queries 
	 *
	 * URL from Visual Studio API
	 * GET https://{account}.visualstudio.com/defaultcollection/{project}
	 * /_apis/wit/queries[/{folderpath}]?api-version={version}[&$depth={int}&$expand={enum{none,all,clauses,wiql}} ]
	 * 
	 * our URL 
	 * GET /query/{account}/{project}?expand={value}&apiVersion{value}=&depth={value}
	 * 
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = { "/{account}/{project}" })
	@ResponseBody
	public String query(UserAuthentication userAuthentication
			, @PathVariable String account
			, @PathVariable String project
			, @RequestParam(defaultValue = "all") String expand
			, @RequestParam(defaultValue = "1.0") String apiVersion
			, @RequestParam(defaultValue = "0") Integer depth) {
		String url = "https://"+account+tfsUrl;
		UriComponentsBuilder builder = UriComponentsBuilder.fromHttpUrl(url)
		.path("/defaultcollection/"+project+queryUrl )
		.queryParam("api-version", apiVersion)
		.queryParam("$depth", depth)
		.queryParam("$expand", expand);
		
		ResponseEntity<String> entity = (ResponseEntity<String>) 
				getResponseEntity(builder,  HttpMethod.GET, getHttpEntity(), String.class);
		
		return entity.getBody();
	}
	
}
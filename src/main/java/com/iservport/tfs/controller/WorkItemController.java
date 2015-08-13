package com.iservport.tfs.controller;

import java.util.Date;

import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormatter;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.UriComponentsBuilder;

/**
 * Work items controller.
 * 
 * @author Eldevan Nery Junior
 */
@Controller
@RequestMapping("/item")
public class WorkItemController extends AbstractServiceClass{

	private static final String workItemsUrl = "/_apis/wit/workitems";
	
	/**
	 * GET https://{account}.visualstudio.com/defaultcollection/
	 * _apis/wit/workitems?api-version={version}[&ids={string}&fields={string}&asof={datetime}&$expand={enum{ all, relations, none }]
	 */
	@SuppressWarnings("unchecked")
	@PreAuthorize("isAuthenticated()")
	@RequestMapping(value = { "/", "" }, method=RequestMethod.GET)
	@ResponseBody
	public String workItem(
			@RequestParam String account
			, @RequestParam(defaultValue = "all") String expand
			, @RequestParam(defaultValue = "1.0") String apiVersion
			, @RequestParam(required= false) @DateTimeFormat(pattern="dd/MM/yyyy") Date asof
			, @RequestParam(required= false) String ids
			, @RequestParam(required= false) String fields) {
		String url = "https://"+account+tfsUrl;
		UriComponentsBuilder builder = UriComponentsBuilder.fromHttpUrl(url)
		.path("/DefaultCollection"+workItemsUrl )
		.queryParam("api-version", apiVersion)
		.queryParam("$expand", expand);
		if(asof!=null){
			String pattern = "yyyy-MM-dd'T'HH:mm:ss";
			DateTimeFormatter fmt = org.joda.time.format.DateTimeFormat.forPattern(pattern);
			DateTime dt = new DateTime(asof.getTime());
			builder.queryParam("asof",fmt.print(dt).toString());	
		}
		if (ids!=null) {
			builder.queryParam("ids", ids);	
		}
		if (fields!=null) {
			builder.queryParam("fields", fields);
		}
		ResponseEntity<String> entity = (ResponseEntity<String>) 
				getResponseEntity(builder,  HttpMethod.GET, getHttpEntity(), String.class);
		
		return entity.getBody();
	}
	
	

}
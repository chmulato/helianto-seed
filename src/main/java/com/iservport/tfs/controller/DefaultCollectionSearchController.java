package com.iservport.tfs.controller;

import java.util.List;

import org.helianto.security.internal.UserAuthentication;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.iservport.tfs.domain.WorkItem;

/**
 * Work items controller.
 * 
 * @author mauriciofernandesdecastro
 */
@Controller
@RequestMapping("/defaultCollection")
@PreAuthorize("isAuthenticated()")
public class DefaultCollectionSearchController {

	private static final Logger logger = LoggerFactory.getLogger(DefaultCollectionSearchController.class);

	// @Autowired
	// private CategoryQueryService categoryQueryService;
	//
	// @Inject
	// private CategoryCommandService categoryCommandService;

	/**
	 * Get a work item fully expanded
	 *
	 * GET
	 * /defaultCollection/_apis/wit/workitems/{workItemId}?$expand&api-version
	 */
	@RequestMapping(value = { "/_apis/wit/workitems/{workItemId}" }, method = RequestMethod.GET, params = { "expand" })
	@ResponseBody
	public List<WorkItem> workItem(UserAuthentication userAuthentication, @PathVariable Integer workItemId,
			@RequestParam(defaultValue = "") String expand, @RequestParam(defaultValue = "1.0") String apiVersion) {
		System.out.println("Test workItem");
		return null;
	}

	/**
	 * Get a list of work items
	 *
	 * GET
	 * defaultcollection/_apis/wit/workitems?api-version={version}[&ids={string}
	 * &fields={string}&asof={datetime}&$expand={enum{relations}]
	 */
	@RequestMapping(value = {
			"_apis/wit/workitems?api-version={version}[&ids={string}&fields={string}&asof={datetime}&$expand={enum{relations}]" }, method = RequestMethod.GET, params = {
					"expand" })
	@ResponseBody
	public List<WorkItem> workItemsList(UserAuthentication userAuthentication,
			@RequestParam(defaultValue = "1.0") String version, @RequestParam(defaultValue = "") String ids,
			@RequestParam(defaultValue = "") String fields, @RequestParam(defaultValue = "") String datetime,
			@RequestParam(defaultValue = "") String expand) {
		return null;
	}

	/**
	 * Get default values
	 *
	 * GET
	 * defaultcollection/{project}/_apis/wit/workitems/${workitemtypename}?api-
	 * version={version}
	 */
	@RequestMapping(value = {
			"_apis/wit/workitems/${workitemtypename}?api-version={version}" }, method = RequestMethod.GET)
	@ResponseBody
	public List<WorkItem> workItemsDefaultValues(UserAuthentication userAuthentication,
			@RequestParam(defaultValue = "1.0") String version,
			@RequestParam(defaultValue = "") String workitemtypename) {
		return null;
	}

	/**
	 * Get default values
	 *
	 * GET _apis/wit/workitems/$Task?api-version=1.0
	 */
	@RequestMapping(value = { "_apis/wit/workitems/$Task?api-version=1.0" }, method = RequestMethod.GET)
	@ResponseBody
	public List<WorkItem> workItemsDefaultValues(UserAuthentication userAuthentication, @PathVariable String task,
			@RequestParam(defaultValue = "1.0") String version,
			@RequestParam(defaultValue = "") String workitemtypename) {
		return null;
	}

	/**
	 * Create a work item
	 *
	 * PATCH
	 * defaultcollection/{project}/_apis/wit/workitems/${workitemtypename}?api-
	 * version={version}
	 */
	@RequestMapping(value = {
			"_apis/wit/workitems/${workitemtypename}?api-version={version}" }, method = RequestMethod.PATCH)
	@ResponseBody
	public List<WorkItem> workItemCreate(UserAuthentication userAuthentication, @PathVariable String workitemtypename,
			@RequestParam(defaultValue = "1.0") String version) {
		return null;
	}

	/**
	 * Create a work item
	 *
	 * PATCH _apis/wit/workitems/$Task?api-version=1.0
	 * 
	 */
	@RequestMapping(value = { "_apis/wit/workitems/$Task?api-version=1.0" }, method = RequestMethod.PATCH)
	@ResponseBody
	public List<WorkItem> workItemTask(UserAuthentication userAuthentication, @PathVariable String Task,
			@RequestParam(defaultValue = "1.0") String version) {
		return null;
	}

	/**
	 * Update work items
	 *
	 * PATCH _apis/wit/workitems/{id}?api-version={version}
	 * 
	 */
	@RequestMapping(value = {
			"defaultcollection/_apis/wit/workitems/{workItemId}?api-version={version}" }, method = RequestMethod.PATCH)
	@ResponseBody
	public List<WorkItem> workItemTask(UserAuthentication userAuthentication, @PathVariable Integer workItemId,
			@RequestParam(defaultValue = "1.0") String version) {
		return null;
	}

}

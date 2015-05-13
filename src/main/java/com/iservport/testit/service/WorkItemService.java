package com.iservport.testit.service;

import javax.inject.Inject;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class WorkItemService {
	
	String remoteUri = ".visualstudio.com/defaultcollection/_apis/wit/";
	
	public String getRemoteUri(String account) {
		return "https://"+account+remoteUri;
	}
	
	@Inject
	private RestTemplate restTemplate;
	
	/**
	 * GET https://{account}.visualstudio.com/defaultcollection/_apis/wit/workitems
	 * ?api-version={version}[&ids={string}&fields={string}&asof={datetime}&$expand={enum{relations}]
	 */
	public ResponseEntity<String> workitems() {
		return restTemplate.getForEntity(getRemoteUri("")+"workitems", String.class, "");
	}
	

}

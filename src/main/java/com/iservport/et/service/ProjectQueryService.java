package com.iservport.et.service;

import javax.inject.Inject;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponents;

import com.iservport.et.domain.ETProject;

/**
 * Serviço de atualização de projetos.
 * 
 * @author mauriciofernandesdecastro
 */
@Service
public class ProjectQueryService 
	extends AbstractETApiService
{
	
	@Inject
	private RestTemplate restTemplate;

	/**
	 * Read project.
	 * 
	 * @param projectCode
	 */
	public ETProject project(String projectCode) {
		UriComponents uriComponents =getApiUriBuilder().path("/project/").path(projectCode).build();
		System.out.println(uriComponents.toUri());
		System.out.println(restTemplate);// TODO null
//		ETProject etProject = restTemplate.getForObject(uriComponents.toUri(), ETProject.class);
		ResponseEntity<ETProject> response = restTemplate.exchange(uriComponents.toUri(), HttpMethod.GET, new HttpEntity<ETProject>(createHeaders(" terceiro_isverport", "@cesso_iservport")), ETProject.class);
		ETProject etProject = response.getBody();
		return etProject;
	}

}

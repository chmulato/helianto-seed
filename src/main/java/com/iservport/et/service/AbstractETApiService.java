package com.iservport.et.service;

import java.nio.charset.Charset;

import org.apache.commons.codec.binary.Base64;
import org.springframework.http.HttpHeaders;
import org.springframework.web.util.UriComponentsBuilder;

/**
 * Base class to Enterprise tester API calls.
 * 
 * @author mauriciofernandesdecastro
 */
public class AbstractETApiService {

	private String scheme = "http";
	
	private String host = "et2.primecontrol.com.br";
	
	private int port = 8807;
	
	private String app = "/EnterpriseTester";
	
	protected final UriComponentsBuilder getApiUriBuilder() {
		return UriComponentsBuilder.newInstance().scheme(scheme).host(host).port(port).path(app);
	}
	
	/**
	 * Basic headers (for testing).
	 * 
	 * @param username
	 * @param password
	 */
	@SuppressWarnings("serial")
	protected HttpHeaders createHeaders(final String username, final String password ){
		   return new HttpHeaders(){
		      {
		         String auth = username + ":" + password;
		         byte[] encodedAuth = Base64.encodeBase64( 
		            auth.getBytes(Charset.forName("US-ASCII")) );
		         String authHeader = "Basic " + new String( encodedAuth );
		         set( "Authorization", authHeader );
		      }
		   };
		}
	
}

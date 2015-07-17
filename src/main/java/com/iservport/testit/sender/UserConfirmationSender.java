package com.iservport.testit.sender;

import javax.inject.Inject;

import org.helianto.sendgrid.message.sender.AbstractTemplateSender;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;

import com.iservport.home.controller.TestItProperties;

/**
 * Envia um e-mail de confirmação logo após o usuário identificar-se e pedir abertura de conta.
 * 
 * @author mauriciofernandesdecastro
 */
@Component
@PropertySource("classpath:/META-INF/sender_pt.properties")
public class UserConfirmationSender 
	extends AbstractTemplateSender
{

	@Value("${sender.staticRedirectQuestion}")
	private String staticRedirectQuestion;
	
	@Value("${sender.staticRedirectMessage}")
	private String staticRedirectMessage;
	
	/**
	 * Constructor.
	 * 
	 * @param entityProps
	 */
	@Inject
	public UserConfirmationSender(TestItProperties entityProps) {
		super(entityProps.getNoReplyEmail(), entityProps.getRootFullName(), "userConfirmation");
	}
	
	protected String getConfirmationUri(String... params) {
		return getApiUrl()+"/signup/verify?token=x";
	}

}

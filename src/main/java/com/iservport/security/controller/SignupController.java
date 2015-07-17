package com.iservport.security.controller;

import javax.inject.Inject;

import org.helianto.core.domain.Identity;
import org.helianto.security.controller.AbstractSignUpController;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.iservport.testit.sender.UserConfirmationSender;

/**
 * Controlador de login.
 * 
 * @author mauriciofernandesdecastro
 */
@Controller
@RequestMapping("/signup")
public class SignupController
	extends AbstractSignUpController
{
	
	private static final Logger logger = LoggerFactory.getLogger(SignupController.class);
	
	@Inject 
	private UserConfirmationSender userConfirmationSender;

	/**
	 * Send user confirmation e-mail.
	 * 
	 * @param identity
	 */
	@Override
	protected String sendConfirmation(Identity identity) {
		if (userConfirmationSender.send(identity, "", encryptToken(identity))) {
			return "true";
		}
		return "false";
	}

	
}
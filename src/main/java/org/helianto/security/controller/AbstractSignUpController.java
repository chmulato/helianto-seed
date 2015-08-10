package org.helianto.security.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.helianto.core.domain.Signup;
import org.helianto.security.service.SignupService;
import org.springframework.core.env.Environment;
import org.springframework.http.MediaType;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.ModelAndView;


/**
 * Base classe to SignUpController.
 * 
 * @author mauriciofernandesdecastro
 */
@RequestMapping(value="/signup")
public abstract class AbstractSignUpController 
	extends AbstractCryptoController
{

	public static final String SIGN_UP = "/signup/";
	
	public static final String SIGN_UP_TEMPLATE = "security/signup";
	
	public static final String WELCOME_TEMPLATE = "security/welcome";
	
	@Inject
	private Environment env;
	
	@Inject
	private SignupService signupService;

	/**
	 * Send user confirmation e-mail.
	 * 
	 * @param identity
	 */
	protected abstract String sendConfirmation(Signup signup);
	
	/**
	 * Signup request.
	 * 
	 * @param model
	 * @param contextId
	 * @param principal
	 * @param request
	 */
	@RequestMapping(value={"/", ""}, method=RequestMethod.GET)
	public ModelAndView getSignupPage(Model model, @RequestParam(defaultValue="1") Integer contextId
			, @RequestParam(required=false) String principal, WebRequest request) {
		if(signupService.notifyAdminIfUserIsNotValid(contextId, principal)){
			return new ModelAndView("forward:/");
		}
		Signup signup = signupService.socialSignUpAttempt(contextId, request);
		return new ModelAndView(SIGN_UP_TEMPLATE, "form", signup);
	}
	
	/**
	 * Save the lead.
	 * 
	 * @param model
	 * @param principal
	 */
	@RequestMapping(value={"/", ""}, method=RequestMethod.GET, params="tempEmail", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public String saveLead(@RequestParam String principal) {
		if(signupService.saveLead(principal)){
			return "{\"exists\": true}";
		}
		return "{\"exists\": false}";
	}
	
	/**
	 * Signup submission
	 * 
	 * @param model
	 * @param signup
	 * @param error
	 * @param request
	 */
	@RequestMapping(value={"/", ""}, method= RequestMethod.POST)
	public String postSignupPage(Model model, @Valid Signup signup, BindingResult error, HttpServletRequest request) {
		
		String ipAddress = request.getHeader("X-FORWARDED-FOR");  
		if (ipAddress == null) {  
			  ipAddress = request.getRemoteAddr();  
		}
		// TODO prevent double submission
		signup.setToken(signupService.createToken());
		signup = signupService.saveSignup(signup, ipAddress);
		boolean userExists = signupService.allUsersForIdentityAreValid(signup);
		model.addAttribute("userExists", userExists);
		if (!userExists) {
			model.addAttribute("sender", env.getProperty("iservport.sender.mail"));
			model.addAttribute("emailSent", sendConfirmation(signup));
		}
		model.addAllAttributes(signup.createMapFromForm());
		return WELCOME_TEMPLATE;
	}
	
	// TODO
	public void resendConfirmation() {
		
	}
	
}

package com.iservport.home.controller;

import java.util.ArrayList;
import java.util.List;

import org.helianto.core.domain.Entity;
import org.helianto.core.domain.Identity;
import org.helianto.install.service.AbstractEntityInstallStrategy;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.stereotype.Service;

/**
 * Entity prototype generation to iserv.
 * 
 * @author Eldevan Nery Junior.
 */
@Service
public class EntityByDomainInstallStrategy 
	extends AbstractEntityInstallStrategy
	implements InitializingBean
{ 
	
	@Override
	public void afterPropertiesSet() throws Exception {
		// TODO on installation
	}
	
	public List<Entity> generateEntityPrototypes(Object... params) {
		if (params!=null && params.length>0 && params[0] instanceof Identity) {
			Identity identity = (Identity) params[0];
			List<Entity> entityList = new ArrayList<>();
			entityList.add(createPrototype(identity.getOptionalSourceAlias(), "", 'C'));
			return entityList;
		}
		throw new IllegalArgumentException("SignupForm required.");

	}

}

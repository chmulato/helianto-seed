package com.iservport.user.service;

import java.util.List;

import javax.inject.Inject;

import org.helianto.security.internal.UserAuthentication;
import org.helianto.user.repository.UserReadAdapter;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;

import com.iservport.user.repository.UserTmpRepository;

/**
* User query service.
* 
* @author Eldevan Nery Junior
*/
@Service
public class UserQueryService {

	@Inject 
	protected UserTmpRepository userTmpRepository;

	/**
	 * Lista usuários ativos.
	 * 
	 * @param userAuthentication
	 */
	public List<UserReadAdapter> getUserList(UserAuthentication userAuthentication) {
		Page<UserReadAdapter> userList = 
				userTmpRepository.findByParentUserKey(userAuthentication.getEntityId()
						, "USER", new char[] {'A'}, null);
		return userList.getContent();
	}

	public UserReadAdapter getUser(Integer userId) {
		return userTmpRepository.findByIdentityId(userId);
	}
	
}

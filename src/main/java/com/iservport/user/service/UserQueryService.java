package com.iservport.user.service;

import java.util.List;

import javax.inject.Inject;

import org.helianto.core.internal.QualifierAdapter;
import org.helianto.core.internal.SimpleCounter;
import org.helianto.security.internal.UserAuthentication;
import org.helianto.user.domain.User;
import org.helianto.user.repository.UserReadAdapter;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;

import com.iservport.user.repository.UserStatsRepository;
import com.iservport.user.repository.UserTmpRepository;

/**
* User query service.
* 
* @author Eldevan Nery Junior
*/
@Service
public class UserQueryService {

	@Inject 
	private UserTmpRepository userTmpRepository;

	@Inject
	private UserKeyNameAdapterArray keyNameAdapterArray;

	@Inject 
	protected UserStatsRepository userStatsRepository;
	
	/**
	 * List qualifiers.
	 * 
	 * @param userAuthentication
	 */
	public List<QualifierAdapter> qualifierList(int entityId) {
		List<QualifierAdapter> qualifierList 
			= QualifierAdapter.qualifierAdapterList(keyNameAdapterArray.values());
		qualifierCount(entityId, qualifierList);
		return qualifierList;
	}
	
	/**
	 * Método auxiliar para contar os qualificadores.
	 * 
	 * @param entityId
	 * @param qualifierList
	 */
	public void qualifierCount(int entityId, List<QualifierAdapter> qualifierList) {
		
		// conta os usuários ativos agrupados por tipo
		List<SimpleCounter> counterListAll 
			= userStatsRepository.countActiveUsersGroupByType(entityId);

		// para cada qualificador preenchemos as contagens
		for (QualifierAdapter qualifier: qualifierList) {
			qualifier
			.setCountItems(counterListAll);
		}
						
	}
	
	/**
	 * List active users.
	 * 
	 * @param userAuthentication
	 */
	public List<UserReadAdapter> getUserList(UserAuthentication userAuthentication) {
		Page<UserReadAdapter> userList = 
				userTmpRepository.findByParentUserKey(userAuthentication.getEntityId()
						, "USER", new char[] {'A'}, null);
		return userList.getContent();
	}

	public Page<UserReadAdapter> userList(int entityId, Character userType, String userStates, Integer pageNumber) {
		Pageable page = new PageRequest(pageNumber, 20, Direction.ASC, "userName");
		return userTmpRepository.findByParentUserType(entityId, userType, userStates.toCharArray(), page);
	}

	public UserReadAdapter getUser(Integer userId) {
		return userTmpRepository.findByIdentityId(userId);
	}

}

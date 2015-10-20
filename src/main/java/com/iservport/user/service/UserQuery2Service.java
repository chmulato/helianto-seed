package com.iservport.user.service;

import java.io.Serializable;
import java.util.List;

import javax.inject.Inject;

import org.helianto.core.domain.Identity;
import org.helianto.core.internal.KeyNameAdapter;
import org.helianto.core.internal.QualifierAdapter;
import org.helianto.core.repository.EntityRepository;
import org.helianto.core.repository.IdentityReadAdapter;
import org.helianto.core.repository.IdentityRepository;
import org.helianto.security.internal.UserAuthentication;
import org.helianto.user.domain.User;
import org.helianto.user.domain.UserAssociation;
import org.helianto.user.repository.UserReadAdapter;
import org.helianto.user.repository.UserRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.iservport.user.repository.UserTmpRepository;

/**
 * Serviço de consulta de usuários.
 * 
 * @author mauriciofernandesdecastro
 */
@Service
public class UserQuery2Service {

	private static final Logger logger = LoggerFactory.getLogger(UserQuery2Service.class);
	
	private static final String DEFAULT_PASSWORD = "123456";
	
	public static final int DAYS_TO_WARN = 30;
	
	@Inject 
	private UserRepository userRepository;
	
	@Inject 
	private EntityRepository entityRepository;
	
	@Inject 
	private IdentityRepository identityRepository;
	
	@Inject 
	private UserTmpRepository userTmpRepository;
	
	public UserAssociation findUserAssociation(int identityId, int entityId) {
		UserAssociation userAssociation = userTmpRepository.findAssociations(identityId, entityId);
		return userAssociation;
	}
	
	/**
	 * Lista de usuários.
	 * 
	 * @param model
	 * @param entityId
	 * @param searchString
	 */
	public Page<UserReadAdapter> searchList(int entityId, String searchString) {
		Page<UserReadAdapter> searchList = userTmpRepository.findByEntity_IdAndSearchString(entityId
				, "%"+searchString.toLowerCase()+"%", null);
		return searchList;
	}
	
	
	/**
	 * Lista usuários.
	 * 
	 * @param userGroupId
	 * @param userState
	 * @param userListPage
	 * @param itemsPerPage
	 */
	public Page<UserReadAdapter> userList(int userGroupId
			, Character userState, Integer userListPage, Integer itemsPerPage) {
		if (userListPage==null) {
			userListPage = 0;
		}
		Pageable page = new PageRequest(userListPage, itemsPerPage, Direction.ASC, "userName");
		Page<UserReadAdapter> userPage = null;
		if (userState!=null && userState.equals(new Character('I'))) {
			userPage = userTmpRepository.findByParent(userGroupId, new char[] { 'A', 'I'}, page);
		}
		else {
			userPage = userTmpRepository.findByParent(userGroupId, new char[] { 'A' }, page);
		}
		return userPage;
	}

	public User userOne(Integer userId) {
		return userRepository.findAdapter(userId);
	}
	
	//competenceGroup
	
	public List<QualifierAdapter> competenceGroupList(UserAuthentication userAuthentication) {
		List<QualifierAdapter> qualifierList 
			= QualifierAdapter.qualifierAdapterList(InternalCompetenceGroup.values());
		return qualifierList;
	}

	
	public IdentityUserCreateResponse createNewUser(String search, Integer entityId){
		Identity identity = identityRepository.findByPrincipal(search);
		IdentityUserCreateResponse response = new IdentityUserCreateResponse();
		if (identity!=null) {
			response.setIdentityId(identity.getId());
		}
		User user = userRepository.findByEntityAndUserKey(entityRepository.findOne(entityId), search);
		if (user!=null) {
			response.setUserId(user.getId());
		}
		response.setUserName(search);
		return response;
	}
	
	/**
	 * <h2>Classe de decisão de criação de usuário e Identidade.</h2>
	 * <ul>
	 * 	<li>(identityId = 0 & userId = 0) : criar identidade e usuário</li>
	 *  <li>(identityId > 0 & userId = 0) : criar apenas usuário</li>
	 *  <li>(identityId > 0 & userId > 0) : não pode criar identidade nem usuário</li>
	 * </ul>
	 * 
	 * @author Eldevan Jr.
	 *	
	 */
	public class IdentityUserCreateResponse{
		
		private String userName = ""; 
		private Integer identityId = 0;
		private Integer userId = 0;
		
		public IdentityUserCreateResponse(String userName, Integer identityId, Integer userId) {
			super();
			this.userName = userName;
			this.identityId = identityId;
			this.userId = userId;
		} 
		
		public IdentityUserCreateResponse() {

		}
		
		public String getUserName() {
			return userName;
		}
		public void setUserName(String userName) {
			this.userName = userName;
		}
		
		public Integer getIdentityId() {
			return identityId;
		}
		public void setIdentityId(Integer identityId) {
			this.identityId = identityId;
		}
		
		public Integer getUserId() {
			return userId;
		}
		public void setUserId(Integer userId) {
			this.userId = userId;
		}
		
		@JsonSerialize
		public Boolean cannotCreate(){
			return getIdentityId()>0 && getUserId()>0;
		}
		
		@JsonSerialize
		public Boolean createIdentity(){
			return getIdentityId()==0;
		}
		
		@JsonSerialize
		public Boolean createUser(){
			return getUserId()==0;
		}
		
	}
	
	/**
	 * Enumeração interna para definir natureza
	 * de grupos de usuários.
	 * 
	 * @author mauriciofernandesdecastro
	 */
	static enum InternalUserNature implements KeyNameAdapter {
		
		ALL('A'),
		FUNCTION('F'),
		CAREER('J'),
		CONSULTANCY('Y'),
		SYSTEM('S');
		
		private char value;
		
		/**
		 * Construtor.
		 * 
		 * @param value
		 */
		private InternalUserNature(char value) {
			this.value = value;
		}
		
		public Serializable getKey() {
			return this.value;
		}
		
		@Override
		public String getCode() {
			return value+"";
		}
		
		@Override
		public String getName() {
			return name();
		}
		
	}
	
	/**
	 * Enumeração interna para definir tipos de competência.
	 * 
	 * @author mauriciofernandesdecastro
	 */
	static enum InternalCompetenceGroup implements KeyNameAdapter {
		
		EDUCATION('E'),
		EXPERIENCE('X'),
		TRAINING('T'),
		SKILL('S');

		private char value;
		
		/**
		 * Construtor.
		 * 
		 * @param value
		 */
		private InternalCompetenceGroup(char value) {
			this.value = value;
		}
		
		public Serializable getKey() {
			return this.value;
		}
		
		@Override
		public String getCode() {
			return value+"";
		}
		
		@Override
		public String getName() {
			return name();
		}
		
	}
	
	public IdentityReadAdapter identityOne(Integer identityId) {
		Identity target = identityRepository.findOne(identityId);
		if (target==null) {
			target = new Identity(); 
		}
		return new IdentityReadAdapter().setAdaptee(target).build();
	}
	
}

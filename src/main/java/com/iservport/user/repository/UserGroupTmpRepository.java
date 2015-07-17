package com.iservport.user.repository;

import java.io.Serializable;
import java.util.List;

import org.helianto.user.domain.UserGroup;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.iservport.user.repository.adapter.UserGroupReadAdapter;

/**
 * User group repository.
 * 
 * @author mauriciofernandesdecastro
 */
public interface UserGroupTmpRepository 
	extends JpaRepository<UserGroup, Serializable> 
{

	@Query("select parents.parent "
			+ "from User child "
			+ "join child.parentAssociations parents "
			+ "where parents.parent.userKey = 'USER' "
			+ "and child.id = ?1 ")
	UserGroup findAllUserGroup(int userId);
	
	/**
	 * Lista usuários de uma entidade e tipo.
	 * 
	 * @param entityId
	 */
	@Query("select new "
			+ "com.iservport.user.repository.adapter.UserGroupReadAdapter"
			+ "(userGroup.id, userGroup.userKey, userGroup.userName, "
			+ "userGroup.minimalEducationRequirement, userGroup.minimalExperienceRequirement, "
			+ "userGroup.userType) "
			+ "from UserGroup userGroup "
			+ "where userGroup.entity.id = ?1 "
			+ "and userGroup.userType = ?2 "
			+ "and userGroup.userState = 'A' ")
	Page<UserGroupReadAdapter> findActiveUserGroupsByUserType(int entityId, char userType, Pageable page);
	
	/**
	 * Um grupo
	 * 
	 * @param groupId
	 */
	@Query("select new "
			+ "com.iservport.user.repository.adapter.UserGroupReadAdapter"
			+ "(userGroup.id, userGroup.userKey, userGroup.userName, "
			+ "userGroup.minimalEducationRequirement, userGroup.minimalExperienceRequirement, "
			+ "userGroup.userType) "
			+ "from UserGroup userGroup "
			+ "where userGroup.id = ?1 ")
	UserGroupReadAdapter findById(Integer groupId);

	/**
	 * Lista grupos de usuários associados a um usuário.
	 * 
	 * @param child
	 */
	@Query("select new "
			+ "com.iservport.user.repository.adapter.UserGroupReadAdapter"
			+ "(association.parent.id, association.parent.userKey, association.parent.userName, "
			+ "association.parent.minimalEducationRequirement, "
			+ "association.parent.minimalExperienceRequirement, "
			+ "association.parent.userType) "
			+ "from UserAssociation association "
			+ "where association.child.id = ?1 ")
	List<UserGroupReadAdapter> findParentsByChildId(int childId, Pageable page);
	

	/**
	 * Lista grupos de usuários associados a um usuário.
	 * 
	 * @param child
	 */
	@Query("select new "
			+ "com.iservport.user.repository.adapter.UserGroupReadAdapter"
			+ "(association.parent.id, association.parent.userKey, association.parent.userName, "
			+ "association.parent.minimalEducationRequirement, "
			+ "association.parent.minimalExperienceRequirement, "
			+ "association.parent.userType) "
			+ "from UserAssociation association "
			+ "where association.child.id = ?1 ")
	Page<UserGroupReadAdapter> find2ParentsByChildId(int childId, Pageable page);
	
	/**
	 * Pesquisa grupos da entidade.
	 * 
	 * @param entityId
	 * @param page
	 */
	@Query("select new "
			+ "com.iservport.user.repository.adapter.UserGroupReadAdapter"
			+ "(userGroup.id, userGroup.userKey, userGroup.userName, userGroup.userType) "
			+ "from UserGroup userGroup "
			+ "where userGroup.entity.id = ?1 "
			+ "and userGroup.class = 'G' "
			+ "and userGroup.userType not in ('A', 'G')")
	List<UserGroupReadAdapter> findByEntity_Id(Integer entityId, Pageable page);

}

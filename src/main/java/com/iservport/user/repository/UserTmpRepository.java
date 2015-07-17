package com.iservport.user.repository;

import java.io.Serializable;
import java.util.List;

import org.helianto.user.domain.User;
import org.helianto.user.domain.UserAssociation;
import org.helianto.user.repository.UserReadAdapter;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

/**
 * Repositório de estatísticas para usuários.
 * 
 * @author mauriciofernandesdecastro
 */
public interface UserTmpRepository 
	extends JpaRepository<User, Serializable> 
{

	public static final String QUERY = "select new "
			+ "org.helianto.user.repository.UserReadAdapter"
			+ "( child.id"
			+ ", parents.parent.id"
			+ ", child.userKey"
			+ ", child.userName"
			+ ", child.userState"
			+ ", child.identity.personalData.gender"
			+ ") "
			+ "from User child "
			+ "join child.parentAssociations parents ";

	/**
	 * Find by parent id and state, pageable.
	 * 
	 * @param parentGroupId
	 * @param userState
	 * @param page
	 */
	@Query(value=QUERY
			+ "where parents.parent.id = ?1 "
			+ "and child.userState in ?2")
	Page<UserReadAdapter> findByParent(int parentGroupId, char[] userState, Pageable page);
	
	/**
	 * Find by parent key and state, pageable.
	 * 
	 * @param entityId
	 * @param userKey
	 * @param exclusions
	 * @param userState
	 * @param page
	 */
	@Query(value=QUERY
			+ "where parents.parent.entity.id = ?1 "
			+ "and parents.parent.userKey = ?2 "
			+ "and child.id not in ?3 "
			+ "and child.userState in ?4 "
			+ "order by child.userName, child.userKey")
	Page<UserReadAdapter> findByParentUserKey(int entityId, String userKey, Integer[] exclusions, char[] userState, Pageable page);
	
	/**
	 * Find by user parent type.
	 * 
	 * @param entityId
	 * @param userType
	 * @param userState
	 * @param page
	 */
	@Query(value=QUERY
			+ "where parents.parent.entity.id = ?1 "
			+ "and parents.parent.userType = ?2 "
			+ "and child.userState in ?3 ")
	Page<UserReadAdapter> findByParentUserType(int entityId, Character userType, char[] userState, Pageable page);
	
	/**
	 * Find by search string.
	 * 
	 * @param entityId
	 * @param searchString
	 * @param page
	 * @return
	 */
	@Query(value=QUERY
			+ "where lower(parents.parent.userKey) = 'user' "
			+ "and child.id in ("
			+ "  select u.id from User u "
			+ "  where u.entity.id = ?1 "
			+ "  and ( lower(u.userKey) like ?2 or lower(u.userName) like ?2 ))")
	public Page<UserReadAdapter> findByEntity_IdAndSearchString(int entityId, String searchString, Pageable page);
	
/////////
	
	/**
	 * Find by parent key and state, pageable.
	 * 
	 * @param entityId
	 * @param userKey
	 * @param userState
	 * @param page
	 */
	@Query(value="select new "
			+ "org.helianto.user.repository.UserReadAdapter"
			+ "(child.identity.id, parents.parent.id, child.userKey, child.userName"
			+ ", child.userState, child.identity.personalData.gender) "
			+ "from User child "
			+ "join child.parentAssociations parents "
			+ "where parents.parent.entity.id = ?1 "
			+ "and parents.parent.userKey = ?2 "
			+ "and child.userState in ?3")
	Page<UserReadAdapter> findByParentUserKey(int entityId, String userKey, char[] userState, Pageable page);
	
	/**
	 * Find by id.
	 * 
	 * @param identityId
	 */
	@Query(value="select new "
			+ "org.helianto.user.repository.UserReadAdapter"
			+ "(child.identity.id, parents.parent.id, child.userKey, child.userName"
			+ ", child.userState, child.identity.personalData.gender) "
			+ "from User child "
			+ "join child.parentAssociations parents "
			+ "where child.identity.id = ?1")
	UserReadAdapter findByIdentityId(Integer identityId);
	
	/**
	 * Lista id de grupos de usuários associados a um usuário.
	 * 
	 * @param child
	 */
	@Query("select association.parent.id "
			+ "from UserAssociation association "
			+ "where association.child.id = ?1 ")
	List<Integer> findParentIdsByChildId(int userId);

	/**
	 * Lista id de grupos de usuários associados a um usuário.
	 * 
	 * @param child
	 */
	@Query("select association.parent.id "
			+ "from UserAssociation association "
			+ "where association.child.id = ?1 "
			+ "and association.parent.userType not in ('A', 'G') "
			+ "and association.parent.userKey != 'USER' "
			+ "and association.parent.userKey != 'ADMIN' ")
	List<Integer> findUnprotectedParentIdsByChildId(int userId);

	/**
	 * Pesquisa a associação da identidade através do usuário da entidade.
	 * 
	 * @param identityId
	 * @param entityId
	 */
	@Query("select association "
			+ "from UserAssociation association "
			+ "where association.child.identity.id = ?1 "
			+ "and association.parent.entity.id = ?2 "
			+ "and association.parent.userKey = 'USER' ")
	UserAssociation findAssociations(int identityId, int entityId);

	@Query(value="select new "
			+ "org.helianto.user.repository.UserReadAdapter"
			+ "(child.identity.id, parents.parent.id, child.userKey, child.userName"
			+ ", child.userState, child.identity.personalData.gender) "
			+ "from User child "
			+ "join child.parentAssociations parents "
			+ "where parents.parent.entity.id = ?1 "
			+ "and parents.parent.userKey = ?2 "
			+ "and child.userState in ?3 "
			+ "AND child.identity.id not in(?4) "
			+ "AND(child.userKey LIKE %?5% OR child.userName LIKE %?5%) ")
	Page<UserReadAdapter> findByParentUserKeyAndSearch(int entityId, String userKey, char[] userState, List<Integer> exclusions, String search, Pageable page);
	
	@Query("select user.id from User user where user.entity.id = ?1 AND user.userKey = ?2")
	Integer findByEntityIdAndUserKey(Integer entityId, String userKey);

}

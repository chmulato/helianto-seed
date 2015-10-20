package com.iservport.user.repository;

import java.io.Serializable;
import java.util.List;

import org.helianto.core.domain.Identity;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

/**
 * Repositório temporário de identidade.
 * 
 * @author Eldevan Nery Jr.
 */
public interface IdentityTmpRepository 
	extends JpaRepository<Identity, Serializable> 
{

	// TODO add parameter entityId or Domain to filter query by entity 
	@Query("select identity "
			+ "from Identity identity "
			+ "where lower(identity.principal) like :searchString "
			+ "OR lower(identity.personalData.firstName) like :searchString "
			+ "OR lower(identity.personalData.lastName) like :searchString  "
			+ "OR lower(identity.displayName) like :searchString ")
	public List<Identity> findBySearchString(
			@Param("searchString") String searchString, Pageable page);
	
}

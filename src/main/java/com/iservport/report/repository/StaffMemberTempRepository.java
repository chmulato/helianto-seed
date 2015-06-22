package com.iservport.report.repository;

import java.io.Serializable;
import java.util.List;

import org.helianto.task.domain.StaffMember;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface StaffMemberTempRepository 
extends JpaRepository<StaffMember, Serializable>
{

	@Query(
			"select new "
					+ "com.iservport.report.repository.StaffMemberReadAdapter"
					+ "( staffMember.id" 
					+ ", staffMember.reportFolder.id" 
					+ ", staffMember.identity.id" 
					+ ", staffMember.identity.personalData.firstName" 
					+ ", staffMember.identity.personalData.lastName" 
					+ ", staffMember.identity.displayName"
					+ ", staffMember.identity.personalData.imageUrl" 
					+ ") "
					+ "from StaffMember staffMember "
					+ "where staffMember.reportFolder.id = ?1 "
			)
	Page<StaffMemberReadAdapter> findByFolderId(Integer qualifierValue, Pageable page);


	@Query(
			"select new "
					+ "com.iservport.report.repository.StaffMemberReadAdapter"
					+ "( staffMember.id" 
					+ ", staffMember.reportFolder.id" 
					+ ", staffMember.identity.id" 
					+ ", staffMember.identity.personalData.firstName" 
					+ ", staffMember.identity.personalData.lastName" 
					+ ", staffMember.identity.displayName" 
					+ ", staffMember.identity.personalData.imageUrl" 
					+ ") "
					+ "from StaffMember staffMember "
					+ "where staffMember.id = ?1 "
			)
	StaffMemberReadAdapter findById(Integer id);

	

	@Query("SELECT staffMember.id " 
			+ "FROM StaffMember staffMember "
			+ "WHERE staffMember.reportFolder.id = ?1 AND staffMember.identity.id = ?2 ")
	Integer findByReportFolderIdAndIdentityId(Integer reportFolderId, Integer identityId);

	/**
	 * Cria lista para excluir identities já cadastradas.
	 * 
	 * @param reportFolderId
	 */
	@Query("SELECT staffMember.identity.id " 
			+ "FROM StaffMember staffMember "
			+ "WHERE staffMember.reportFolder.id = ?1")
	List<Integer> findIdentityIdsByReportFolderOnStaffMember(Integer reportFolderId);

	
}

package com.iservport.report.repository;

import java.io.Serializable;

import org.helianto.task.domain.FollowUp;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

/**
 * Repositório de comentários.
 * 
 * @author mauriciofernandesdecastro
 */
public interface FollowUpTempRepository 
extends JpaRepository<FollowUp, Serializable>
{

	/**
	 * Paginação por relatório.
	 * 
	 * @param reportId
	 * @param page
	 */
	@Query(
			"select new "
			+ "com.iservport.report.repository.FollowUpReadAdapter"
			+ "( followUp.id" 
			+ ", followUp.report.id" 
			+ ", followUp.internalNumber" 
			+ ", followUp.owner.id" 
			+ ", followUp.owner.personalData.firstName" 
			+ ", followUp.owner.personalData.lastName" 
			+ ", followUp.owner.displayName" 
			+ ", followUp.issueDate" 
			+ ", followUp.followUpDesc" 
			+ ") "
			+ "from FollowUp followUp "
			+ "where followUp.report.id = ?1 "
			)
	Page<FollowUpReadAdapter> findByReportId(Integer reportId, Pageable page);

	/**
	 * Retorna adaptador.
	 * 
	 * @param id
	 */
	@Query(
			"select new "
			+ "com.iservport.report.repository.FollowUpReadAdapter"
			+ "( followUp.id" 
			+ ", followUp.report.id" 
			+ ", followUp.internalNumber" 
			+ ", followUp.owner.id" 
			+ ", followUp.owner.personalData.firstName" 
			+ ", followUp.owner.personalData.lastName" 
			+ ", followUp.owner.displayName" 
			+ ", followUp.issueDate" 
			+ ", followUp.followUpDesc" 
			+ ") "
			+ "from FollowUp followUp "
			+ "where followUp.id = ?1 "
			)
	FollowUpReadAdapter findById(Integer id);

	/**
	 * Usado para localizar duplicações.
	 * 
	 * @param reportId
	 * @param sequence
	 */
	@Query("select "
			+ "followUp.id " 
			+ "from FollowUp followUp "
			+ "where followUp.report.id = ?1 "
			+ "and followUp.internalNumber = ?2 "
			)
	Integer findByReportIdAndInternalNumber(Integer reportId, Long internalNumber);

	@Query("select max(followUp.internalNumber) "
			+ "from FollowUp followUp "
			+ "where followUp.report.id = ?1 ")
	Long findLastInternalNumberByReportId(Integer reportId);
	

}

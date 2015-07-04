package com.iservport.report.repository;

import java.io.Serializable;

import org.helianto.query.data.QueryRepository;
import org.helianto.task.domain.Participant;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

/**
 * Repositório de monitoramento.
 * 
 * @author mauriciofernandesdecastro
 */
public interface ParticipantTempRepository 
	extends JpaRepository<Participant, Serializable>
{

	/**
	 * Paginação por relatório.
	 * 
	 * @param reportId
	 * @param page
	 */
	@Query(
			"select new "
			+ "com.iservport.report.repository.ParticipantReadAdapter"
			+ "( participant.id" 
			+ ", participant.report.id" 
			+ ", participant.identity.id" 
			+ ", participant.identity.personalData.firstName" 
			+ ", participant.identity.personalData.lastName" 
			+ ", participant.identity.displayName" 
			+ ", participant.assignmentType" 
			+ ", participant.staffMember.id" 
			+ ") "
			+ "from Participant participant "
			+ "where participant.report.id = ?1 "
			)
	Page<ParticipantReadAdapter> findByReportId(Integer reportId, Pageable page);

	/**
	 * Retorna adaptador.
	 * 
	 * @param id
	 */
	@Query(
			"select new "
			+ "com.iservport.report.repository.ParticipantReadAdapter"
			+ "( participant.id" 
			+ ", participant.report.id" 
			+ ", participant.identity.id" 
			+ ", participant.identity.personalData.firstName" 
			+ ", participant.identity.personalData.lastName" 
			+ ", participant.identity.displayName" 
			+ ", participant.assignmentType" 
			+ ", participant.staffMember.id" 
			+ ") "
			+ "from Participant participant "
			+ "where participant.id = ?1 "
			)
	ParticipantReadAdapter findById(Integer id);

	/**
	 * Usado para localizar duplicações.
	 * 
	 * @param reportId
	 * @param sequence
	 */
	@Query("select "
			+ "participant.id " 
			+ "from Participant participant "
			+ "where participant.report.id = ?1 "
			+ "and participant.identity.id = ?2 "
			)
	Integer findByReportIdAndIdentityId(Integer reportId, Integer identityId);


}

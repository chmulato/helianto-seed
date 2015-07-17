package com.iservport.report.repository;

import java.io.Serializable;

import org.helianto.task.domain.ReportReview;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

/**
 * Repositório de monitoramento.
 * 
 * @author mauriciofernandesdecastro
 */
public interface ReportReviewTempRepository 
extends JpaRepository<ReportReview, Serializable>
{

	/**
	 * Paginação por relatório.
	 * 
	 * @param reportId
	 * @param page
	 */
	@Query(
			"select new "
			+ "com.iservport.report.repository.ReportReviewReadAdapter"
			+ "( reportReview.id" 
			+ ", reportReview.report.id" 
			+ ", reportReview.owner.id" 
			+ ", reportReview.workflowLevel" 
			+ ", reportReview.owner.personalData.firstName" 
			+ ", reportReview.owner.personalData.lastName" 
			+ ", reportReview.owner.displayName" 
			+ ", reportReview.issueDate" 
			+ ", reportReview.report.nextCheckDate" 
			+ ", reportReview.resolution" 
			+ ", reportReview.reviewText" 
			+ ", reportReview.parsedContent" 
			+ ") "
			+ "from ReportReview reportReview "
			+ "where reportReview.report.id = ?1 "
			)
	Page<ReportReviewReadAdapter> findByReportId(Integer reportId, Pageable page);

	/**
	 * Retorna adaptador.
	 * 
	 * @param id
	 */
	@Query(
			"select new "
			+ "com.iservport.report.repository.ReportReviewReadAdapter"
			+ "( reportReview.id" 
			+ ", reportReview.report.id" 
			+ ", reportReview.owner.id"
			+ ", reportReview.workflowLevel" 
			+ ", reportReview.owner.personalData.firstName" 
			+ ", reportReview.owner.personalData.lastName" 
			+ ", reportReview.owner.displayName" 
			+ ", reportReview.issueDate" 
			+ ", reportReview.report.nextCheckDate" 
			+ ", reportReview.resolution" 
			+ ", reportReview.reviewText" 
			+ ", reportReview.parsedContent" 
			+ ") "
			+ "from ReportReview reportReview "
			+ "where reportReview.id = ?1 "
			)
	ReportReviewReadAdapter findById(Integer id);

	/**
	 * Usado para localizar duplicações.
	 * 
	 * @param reportId
	 * @param timeKey
	 */
	@Query("select "
			+ "reportReview.id " 
			+ "from ReportReview reportReview "
			+ "where reportReview.report.id = ?1 "
			+ "and reportReview.timeKey = ?2 "
			)
	Integer findByReportIdAndTimeKey(Integer reportId, Integer timeKey);


}

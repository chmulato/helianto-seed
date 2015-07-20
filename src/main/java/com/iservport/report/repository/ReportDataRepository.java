package com.iservport.report.repository;

import java.io.Serializable;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.iservport.report.domain.ReportData;


/**
 * Repositório de dados.
 * 
 * @author Raphael Lira.
 */
public interface ReportDataRepository 
	extends JpaRepository<ReportData, Serializable>
{
	

//	@Query("select new "
//			+ "com.iservport.report.domain.ReportData"
//			+ "(folder.id, folder.category.id, folder.folderCode, folder.folderName, "
//			+ "folder.folderDecorationUrl, folder.patternPrefix, folder.patternSuffix,"
//			+ "folder.entity.id,"
//			+ "folder.benefits, folder.assumptions, folder.deliverables, folder.constraints, folder.tools) "
//			+ "from Project folder "
//			+ "where folder.id = ?1 ")
//	ReportData findById(int id);
			
 	Page<ReportData> findByReportBaseLineId(Integer reportBaseLineId, Pageable page);
}
	






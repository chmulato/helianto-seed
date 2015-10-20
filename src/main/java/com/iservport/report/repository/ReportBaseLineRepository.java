package com.iservport.report.repository;

import java.io.Serializable;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.iservport.report.domain.ReportBaseLine;


/**
 * Repositório de BaseLine.
 * 
 * @author Raphael Lira.
 */
public interface ReportBaseLineRepository 
	extends JpaRepository<ReportBaseLine, Serializable>
{
	


//	@Query("select new "
//			+ "com.iservport.report.domain.ReportBaseLine"
//			+ "(folder.id, folder.category.id, folder.folderCode, folder.folderName, "
//			+ "folder.folderDecorationUrl, folder.patternPrefix, folder.patternSuffix,"
//			+ "folder.entity.id,"
//			+ "folder.benefits, folder.assumptions, folder.deliverables, folder.constraints, folder.tools) "
//			+ "from Project folder "
//			+ "where folder.id = ?1 ")
//	ReportBaseLine findById(int id);
	
	
	Page<ReportBaseLine> findByReportFolderId(Integer reportFolderId, Pageable page);
	
			
}
	






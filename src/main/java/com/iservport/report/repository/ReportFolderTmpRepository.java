package com.iservport.report.repository;

import java.io.Serializable;
import java.util.Collection;

import org.helianto.task.domain.ReportFolder;
import org.helianto.task.repository.FolderReadAdapter;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

/**
 * Repo...
 * 
 * @author mauriciofernandesdecastro
 *
 */
public interface ReportFolderTmpRepository 
	extends JpaRepository<ReportFolder, Serializable>
{

	@Query("select new "
			+ "org.helianto.task.repository.FolderReadAdapter"
			+ "( reportFolder_.id"
			+ ", reportFolder_.category.id"
			+ ", reportFolder_.folderCode"
			+ ", reportFolder_.folderName"
			+ ", reportFolder_.folderDecorationUrl"
			+ ", reportFolder_.patternPrefix"
			+ ", reportFolder_.patternSuffix"
			+ ", reportFolder_.numberOfDigits"
			+ ", reportFolder_.entity.id"
			+ ") "
			+ "from ReportFolder reportFolder_ "
			+ "where reportFolder_.entity.id = ?1 "
			+ "and reportFolder_.id in ("
			+ "  select distinct report_.series.id "
			+ "  from Report report_ "
			+ "  where report_.series.id = reportFolder_.id "
			+ "  and report_.resolution in ?2 "
			+ ") ")
	Page<FolderReadAdapter> findActive(int entityId, Collection<Character> resolutions, Pageable page);
	
}

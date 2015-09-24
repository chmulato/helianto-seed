package com.iservport.report.repository;

import java.io.Serializable;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import org.helianto.core.domain.Entity;
import org.helianto.core.internal.SimpleCounter;
import org.helianto.task.domain.Report;
import org.helianto.task.domain.ReportFolder;
import org.helianto.task.repository.ReportFolderCounter;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.iservport.report.domain.Project;

/**
 * Report repo.
 * 
 * @author mauriciofernandesdecastro
 */
public interface ReportTempRepository extends JpaRepository<Report, Serializable>
{

	/**
	 * Count by folder.
	 * 
	 * @param entity
	 */
	@Query("select new "
			+ "org.helianto.task.repository.ReportFolderCounter("
			+ "  report_.series.id"
			+ ", count(report_.id)"
			+ ") "
			+ "from Report report_ "
			+ "where report_.series in ?1 "
			+ "group by report_.series.id ")
	List<ReportFolderCounter> countByReportFolder(List<Project> list);
	
	/**
	 * Count doing or done by folder.
	 * 
	 * @param entity
	 */
	@Query("select new "
			+ "org.helianto.core.internal.SimpleCounter("
			+ "  report_.series.id"
			+ ", count(report_.id)"
			+ ") "
			+ "from Report report_ "
			+ "where report_.series in ?1 "
			+ "and report_.resolution <> 'P' "
			+ "group by report_.series.id ")
	List<SimpleCounter> countStartedByReportFolders(List<Project> list);

	/**
	 * Count late by folder.
	 * 
	 * @param entity
	 */
	@Query("select new "
			+ "org.helianto.core.internal.SimpleCounter("
			+ "  report_.series.id"
			+ ", count(report_.id)"
			+ ") "
			+ "from Report report_ "
			+ "where report_.series in ?1 "
			+ "and report_.nextCheckDate between report_.issueDate and ?2 "
			+ "and report_.resolution <> 'D' "
			+ "group by report_.series.id ")
	List<SimpleCounter> countLateByReportFolders(Collection<Project> projects, Date checkDate);

}

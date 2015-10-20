package com.iservport.report.repository;

import java.io.Serializable;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import org.helianto.core.internal.SimpleCounter;
import org.helianto.task.domain.Report;
import org.helianto.task.domain.ReportFolder;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

/**
 * Report stats repository interface.
 * 
 * @author mauriciofernandesdecastro
 */
public interface ReportStatsRepository 	
	extends JpaRepository<Report, Serializable> 
{

	// contagem por qualificador
	//

	/**
	 * Conta relatórios ativos (a fazer, fazendo e feitos - PTD), agrupados por categoria.
	 * 
	 * @param entityId
	 */
	@Query("select new "
			+ "org.helianto.core.internal.SimpleCounter"
			+ "(report.series.category.id, count(report)) "
			+ "from Report report "
			+ "where report.entity.id = ?1 "
			+ "and report.resolution in ('P', 'T', 'D') "
			+ "group by report.series.category.id")
	List<SimpleCounter> countActiveReportsGroupByCategory(int entityId);

	/**
	 * Conta relatórios atrasados (a fazer e fazendo), agrupados por categoria.
	 * 
	 * @param entityId
	 */
	@Query("select new "
			+ "org.helianto.core.internal.SimpleCounter"
			+ "(report.series.category.id, count(report)) "
			+ "from Report report "
			+ "where report.entity.id = ?1 "
			+ "and report.nextCheckDate between report.issueDate and ?2 "
			+ "and report.resolution in ('P', 'T') "
			+ "group by report.series.category.id")
	List<SimpleCounter> countLateReportsGroupByCategory(int entityId, Date date);

	// contagem por pasta
	//

	/**
	 * Conta relatórios ativos (a fazer, fazendo e feitos - PTD), agrupados por categoria.
	 * 
	 * @param entityId
	 */
	@Query("select new "
			+ "org.helianto.core.internal.SimpleCounter"
			+ "(report.series.id, count(report)) "
			+ "from Report report "
			+ "where report.entity.id = ?1 "
			+ "and report.resolution in ('P', 'T', 'D') "
			+ "group by report.series.id")
	List<SimpleCounter> countActiveReportsGroupByFolder(int entityId);

	/**
	 * Conta relatórios atrasados (a fazer e fazendo), agrupados por categoria.
	 * 
	 * @param entityId
	 */
	@Query("select new "
			+ "org.helianto.core.internal.SimpleCounter"
			+ "(report.series.id, count(report)) "
			+ "from Report report "
			+ "where report.entity.id = ?1 "
			+ "and report.nextCheckDate between report.issueDate and ?2 "
			+ "and report.resolution in ('P', 'T') "
			+ "group by report.category.id")
	List<SimpleCounter> countLateReportsGroupByFolder(int entityId, Date date);

	/**
	 * Conta StaffMembers por pasta.
	 * 
	 * @param folderId
	 */
	@Query("select count(staffMember.id) "
			+ "from StaffMember staffMember "
			+ "where staffMember.reportFolder.id = ?1 ")
	Integer countStaffMemberByFolder(int folderId);
	
	// TODO mover método
	//
	// módulo report
	//
	
	/**
	 * Relatórios em aberto, ou seja, não encerrados (D), não suspensos (W) 
	 * ou não cancelados (X).
	 * 
	 * @param reportFolderId
	 * @param checkDate
	 * @deprecated mover para projeto iservport-service
	 */
	@Query("select distinct report from Report report " + 
			"where report.series.id = ?1 " +
			"and report.nextCheckDate between report.issueDate and ?2 " +
			"and report.resolution not in ('D', 'W', 'X') " +
			"order by report.id ")
	List<Report> findLateBySeriesId(int reportFolderId, Date checkDate);

	@Query("select distinct report from Report report " + 
			"where report.id in ?1 " +
			"and report.nextCheckDate between report.issueDate and ?2 " +
			"and report.resolution not in ('D', 'W', 'X') " +
			"order by report.id ")
	List<Report> findLateByIdCollection(Collection<Integer> ids, Date checkDate);

	// TODO mover método
	//
	// módulo report
	//
	
	/**
	 * Find by natural key.
	 * 
	 * @param entityId
	 */
	List<ReportFolder> findByEntity_IdAndCategoryIsNull(int entityId);
	
}

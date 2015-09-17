package com.iservport.report.repository;

import java.io.Serializable;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.iservport.report.domain.Project;


/**
 * Repositório de projetos.
 * 
 * @author mauriciofernandesdecastro
 */
public interface ProjectRepository 
	extends JpaRepository<Project, Serializable>
{
	


	@Query("select new "
			+ "com.iservport.report.repository.ProjectReadAdapter"
			+ "(folder.id, folder.category.id, folder.folderCode, folder.folderName, "
			+ "folder.folderDecorationUrl, folder.patternPrefix, folder.patternSuffix,"
			+ "folder.entity.id,"
			+ "folder.benefits, folder.assumptions, folder.deliverables, folder.constraints, folder.tools) "
			+ "from Project folder "
			+ "where folder.id = ?1 ")
	ProjectReadAdapter findById(int id);

			
}
	






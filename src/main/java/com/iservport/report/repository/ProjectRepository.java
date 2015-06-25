package com.iservport.report.repository;

import java.io.Serializable;

import org.springframework.data.jpa.repository.JpaRepository;

import com.iservport.report.domain.Project;

/**
 * Repositório de projetos.
 * 
 * @author mauriciofernandesdecastro
 */
public interface ProjectRepository 
	extends JpaRepository<Project, Serializable>
{

}

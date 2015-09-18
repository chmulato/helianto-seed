package com.iservport.report.service;

import java.util.List;

import javax.inject.Inject;

import org.helianto.core.def.CategoryGroup;
import org.helianto.core.internal.QualifierAdapter;
import org.helianto.core.internal.SimpleCounter;
import org.helianto.core.repository.CategoryReadAdapter;
import org.helianto.core.repository.CategoryRepository;
import org.helianto.task.repository.FolderReadAdapter;
import org.helianto.task.service.ReportFolderCommandService;
import org.joda.time.DateMidnight;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;

import com.iservport.report.domain.Project;
import com.iservport.report.repository.CategoryReportTmpRepository;
import com.iservport.report.repository.ProjectReadAdapter;
import com.iservport.report.repository.ProjectRepository;
import com.iservport.report.repository.ReportStatsRepository;

/**
 * Project query service.
 * 
 * @author mauriciofernandesdecastro
 */
@Service
public class ProjectQueryService {
	
	public static final int DAYS_TO_WARN = 30;
	
	@Inject
	private ProjectRepository projectRepository;

	@Inject
	private CategoryRepository categoryRepository;
	
	@Inject 
	private CategoryReportTmpRepository categoryReportTmpRepository;
	
	@Inject
	private ReportStatsRepository reportStatsRepository;
	
	/**
	 * Lista categorias de relatórios.
	 * 
	 * @param entityId
	 */
	public List<QualifierAdapter> qualifier(Integer entityId) {
		// listamos categorias
		List<CategoryReadAdapter> categoryList 
		= categoryReportTmpRepository.findByEntityIdAndCategoryGroup(entityId
				, CategoryGroup.PROJECT.getValue());
		// A classe QualifierAdapter é conveniente para construir uma 
		// lista a partir de classes que implementam o tipo KeyNameAdapter.
		List<QualifierAdapter> qualifierList 
		= QualifierAdapter.categoryAdapterList(categoryList, false);

		// realiza a contagem
		count(entityId, qualifierList);

		return qualifierList;
	}

	/**
	 * Método auxiliar para contar os qualificadores.
	 * 
	 * @param entityId
	 * @param qualifierList
	 */
	public void count(Integer entityId, List<QualifierAdapter> qualifierList) {

		// conta o relatórios agrupados por categoria
		List<SimpleCounter> counterListAll 
		= reportStatsRepository.countActiveReportsGroupByCategory(entityId);

		// conta relatórios atrasados agrupados por categoria
		List<SimpleCounter> counterListLate 
		= reportStatsRepository.countLateReportsGroupByCategory(entityId
				, new DateMidnight().toDate());

		// conta relatórios a vencer em DAYS_TO_WARN (30) dias agrupados por categoria
		List<SimpleCounter> counterListWarn 
		= reportStatsRepository.countLateReportsGroupByCategory(entityId
				, new DateMidnight().plusDays(DAYS_TO_WARN).toDate());

		// para cada qualificador preenchemos as contagens
		for (QualifierAdapter qualifier: qualifierList) {
			qualifier
			.setCountItems(counterListAll)
			.setCountAlerts(counterListLate)
			.setCountWarnings(counterListWarn);
		}

	}
	
	/**
	 * Projeto.
	 * 
	 * @param projectId
	 */
	public Project project(int entityId, Integer projectId) {
		Project project 	= projectRepository.findProject(entityId, projectId);
		if (project!=null) {
			return project;
		}
		throw new UnsupportedOperationException("Project id required.");
	}

	/**
	 * Página de projetos.
	 * 
	 * @param entityId
	 * @param qualifierValue
	 * @param pageNumber
	 * @param itemsPerPage
	 */
	public Page<Project> projectPage(int entityId, Integer qualifierValue, Integer pageNumber, Integer itemsPerPage) {
		Pageable page = new PageRequest(pageNumber, itemsPerPage, Direction.ASC, "folderCode");
		return projectRepository.findByEntity_IdAndCategory_Id(entityId, qualifierValue, page);
	}

}

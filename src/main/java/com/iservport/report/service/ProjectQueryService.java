package com.iservport.report.service;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.helianto.core.def.CategoryGroup;
import org.helianto.core.internal.QualifierAdapter;
import org.helianto.core.internal.SimpleCounter;
import org.helianto.core.repository.CategoryReadAdapter;
import org.helianto.task.repository.ReportPhaseAdapter;
import org.helianto.task.repository.ReportPhaseRepository;
import org.joda.time.DateMidnight;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;

import com.iservport.report.domain.Project;
import com.iservport.report.repository.CategoryReportTmpRepository;
import com.iservport.report.repository.ProjectRepository;
import com.iservport.report.repository.ReportStatsRepository;
import com.iservport.user.repository.UserJournalRepository;

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
	private UserJournalRepository userJournalRepository;
	
	@Inject
	private ReportPhaseRepository reportPhaseRepository;
	
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
		return projectRepository.findProjectByEntity_IdAndId(entityId, projectId);
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
	
	/**
	 * Lista de projetos.
	 * 
	 * @param entityId
	 */
	public List<Project> projectList(int entityId) {
		List<Project> result = null;		
		if (entityId > 0) {
			boolean blnResult = true;
			List<SimpleCounter> listSimpleCounter = userJournalRepository.findByProjectCheckIn(entityId); 
			if ((listSimpleCounter != null) && (listSimpleCounter.size() > 0)) {
				for (SimpleCounter simpleCounter : listSimpleCounter) {
					if (simpleCounter.getBaseClass() != null) {
						int projectId = (int) simpleCounter.getBaseClass();
						Project project = projectRepository.findProjectByEntity_IdAndId(entityId, projectId);
						if (project != null) {
							// found someone
							if (blnResult) {
								result = new ArrayList<Project>();
								blnResult = false;
							}
							result.add(project);
						}
					}
				}
			}
		}
		return result;
	}
	
    /**
     * Total da estimativa das fases.
     */
    public int calcEstimate(int projectId) {
    	int estimate = 0;
    	List<ReportPhaseAdapter> phases = reportPhaseRepository.findByReportFolderId(projectId);
    	if (phases!=null) {
        	for (ReportPhaseAdapter phase: phases) {
        		estimate += phase.getEstimate();
        	}
    	}
    	return estimate;
    }

}

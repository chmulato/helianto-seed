package com.iservport.report.service;

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
import com.iservport.report.repository.ReportTempRepository;

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
	private ReportPhaseRepository reportPhaseRepository;
	
	@Inject 
	private CategoryReportTmpRepository categoryReportTmpRepository;
	
	@Inject
	private ReportTempRepository reportTempRepository;
	
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
	 * @param entityId
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
		Page<Project> projects = projectRepository.findByEntity_IdAndCategory_Id(entityId, qualifierValue, page);
		return countByFolder(projects);
	}
	
	/**
	 * Folder counter.
	 * 
	 * @param projects
	 */
	protected Page<Project> countByFolder(Page<Project> projects) {
		
		// conta relatórios exibidos na pasta
		List<SimpleCounter> counterList = 
				reportTempRepository.countStartedByReportFolders(projects.getContent());

		// conta relatórios exibidos iniciados na pasta
		List<SimpleCounter> counterListStarted = 
				reportTempRepository.countStartedByReportFolders(projects.getContent());

		// conta relatórios exibidos atrasados na pasta
		List<SimpleCounter> counterListLate = 
				reportTempRepository.countLateByReportFolders(projects.getContent(), new DateMidnight().toDate());
		
		for (Project p: projects) {
			for (SimpleCounter s: counterList) {
				if (p.getId() == ((Integer) s.getBaseClass()).intValue()) {
					//total - usaremos countItems
					p.setCountItems((int) s.getItemCount());
				}
			}
			for (SimpleCounter s: counterListStarted) {
				if (p.getId() == ((Integer) s.getBaseClass()).intValue()) {
					//iniciados - usaremos countWarnings
					p.setCountWarnings((int) s.getItemCount());
				}
			}
			for (SimpleCounter s: counterListLate) {
				if (p.getId() == ((Integer) s.getBaseClass()).intValue()) {
					//atrasados - usaremos countAlerts
					p.setCountAlerts((int) s.getItemCount());
				}
			}
		}
		return projects;

	}
	
	/**
	 * Lista de projetos.
	 * 
	 * @param entityId
	 * @param identityId
	 */
	public List<Project> projectList(int entityId, int identityId) {
		return projectRepository.findByUser_Id(entityId, identityId);
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

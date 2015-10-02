package com.iservport.report.service;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import javax.inject.Inject;

import org.helianto.core.def.CategoryGroup;
import org.helianto.core.internal.QualifierAdapter;
import org.helianto.core.internal.SimpleCounter;
import org.helianto.core.repository.CategoryReadAdapter;
import org.helianto.task.domain.ReportFolder;
import org.helianto.task.repository.ReportPhaseAdapter;
import org.helianto.task.repository.ReportPhaseRepository;
import org.helianto.user.domain.User;
import org.helianto.user.repository.UserGroupRepository;
import org.joda.time.DateMidnight;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;

import com.iservport.report.domain.Project;
import com.iservport.report.repository.CategoryReportTmpRepository;
import com.iservport.report.repository.ProjectRepository;
import com.iservport.report.repository.ReportStatsRepository;
import com.iservport.user.domain.UserJournal;
import com.iservport.user.domain.UserJournalType;
import com.iservport.user.repository.UserJournalRepository;

/**
 * Project query service.
 * 
 * @author mauriciofernandesdecastro
 */
@Service
public class ProjectQueryService {
	
	private static final Logger logger = LoggerFactory.getLogger(ProjectQueryService.class);
	
	public static final int DAYS_TO_WARN = 30;
	
	@Inject
	private ProjectRepository projectRepository;

	@Inject
	private ReportPhaseRepository reportPhaseRepository;
	
	@Inject 
	private CategoryReportTmpRepository categoryReportTmpRepository;
	
	@Inject
	private ReportStatsRepository reportStatsRepository;
	
	@Inject
	private UserJournalRepository userJournalRepository;
	
	@Inject
	protected UserGroupRepository userRepository;
	
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
		List<Integer> ids = new ArrayList<Integer>();
		for (Project p: projects) {
			
		}
		return projects;

	}
	
	/**
	 * Lista de projetos.
	 * 
	 * @param userId
	 * @param entityId
	 * @param identityId
	 * @return List<Project> projectList
	 */
	public List<Project> projectList(int userId, int entityId, int identityId) {
		List<Project> projectList = null;
		if ((userId > 0) && (entityId > 0) && (identityId > 0)) {
			projectList = projectRepository.findByUser_Id(entityId, identityId);
			if ((projectList != null) && (projectList.size() > 0)) {
				for(Project p : projectList) {
					List<SimpleCounter> simpleCounterList = userJournalRepository.findByProjectCheckIn(userId);
					if ((simpleCounterList != null) && (simpleCounterList.size() > 0)) {
						// ordenar lista por firstCheckDate
						Collections.sort(simpleCounterList);
						int count = 0;
						int total = simpleCounterList.size();
						for (SimpleCounter simpleCounter : simpleCounterList) {
							if (count == (total - 1)) {
								Serializable s = simpleCounter.getBaseClass();
								int id = (int) s;
								if (p.getId() == id) {
									p.setCheckinDate(simpleCounter.getFirstCheckDate());
									break;
								}
							}
							count = count + 1;
						} // end for
					}
				}
			}
		}
		return projectList;
	}

	/**
	 * Persistir projeto com a data de checkin.
	 * 
	 * @param userId
	 * @param project
	 * @return Project class
	 * 
	 */
	public Project projectChecked(int userId, Project project) {
		int projectId = 0;
		boolean blnCheckout = false;
		Project result = null;
		User user = null;
		if (project == null) {
			throw new IllegalArgumentException("Unable to persist null project.");
		}
		projectId = project.getId();
		if (project.getCheckinDate() == null) {
			throw new IllegalArgumentException("Unable to persist, checkin date of project is null.");
		}
		user = (User) userRepository.findOne(userId);
		if (user == null) {
			throw new IllegalArgumentException("Unable to persist, owner not found.");
		}
		logger.debug("Project checked.");
		if (projectId == 0) {
			result = project;
		} else {
			List<UserJournal> userJournalList =  userJournalRepository.findCheckinByUserAndProject(userId);
			if ((userJournalList == null) || (userJournalList.size() == 0)) {
				throw new IllegalArgumentException("Unable to persist, checkin project not found.");
			} else {
				// ordenar lista por issueDate
				Collections.sort(userJournalList);
				int count = 0;
				int total = userJournalList.size();
				for (UserJournal userJournal : userJournalList) {
					if (userJournal.getUserJournalType() == UserJournalType.PRJ_CHECK_IN) {
						if ((count == (total - 1)) && (userJournal.getReportFolder() != null)) {
							saveUserJournal(userJournal);
							blnCheckout = true;
						}
					}
					count = count + 1;
				}; // end for
			}
			result = projectRepository.findOne(project.getId());
			if ((result != null) && (user != null) && (blnCheckout)) {
				ReportFolder reportFolder = (ReportFolder) result;
				UserJournal userJournal = new UserJournal();
				userJournal.setUser(user);
				userJournal.setReportFolder(reportFolder);
				userJournal.setUserJournalType(UserJournalType.PRJ_CHECK_IN);
				userJournal.setIssueDate(project.getCheckinDate());
				userJournal.setVersion(Integer.valueOf(1));
				userJournal.setJournalCode("");
				userJournalRepository.save(userJournal);
			}
		}
		return projectRepository.saveAndFlush(result.merge(project)) ;
	}
	
	private void saveUserJournal(UserJournal userJournal) {
		UserJournal userJournalSave = new UserJournal(
				userJournal.getVersion(),
				userJournal.getUser(),
				new Date(),
				UserJournalType.PRJ_CHECK_OUT, "",
				userJournal.getReportFolder()
		);
		userJournalRepository.save(userJournalSave);
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

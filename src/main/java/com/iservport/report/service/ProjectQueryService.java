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
	
	public static final int SECONDS_TO_CHECKIN = 1000;
	
	public static final int ONLY_ONE_EVENT = -1;

	// finalizar projeto em andamento
	public static final Integer VERSION_PAIR_END = Integer.valueOf(1);
	
	// iniciar outro projeto
	public static final Integer VERSION_PAIR_START = Integer.valueOf(2);

	// iniciar projeto novo
	public static final Integer VERSION_ONLY_START = Integer.valueOf(1);
	
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
	 * Check if there is already the checkout ongoing project.
	 * 
	 * @param userId
	 * @param projectId
	 * @param checkinDate
	 * @return boolean
	 */
	private boolean isThereACheckOut(int userId, int projectId, Date checkinDate) {
		boolean result = false;
		if ((userId > 0) && (projectId > 0) && (checkinDate != null)) {
			List<SimpleCounter> simpleCounterList = userJournalRepository.findByProjectCheckOut(userId);
			if ((simpleCounterList != null) && ( simpleCounterList.size() > 0)) {
				// ordenar lista por firstCheckDate
				Collections.sort(simpleCounterList);
				int count = 0;
				int total = simpleCounterList.size();
				for (SimpleCounter simpleCounter : simpleCounterList) {
					if (count == (total - 1)) {
						Serializable s = simpleCounter.getBaseClass();
						int id = (int) s;
						if ((id == projectId) && (simpleCounter.getFirstCheckDate() != null)) {
							Date dateCheckOut = simpleCounter.getFirstCheckDate();
							if (dateCheckOut.after(checkinDate)) {
								result = true;
								break;
							}
						}
					}
					count = count + 1;
				} // end for
			}
		}
		return result;
	}

	/**
	 * Check for check-out before.
	 * 
	 * @param userId
	 * @param projectId
	 * @param checkinDate
	 * @return boolean
	 */
	private UserJournal getCheckOutBefore(User user, int projectId, Date checkinDate) {
		UserJournal result = null;
		if ((user != null) && (projectId > 0) && (checkinDate != null) && (user.getId() > 0)) {
			int userId = user.getId();
			List<SimpleCounter> simpleCounterList = userJournalRepository.findByProjectCheckOut(userId);
			if ((simpleCounterList != null) && ( simpleCounterList.size() > 0)) {
				// ordenar lista por firstCheckDate
				Collections.sort(simpleCounterList);
				int count = 0;
				int total = simpleCounterList.size();
				for (SimpleCounter simpleCounter : simpleCounterList) {
					if (count == (total - 1)) {
						Serializable s = simpleCounter.getBaseClass();
						int id = (int) s;
						if ((id == projectId) && (simpleCounter.getFirstCheckDate() != null)) {
							Date dateCheckOut = simpleCounter.getFirstCheckDate();
							if (dateCheckOut.before(checkinDate)) {
								UserJournal userJournalCheckout = userJournalRepository.findByUserAndIssueDate(user, dateCheckOut);
								if (userJournalCheckout != null) {
									result = userJournalCheckout;
									break;
								}
							}
						}
					}
					count = count + 1;
				} // end for
			}
		}
		return result;
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
									Date checkinDate = simpleCounter.getFirstCheckDate();
									if (!isThereACheckOut(userId, id, checkinDate)) {
										p.setCheckinDate(checkinDate);
										break;
									}
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
		Date checkinDate = null;
		UserJournal userJournalCheckout = null;
		boolean blnCheckout = false;
		Project result = null;
		User user = null;
		int[] ids = new int[2];
		// inicio de validacao do projeto
		if (project == null) {
			throw new IllegalArgumentException("Unable to persist null project.");
		}
		projectId = project.getId();
		if (project.getCheckinDate() == null) {
			throw new IllegalArgumentException("Unable to persist, checkin date of project is null.");
		}
		checkinDate = project.getCheckinDate();
		user = (User) userRepository.findOne(userId);
		if (user == null) {
			throw new IllegalArgumentException("Unable to persist, owner not found.");
		}
		// log console
		logger.debug("Validar projeto checkin...");
		logger.debug("UserId: " + userId);
		logger.debug("CheckinDate: " + (project.getCheckinDate() != null ? project.getCheckinDate() : "vazio"));
		// final de validacao do projeto
		if (projectId == 0) {
			result = project;
		} else {
			int doing = 0;
			do {
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
							// selecionar o ultimo item da lista com checkin
							if ((count == (total - 1)) && (userJournal.getReportFolder() != null)) {
								userJournalCheckout = getCheckOutBefore(user, projectId, checkinDate);
								if (userJournalCheckout == null) {
									// fazer o checkout no projeto em andamento com a data de checkin
									userJournal.setIssueDate(checkinDate);
									userJournalCheckout = saveUserJournal(userJournal);
									if ((userJournalCheckout != null) && (userJournalCheckout.getId() > 0)) {
										ids[0] = userJournalCheckout.getId();
										blnCheckout = true;
									}
								} else {
									ids[0] = ONLY_ONE_EVENT;
									blnCheckout = true;
								}
							}
						}
						count = count + 1;
					}; // end for
				}
				result = projectRepository.findOne(project.getId());
				if ((result != null) && (user != null)) {
					if (blnCheckout) {
						if (isThereUserJournalCheckout(userJournalCheckout)) {
							ReportFolder reportFolder = (ReportFolder) result;
							UserJournal userJournal = new UserJournal();
							userJournal.setUser(user);
							userJournal.setReportFolder(reportFolder);
							userJournal.setUserJournalType(UserJournalType.PRJ_CHECK_IN);
							// preparar data para o checkin no proximo projeto
							userJournal.setIssueDate(dateCheckin(checkinDate));
							userJournal.setVersion(VERSION_PAIR_START);
							userJournal.setJournalCode("");
							userJournal = userJournalRepository.save(userJournal);
							if ((userJournal != null) && (userJournal.getId() > 0)) {
								ids[1] = userJournal.getId();
							}
						}
					} else {
						// nao existe ainda nenhum projeto em aberto
						ReportFolder reportFolder = (ReportFolder) result;
						UserJournal userJournal = new UserJournal();
						userJournal.setUser(user);
						userJournal.setReportFolder(reportFolder);
						userJournal.setUserJournalType(UserJournalType.PRJ_CHECK_IN);
						userJournal.setIssueDate(checkinDate);
						userJournal.setVersion(VERSION_ONLY_START);
						userJournal.setJournalCode("");
						userJournalRepository.save(userJournal);
						ids[1] = ONLY_ONE_EVENT;
					}
				}
				doing = doing + 1;
			} while((!isSaveAll(ids)) && (doing < 2));
		}
		return projectRepository.saveAndFlush(result.merge(project)) ;
	}
	
    /**
     * Verificar se salvou corretamente o par de checkout/checkin.
     */
	private boolean isSaveAll(int[] ids) {
		boolean isOK = false;
		if (ids.length > 0) {
			for (int i = 0; i < ids.length; i++) {
				// valida se o checkout e checkin foram salvos corretamente na base
				if (ids[i] > 0) {
					int userJournalId = ids[i];
					UserJournal userJournalCheckout = userJournalRepository.findOne(userJournalId);
					if (userJournalCheckout != null) {
						isOK = true;
					} else {
						isOK = false;
					}
				} else {
					isOK = false;
				}
				// condicao para quando nao existe nenhum projeto ainda em aberto
				if (ids[i] == ONLY_ONE_EVENT) {
					isOK = true;
				}
			} // end for
		}
		return isOK;
	}
	
    /**
     * Verifica se o checkout foi persistido com sucesso.
     */
	private boolean isThereUserJournalCheckout(UserJournal userJournal) {
		boolean isOK = false;
		if ((userJournal !=null) && (userJournal.getId() > 0)) {
			int userJournalId = userJournal.getId();
			UserJournal userJournalCheckout = userJournalRepository.findOne(userJournalId);
			if (userJournalCheckout != null) {
				isOK = true;
			}
		}
		return isOK;
	}
	
    /**
     * Salva horário de checkout.
     */
	private UserJournal saveUserJournal(UserJournal userJournal) {
		UserJournal result = null;
		UserJournal userJournalSave = new UserJournal (
				VERSION_PAIR_END,
				userJournal.getUser(),
				userJournal.getIssueDate(),
				UserJournalType.PRJ_CHECK_OUT, "",
				userJournal.getReportFolder()
		);
		result = userJournalRepository.save(userJournalSave);
		return result;
	}
	
    /**
     * Recuperar data para o checkin do projeto.
     */
	private Date dateCheckin(Date date) {
		Date result = new Date(date.getTime() + SECONDS_TO_CHECKIN);
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

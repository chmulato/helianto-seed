package com.iservport.report.service;

import java.text.DecimalFormat;
import java.util.List;

import javax.inject.Inject;

import org.helianto.core.domain.Category;
import org.helianto.core.domain.Entity;
import org.helianto.core.domain.Identity;
import org.helianto.core.repository.CategoryRepository;
import org.helianto.core.repository.EntityRepository;
import org.helianto.core.repository.IdentityRepository;
import org.helianto.security.internal.UserAuthentication;
import org.helianto.task.domain.Report;
import org.helianto.task.domain.ReportFolder;
import org.helianto.task.domain.ReportPhase;
import org.helianto.task.domain.ReportReview;
import org.helianto.task.domain.StaffMember;
import org.helianto.task.repository.ReportAdapter;
import org.helianto.task.repository.ReportFolderRepository;
import org.helianto.task.repository.ReportPhaseAdapter;
import org.helianto.task.repository.ReportPhaseRepository;
import org.helianto.task.repository.ReportRepository;
import org.helianto.task.repository.StaffMemberRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.iservport.report.domain.Project;
import com.iservport.report.repository.FollowUpReadAdapter;
import com.iservport.report.repository.FollowUpTempRepository;
import com.iservport.report.repository.ParticipantReadAdapter;
import com.iservport.report.repository.ParticipantTempRepository;
import com.iservport.report.repository.ProjectReadAdapter;
import com.iservport.report.repository.ProjectRepository;
import com.iservport.report.repository.ReportReviewReadAdapter;
import com.iservport.report.repository.ReportReviewTempRepository;
import com.iservport.report.repository.ReportStatsRepository;
import com.iservport.report.repository.StaffMemberReadAdapter;
import com.iservport.report.repository.StaffMemberTempRepository;

/**
 * Report command service.
 * 
 * @author Eldevan Nery Junior
 */
@Service
public class ReportCommandService {

	public static final int DAYS_TO_WARN = 30;
	
	private static final Logger logger = LoggerFactory.getLogger(ReportCommandService.class);
	
	@Inject
	private CategoryRepository categoryRepository;

	@Inject
	private ReportRepository reportRepository;

	@Inject
	private ProjectRepository projectRepository;

	@Inject
	private ReportFolderRepository reportFolderRepository;
	
	@Inject
	private ReportStatsRepository reportStatsRepository;

	@Inject
	private EntityRepository entityRepository;

	@Inject 
	private StaffMemberTempRepository staffMemberTempRepository;

	@Inject 
	private IdentityRepository identityRepository;

	@Inject
	private ReportReviewTempRepository reportReviewTempRepository;  

	@Inject
	private ParticipantTempRepository participantTempRepository;

	@Inject 
	private FollowUpTempRepository followUpTempRepository;
	
	@Inject
	private ReportPhaseRepository reportPhaseRepository;
	
	//PASTA

	/**
	 * Nova pasta.
	 * 
	 * @param categoryId
	 */
	public ProjectReadAdapter folderNew(Integer categoryId) {
		Category category = categoryRepository.findOne(categoryId);
		if (category!=null) {
			ProjectReadAdapter adapter = new ProjectReadAdapter(0, category.getId(), "", "", "", "", "", ' ', "", "", "", "", "");
			return adapter;
		}
		throw new UnsupportedOperationException("Category required.");
	}

	/**
	 * Atualizar pasta.
	 * 
	 * @param command
	 */
	public ProjectReadAdapter project(ProjectReadAdapter command, UserAuthentication authentication) {
		Project project = validate(command, authentication);
		project.setFolderName(command.getFolderName());
		project.setFolderCode(command.getFolderCode());
		project.setFolderDecorationUrl(command.getFolderDecorationUrl());
		project.setBenefits(command.getBenefits());
		project.setAssumptions(command.getAssumptions());
		project.setDeliverables(command.getDeliverables());
		project.setConstraints(command.getConstraints());
		project.setTools(command.arrayToString(command.getTools()));
		project = projectRepository.saveAndFlush(project);
		return new ProjectReadAdapter(project.getId(), project.getCategory().getId(),
				project.getFolderName(), project.getFolderCode(), 
				project.getFolderDecorationUrl(), project.getPatternPrefix(),
				project.getPatternSuffix(),project.getEntityId(), project.getBenefits(),
				project.getAssumptions(), project.getDeliverables(),
				project.getConstraints(), project.getTools());
	}  
	
	/**
	 * Método auxiliar para validar a pasta.
	 * 
	 * @param command
	 */
	protected Project validate(ProjectReadAdapter command, UserAuthentication authentication) {
		Project project = null;
		if (command.getId()==0) {
			if (command.getFolderCode()==null || command.getFolderCode().isEmpty()) {

				throw new RuntimeException("Project code not valid.");
			}
			Category category = categoryRepository.findOne(command.getCategoryId());
			if (category!=null) {
				Entity entity = entityRepository.findOne(authentication.getEntityId());
				project = new Project(); //(entity, category)
				project.setEntity(entity);
				project.setCategory(category);
				List<Integer> existing 
				= reportFolderRepository.
				findIdsByCategory_IdAndFolderCodeLike(command.getCategoryId(), command.getFolderCode().toLowerCase());
				if (existing!=null && existing.size()>0) {
					throw new RuntimeException("Instrument folder not unique.");
				}
			}

		}
		else {
		 project = (Project) reportFolderRepository.findOne(command.getId());
		}
		if (project==null) {
			throw new RuntimeException("Null report folder cannot be persisted.");
		}
		return project;
	}
	
	//Report
	/**
	 * Novo relatório.
	 * 
	 * @param folderId
	 */
	public ReportAdapter reportNew(Integer folderId, Integer entityId) {
		Project project = (Project) reportFolderRepository.findOne(folderId);
		Entity entity = entityRepository.findOne(entityId);
		if (project!=null && entity!=null) {
			Report report = new Report(entity, "");
			report.setSeries(project);
			Long internalNumber =  reportRepository.findLastInternalNumberByReportFolderId(project.getId());
			internalNumber = internalNumber!=null?internalNumber+1:1;
			report.setInternalNumber(internalNumber);
			try {
				report.setReportCode(new DecimalFormat(report.getNumberPattern()).format(internalNumber));
			}catch (Exception e){
				throw new RuntimeException("REPORT NOT UNIQUE");
			}
			return new ReportAdapter(report).build();
		}
		throw new UnsupportedOperationException("Folder and entity required.");
	}
	
	/**
	 * Save report.
	 * 
	 * @param command
	 * @param entityId
	 */
	public ReportAdapter report(ReportAdapter command, Integer entityId, Integer identityId) {
		Report target = null;
		if (command.getId()==0) {
			target = reportNew(command.getReportFolderId(), entityId).merge();
			Report existing = reportRepository.findByEntity_idAndReportCode(entityId, command.getReportCode());
			if (existing!=null) {
				throw new RuntimeException("REPORT NOT UNIQUE");
			}
		}
		else {
			target = reportRepository.findOne(command.getId());
		}
		if (target==null ) {
			throw new RuntimeException("Report cannot be null");	
		}
		if(command.getIdentityId()==null){
			command.setIdentityId(identityId);	
		}
		Identity reporter = identityRepository.findOne(command.getIdentityId());
		target.setReporter(reporter);
		target = reportRepository.saveAndFlush(command.setAdaptee(target).merge());
		return reportRepository.findById(target.getId());
		
	}
	

	//reportPhase
	
		/**
		 * Cria uma instância de reportPhase
		 * 
		 * @param folderId
		 * 
		 */
		public ReportPhaseAdapter reportPhaseNew(Integer folderId) {
			ReportFolder folder = reportFolderRepository.findOne(folderId);
			ReportPhaseAdapter adapter =  new ReportPhaseAdapter(new ReportPhase(folder));
			adapter.setReportFolderId(folderId);
			return adapter;
		}

		/**
		 * Save reportPhase.
		 * 
		 * @param command
		 * @param entityId
		 */
		public ReportPhaseAdapter reportPhase(ReportPhaseAdapter command) {
			ReportPhase target = null;
			if (command.getId()==0) {
				target = reportPhaseNew(command.getReportFolderId()).merge();
				ReportPhase existing = reportPhaseRepository.findByReportFolderAndLiteral(target.getReportFolder(), command.getLiteral());
				if (existing!=null) {
					throw new RuntimeException("REPORT_PHASE NOT UNIQUE");
				}
			}
			else {
				target = reportPhaseRepository.findOne(command.getId());
			}
			if (target==null ) {
				throw new RuntimeException("REPORT_PHASE CANNOT BE NULL");	
			}
			target = reportPhaseRepository.saveAndFlush(command.setAdaptee(target).merge());
			return reportPhaseRepository.findById(target.getId());
			
		}

	/**
	 * Novo monitoramento.
	 *  
	 * @param reportId
	 */
	public ReportReviewReadAdapter reportReviewNew(Integer reportId, Integer identityId) {
		Identity identity = identityRepository.findOne(identityId);
		Report report = reportRepository.findOne(reportId);
		return new ReportReviewReadAdapter(new ReportReview()).build(report, identity);
	}

	/**
	 * Atualiza monitoramento.
	 * 
	 * @param command
	 */
	public ReportReviewReadAdapter reportReview(ReportReviewReadAdapter command, Integer entityid) {
		ReportReviewReadAdapter reportReview = validate(command, entityid);
		reportReviewTempRepository.saveAndFlush(reportReview.merge());
		//update nextCheckDate on report
		Report report = reportRepository.findOne(command.getReportId());
		report.setNextCheckDate(command.getNextCheckDate());
		reportRepository.saveAndFlush(report);
		return reportReview ;
	}

	/**
	 * Validador.
	 * 
	 * @param command
	 */
	protected  ReportReviewReadAdapter validate(ReportReviewReadAdapter command, Integer entityid){
		ReportReview reportReview = null;
		Report report = null;
		Identity identity = null;
		if (command.getId()==0) {
			if (command.getReportId()==null || command.getIdentityId()==null) {
				throw new RuntimeException("Report  and identity required");
			}
			report = reportRepository.findOne(command.getReportId());
			identity = identityRepository.findOne(command.getIdentityId());
			if (report==null || identity ==null) {
				throw new RuntimeException("Report and identity required");
			}

			reportReview = new ReportReview(report, identity);
			
			


		//	Integer existing 
		//	= 		reportReviewTempRepository.findByReportIdAndTimeKey(report.getId(), (int)reportReview.getTimeKey());
		//	if (existing!=null)  {
		//		throw new SaveEntityException(existing, "ReportReviw not unique.",0);
		//	}

		}
		else {
			reportReview = reportReviewTempRepository.findOne(command.getId());
		}

		Entity entity = entityRepository.findOne(entityid);
		reportReview.setEntity(entity);
		command.setAdaptee(reportReview);
		return command;
	}

	public ParticipantReadAdapter participantNew(Integer reportId) {
		// TODO Auto-generated method stub
		return null;
	}

	public ParticipantReadAdapter participant(ParticipantReadAdapter command) {
		// TODO Auto-generated method stub
		return null;
	}

	public FollowUpReadAdapter followUpNew(Integer reportId) {
		// TODO Auto-generated method stub
		return null;
	}

	public FollowUpReadAdapter followUp(FollowUpReadAdapter command) {
		// TODO Auto-generated method stub
		return null;
	}

}
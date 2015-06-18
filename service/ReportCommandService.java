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
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.iservport.home.exception.SaveEntityException;
import com.iservport.home.internal.FolderReadAdapter;
import com.iservport.report.repository.FollowUpReadAdapter;
import com.iservport.report.repository.FollowUpTempRepository;
import com.iservport.report.repository.ParticipantReadAdapter;
import com.iservport.report.repository.ParticipantTempRepository;
import com.iservport.report.repository.ReportReviewReadAdapter;
import com.iservport.report.repository.ReportReviewTempRepository;
import com.iservport.report.repository.ReportStatsRepository;
import com.iservport.report.repository.StaffMemberReadAdapter;
import com.iservport.report.repository.StaffMemberTempRepository;
import com.iservport.task.domain.Report;
import com.iservport.task.domain.ReportFolder;
import com.iservport.task.domain.ReportPhase;
import com.iservport.task.domain.ReportReview;
import com.iservport.task.domain.StaffMember;
import com.iservport.task.repository.ReportAdapter;
import com.iservport.task.repository.ReportFolderRepository;
import com.iservport.task.repository.ReportPhaseAdapter;
import com.iservport.task.repository.ReportPhaseRepository;
import com.iservport.task.repository.ReportRepository;
import com.iservport.task.repository.StaffMemberRepository;

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
	protected CategoryRepository categoryRepository;

	@Inject
	protected ReportRepository reportRepository;

	@Inject
	protected ReportFolderRepository reportFolderRepository;

	@Inject
	protected ReportStatsRepository reportStatsRepository;

	@Inject
	protected EntityRepository entityRepository;

	@Inject 
	protected StaffMemberTempRepository staffMemberTempRepository;

	@Inject 
	protected StaffMemberRepository staffMemberRepository;

	@Inject 
	protected IdentityRepository identityRepository;

	@Inject
	protected ReportReviewTempRepository reportReviewTempRepository;  

	@Inject
	protected ParticipantTempRepository participantTempRepository;

	@Inject 
	protected FollowUpTempRepository followUpTempRepository;
	
	@Inject
	protected ReportPhaseRepository reportPhaseRepository;
	
	//PASTA

	/**
	 * Nova pasta.
	 * 
	 * @param categoryId
	 */
	public FolderReadAdapter folderNew(Integer categoryId) {
		Category category = categoryRepository.findOne(categoryId);
		if (category!=null) {
			FolderReadAdapter adapter = new FolderReadAdapter(0, category.getId(), "", "", "", ' ');
			return adapter;
		}
		throw new UnsupportedOperationException("Category required.");
	}

	/**
	 * Pasta.
	 * 
	 * @param folderId
	 */
	public FolderReadAdapter folderOpen(Integer folderId) {

		FolderReadAdapter reportFolder 	= reportFolderRepository.findById(folderId);
		if (reportFolder!=null) {
			return reportFolder;
		}
		throw new UnsupportedOperationException("Report folder required.");
	}

	/**
	 * Atualizar pasta.
	 * 
	 * @param command
	 */
	public FolderReadAdapter folder(FolderReadAdapter command, UserAuthentication authentication) {
		ReportFolder reportFolder = validate(command, authentication);
		reportFolder.setFolderName(command.getFolderName());
		reportFolder.setFolderCode(command.getFolderCode());
		reportFolder = reportFolderRepository.saveAndFlush(reportFolder);
		return new FolderReadAdapter(reportFolder.getId(), reportFolder.getCategory().getId(),
				reportFolder.getFolderCode(), reportFolder.getFolderName(), 
				reportFolder.getFolderDecorationUrl(), reportFolder.getContentType());
	}

	/**
	 * Método auxiliar para validar a pasta.
	 * 
	 * @param command
	 */
	protected ReportFolder validate(FolderReadAdapter command, UserAuthentication authentication) {
		ReportFolder reportFolder = null;
		if (command.getId()==0) {
			if (command.getFolderCode()==null || command.getFolderCode().isEmpty()) {

				throw new SaveEntityException(0,"Report folder code not valid.",202);
			}
			Category category = categoryRepository.findOne(command.getCategoryId());
			if (category!=null) {
				Entity entity = entityRepository.findOne(authentication.getEntityId());
				reportFolder = new ReportFolder(entity, category);

				List<Integer> existing 
				= reportFolderRepository.
				findIdsByCategoryIdAndFolderCodeLike(command.getCategoryId(), command.getFolderCode().toLowerCase());
				if (existing!=null && existing.size()>0) {
					throw new SaveEntityException(existing.get(0).intValue(),"Instrument folder not unique.",0);
				}
			}

		}
		else {
			reportFolder = reportFolderRepository.findOne(command.getId());
		}
		if (reportFolder==null) {
			throw new SaveEntityException(0,"Null report folder cannot be persisted.",0);
		}
		return reportFolder;
	}
	
	//Report
	/**
	 * Novo relatório.
	 * 
	 * @param folderId
	 */
	public ReportAdapter reportNew(Integer folderId, Integer entityId) {
		ReportFolder folder = reportFolderRepository.findOne(folderId);
		Entity entity = entityRepository.findOne(entityId);
		if (folder!=null && entity!=null) {
			Report report = new Report(entity, "");
			report.setSeries(folder);
			Long internalNumber =  reportRepository.findLastInternalNumberByReportFolderId(folder.getId());
			internalNumber = internalNumber!=null?internalNumber+1:1;
			report.setInternalNumber(internalNumber);
			try {
				report.setReportCode(new DecimalFormat(report.getNumberPattern()).format(internalNumber));
			}catch (Exception e){
				throw new SaveEntityException(report.getId(), "REPORT NOT UNIQUE" , 404);
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
				throw new SaveEntityException(0, "REPORT NOT UNIQUE" , 404);
			}
		}
		else {
			target = reportRepository.findOne(command.getId());
		}
		if (target==null ) {
			throw new SaveEntityException(0, "Report cannot be null", 404);	
		}
		if(command.getIdentityId()==null){
			command.setIdentityId(identityId);	
		}
		Identity reporter = identityRepository.findOne(command.getIdentityId());
		target.setReporter(reporter);
		target = reportRepository.saveAndFlush(command.setAdaptee(target).merge());
		return reportRepository.findById(target.getId());
		
	}
	

	// StaffMember
	public Page<StaffMemberReadAdapter> listStaffMember(Integer folderId, Integer pageNumber){


		Page<StaffMemberReadAdapter> staffMemberList = staffMemberTempRepository.findByFolderId(folderId, 
				new PageRequest(pageNumber, 100, Direction.ASC, "identity.id"));

		return staffMemberList;
	}

	/**
	 * Cria uma instância de staffMember
	 * @param folderId
	 * @return
	 */
	public StaffMemberReadAdapter staffMemberNew(Integer folderId) {
		ReportFolder folder = reportFolderRepository.findOne(folderId);
		return new StaffMemberReadAdapter(new StaffMember()).build( folder, new Identity());
	}

	/**
	 * Recupera um StaffMember baseado no Id.
	 * @param staffMemberId
	 * @return
	 */
	public StaffMemberReadAdapter staffMemberOpen(Integer staffMemberId) {
		StaffMemberReadAdapter staffMemberReadAdapter = staffMemberTempRepository.findById(staffMemberId);
		if (staffMemberReadAdapter!=null) {
			return staffMemberReadAdapter;
		}
		throw new UnsupportedOperationException("staffMemberId required.");
	}

	/**
	 * Atualiza.
	 * 
	 * @param command
	 */
	@Transactional
	public StaffMemberReadAdapter staffMember(StaffMemberReadAdapter command) {
		StaffMember target = null;
		ReportFolder reportFolder = null;
		Identity identity = null;
		if (command.getId()==0) {
			if (command.getReportFolderId()==null || command.getIdentityId()==null) {
				throw new SaveEntityException(0,"Report Folder and identity required",202);
			}
			reportFolder = reportFolderRepository.findOne(command.getReportFolderId());
			identity = identityRepository.findOne(command.getIdentityId());
			if (reportFolder==null || identity ==null) {
				throw new SaveEntityException(0,"Report Folder and identity required",202);
			}

			target = new StaffMember(reportFolder, identity);

			Integer existing 
			= 		staffMemberTempRepository.findByReportFolderIdAndIdentityId(reportFolder.getId(), identity.getId());
			if (existing!=null)  {
				throw new SaveEntityException(existing, "StaffMember not unique.",0);
			}

		}
		else {
			target = staffMemberRepository.findOne(command.getId());
		}
		System.err.println(reportFolder.getId()+"; "+ identity.getId());
		System.out.println(target.getReportFolder().getId()+"; "+target.getIdentity().getId());
		System.err.println("target    "+target.getId());
		target = staffMemberRepository.saveAndFlush(target);
		return staffMemberTempRepository.findById(target.getId());
	}

	
	public String staffMemberDelete(Integer staffMemberId) {
			//TODO id direto deu erro pq? erro: java.lang.IllegalArgumentException: Not an entity:class java.lang.Integer
//			at org.hibernate.ejb.AbstractEntityManagerImpl.contains(AbstractEntityManagerImpl.java:924)
//			at sun.reflect.NativeMethodAccessorImpl.invoke
			//staffMemberTempRepository.delete(staffMemberId);
			StaffMember member = staffMemberRepository.findOne(staffMemberId);
			if (member!=null) {
				try {
					staffMemberTempRepository.delete(member);	
				} catch (Exception e) {
					throw new DeleteClassException(0, "STAFF_MEMBER_CANNOT_DELETE", 404);	
				}
			}else{
				throw new DeleteClassException(0, "STAFF_MEMBER_NOT_FOUND", 404);	
			}			
			return "{\"deleted\":true}";
	}

	public  class DeleteClassException extends SaveEntityException{

		/**
		 * 
		 */
		private static final long serialVersionUID = 1L;

		public DeleteClassException(int id, String errorMessage, int errorCode) {
			super(id, errorMessage, errorCode);
		}		
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
				throw new SaveEntityException(0, "REPORT_PHASE NOT UNIQUE" , 404);
			}
		}
		else {
			target = reportPhaseRepository.findOne(command.getId());
		}
		if (target==null ) {
			throw new SaveEntityException(0, "REPORT_PHASE CANNOT BE NULL", 404);	
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
				throw new SaveEntityException(0,"Report  and identity required",202);
			}
			report = reportRepository.findOne(command.getReportId());
			identity = identityRepository.findOne(command.getIdentityId());
			if (report==null || identity ==null) {
				throw new SaveEntityException(0,"Report and identity required",202);
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

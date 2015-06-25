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
import org.helianto.task.domain.StaffMember;
import org.helianto.task.repository.FolderReadAdapter;
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
import com.iservport.report.repository.StaffMemberReadAdapter;
import com.iservport.report.repository.StaffMemberTempRepository;
//import com.iservport.report.repository.StaffMemberTempRepository;

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
	protected EntityRepository entityRepository;

	@Inject 
	protected StaffMemberRepository staffMemberRepository;

	@Inject 
	protected IdentityRepository identityRepository;
	
	@Inject
	protected ReportPhaseRepository reportPhaseRepository;
	
	@Inject 
	protected StaffMemberTempRepository staffMemberTempRepository;
	
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
		// caso não haja categoria mante o categoryId = 0;
		int categoryId = 0;
		if (reportFolder.getCategory()!=null) {
			categoryId = reportFolder.getCategory().getId();
		}
		return new FolderReadAdapter(reportFolder.getId(), categoryId,
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

				System.err.printf(command.getFolderCode());
				
				throw new RuntimeException("Report folder code not valid.");
			}
			Category category = categoryRepository.findOne(command.getCategoryId());
			if (category!=null) {
				Entity entity = entityRepository.findOne(authentication.getEntityId());
				reportFolder = new ReportFolder(entity, category);

				List<Integer> existing 
				= reportFolderRepository.
				findIdsByCategoryIdAndFolderCodeLike(command.getCategoryId(), command.getFolderCode().toLowerCase());
				if (existing!=null && existing.size()>0) {
					throw new RuntimeException("Instrument folder not unique.");
				}
			}

		}
		else {
			reportFolder = reportFolderRepository.findOne(command.getId());
		}
		if (reportFolder==null) {
			throw new RuntimeException("Null report folder cannot be persisted.");
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
	 * Cria uma instância de staffMember
	 * @param folderId
	 * @return
	 */
/**	public StaffMemberReadAdapter staffMemberNew(Integer folderId) {
		ReportFolder folder = reportFolderRepository.findOne(folderId);
		return new StaffMemberReadAdapter(new StaffMember()).build( folder, new Identity());
	}
**/
	/**
	 * Recupera um StaffMember baseado no Id.
	 * @param staffMemberId
	 * @return
	 */
/**	public StaffMemberReadAdapter staffMemberOpen(Integer staffMemberId) {
		StaffMemberReadAdapter staffMemberReadAdapter = staffMemberTempRepository.findById(staffMemberId);
		if (staffMemberReadAdapter!=null) {
			return staffMemberReadAdapter;
		}
		throw new UnsupportedOperationException("staffMemberId required.");
	}
**/

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
	
}

/**

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
**/
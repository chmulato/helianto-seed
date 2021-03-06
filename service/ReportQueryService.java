package com.iservport.report.service;

import java.util.Date;
import java.util.List;

import javax.inject.Inject;

import org.helianto.core.def.CategoryGroup;
import org.helianto.core.internal.QualifierAdapter;
import org.helianto.core.internal.SimpleCounter;
import org.helianto.core.repository.CategoryReadAdapter;
import org.helianto.core.repository.CategoryRepository;
import org.helianto.core.repository.EntityRepository;
import org.helianto.core.repository.IdentityRepository;
import org.helianto.security.internal.UserAuthentication;
import org.helianto.user.repository.UserReadAdapter;
import org.helianto.user.repository.UserRepository;
import org.joda.time.DateMidnight;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;

import com.iservport.home.internal.FolderReadAdapter;
import com.iservport.report.repository.CategoryReportTmpRepository;
import com.iservport.report.repository.FollowUpReadAdapter;
import com.iservport.report.repository.ParticipantReadAdapter;
import com.iservport.report.repository.ReportReviewReadAdapter;
import com.iservport.report.repository.ReportReviewTempRepository;
import com.iservport.report.repository.ReportStatsRepository;
import com.iservport.report.repository.StaffMemberReadAdapter;
import com.iservport.report.repository.StaffMemberTempRepository;
import com.iservport.task.repository.ReportAdapter;
import com.iservport.task.repository.ReportFolderRepository;
import com.iservport.task.repository.ReportPhaseAdapter;
import com.iservport.task.repository.ReportPhaseRepository;
import com.iservport.task.repository.ReportRepository;
import com.iservport.user.repository.UserTmpRepository;

/**
 * Report query service.
 * 
 * @author Eldevan Nery Junior.
 */
@Service
public class ReportQueryService {

	public static final int DAYS_TO_WARN = 30;
	
	private static final Logger logger = LoggerFactory.getLogger(ReportQueryService.class);
	
	@Inject
	protected ReportFolderRepository reportFolderRepository;

	@Inject
	protected ReportStatsRepository reportStatsRepository;
	
	@Inject
	protected ReportRepository reportRepository;
	
	@Inject
	protected EntityRepository entityRepository;
	
	@Inject
	protected UserRepository userRepository;
	
	@Inject
	protected IdentityRepository identityRepository;
	
	@Inject
	protected CategoryRepository categoryRepository;
	
	@Inject 
	protected CategoryReportTmpRepository categoryReportTmpRepository;
	
	@Inject
	protected ReportPhaseRepository reportPhaseRepository;
	
	@Inject 
	protected StaffMemberTempRepository staffMemberTempRepository;
	
	@Inject 
	protected UserTmpRepository userTmpRepository;

	@Inject
	protected ReportReviewTempRepository reportReviewTempRepository;  

	//qualifier
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
	
	//Folder
	
	public Page<FolderReadAdapter> folder(int entityId,
			Integer qualifierValue, Integer pageNumber) {
		Pageable page = new PageRequest(pageNumber, 25, Direction.ASC, "folderCode");
		return reportFolderRepository.findByEntity_IdAndCategoryId(entityId, qualifierValue, page);
	}

	public FolderReadAdapter folderOpen(Integer folderId) {
		return reportFolderRepository.findById(folderId);
	}
	
	//report
	
	/**
	 * Lista relatórios de uma pasta.
	 * 
	 * @param folderId
	 */
	public Page<ReportAdapter> list(Integer folderId, Character[] phases,Integer pageNumber) {

		List<Integer> reportIdLateList 
		= reportRepository.findLateBySeriesId(folderId, new Date());

		Pageable page = new PageRequest(pageNumber, 10, Direction.ASC, "internalNumber");
		Page<ReportAdapter> reportList = null;
		if(phases!=null){
			reportList	= reportRepository.findBySeriesIdOnPhase(folderId, phases,page);
		}else{
			reportList	= reportRepository.findBySeriesId(folderId, page);
		}

		for (ReportAdapter report: reportList) {
			for (Integer reportId: reportIdLateList) {
				if(reportId==report.getId()) {
					report.setLate(reportIdLateList);
				}
			}
		}

		return reportList;
	}
	
	/**
	 * Get one.
	 * 
	 * @param id
	 */
	public ReportAdapter reportOne(Integer id){
		return reportRepository.findById(id); 
	}
	
	public Integer reporter(Integer reportId){
		return reportRepository.findReporterIdByReport(reportId); 
	}
	
	//reportPhase
	
	/**
	 * Recupera uma fase baseado no Id.
	 * 
	 * @param reportPhaseId
	 * 
	 */
	public ReportPhaseAdapter reportPhaseOpen(Integer reportPhaseId) {
		return reportPhaseRepository.findById(reportPhaseId);
	}
	
	public List<ReportPhaseAdapter> reportPhaseList(Integer reportFolderId) {
		return reportPhaseRepository.findByReportFolderId(reportFolderId);
	}
	
	public StaffMemberReadAdapter staffMemberOpen(Integer staffMemberId) {
		return staffMemberTempRepository.findById(staffMemberId);
	}
	
	public Page<StaffMemberReadAdapter> staffMemberList(Integer folderId, Integer pageNumber) {
		Pageable page = new PageRequest(pageNumber, 100, Direction.ASC, "identity.displayName", "identity.personalData.firstName");
		return staffMemberTempRepository.findByFolderId(folderId, page );
	}
	
	public List<UserReadAdapter> getUserList(UserAuthentication userAuthentication) {
		Page<UserReadAdapter> userList = 
				userTmpRepository.findByParentUserKey(userAuthentication.getEntityId()
						, "USER", new char[] {'A'}, null);
		return userList.getContent();
	}

	public UserReadAdapter getUser(Integer userId) {
		return userTmpRepository.findByIdentityId(userId);
	}
	
	public List<UserReadAdapter> getUserListSearch(UserAuthentication userAuthentication, String search, Integer searchFolderId) {
		List<Integer> exclusions = staffMemberTempRepository.findIdentityIdsByReportFolderOnStaffMember(searchFolderId);
		//previne que dê erro.
		exclusions.add(0);
		Pageable page = new PageRequest(0, 1000, Direction.ASC, "userName", "userKey");
		Page<UserReadAdapter> userList = 
				userTmpRepository.findByParentUserKeyAndSearch(userAuthentication.getEntityId()
						, "USER", new char[] {'A'}, exclusions, search, page);
		return userList.getContent();
	}

	/**
	 * Listar monitoramento.
	 * 
	 * @param reportId
	 * @param pageNumber
	 */
	public Page<ReportReviewReadAdapter> reportReview(Integer reportId, Integer pageNumber) {
		Page<ReportReviewReadAdapter> reportReviewList = reportReviewTempRepository.findByReportId(reportId, 
				new PageRequest(pageNumber, 100, Direction.ASC, "id"));

		return reportReviewList;
	}

	/**
	 * Recupera um monitoramento.
	 * 
	 * @param reportReviewId
	 */
	public ReportReviewReadAdapter reportReviewOpen(Integer reportReviewId) {
		ReportReviewReadAdapter reportReviewReadAdapter = reportReviewTempRepository.findById(reportReviewId);
		return reportReviewReadAdapter;
	}

	public Page<ParticipantReadAdapter> participant(Integer reportId,
			Integer pageNumber) {
		// TODO Auto-generated method stub
		return null;
	}

	public ParticipantReadAdapter participantOpen(Integer participantId) {
		// TODO Auto-generated method stub
		return null;
	}

	public Page<FollowUpReadAdapter> followUp(Integer reportId,
			Integer pageNumber) {
		// TODO Auto-generated method stub
		return null;
	}

	public FollowUpReadAdapter followUpOpen(Integer followUpId) {
		// TODO Auto-generated method stub
		return null;
	}


}

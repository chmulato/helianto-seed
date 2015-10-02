package com.iservport.report.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.helianto.task.repository.ReportAdapter;
import org.helianto.task.repository.ReportPhaseAdapter;
import org.helianto.task.repository.ReportPhaseRepository;
import org.helianto.task.repository.ReportRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;

import com.iservport.report.repository.ReportReviewReadAdapter;
import com.iservport.report.repository.ReportReviewTempRepository;

/**
 * Report query service.
 * 
 * @author Eldevan Nery Junior.
 */
@Service
public class ReportQueryService {

	private static final Logger logger = LoggerFactory.getLogger(ReportQueryService.class);
	
	@Inject
	private ReportRepository reportRepository;
	
	@Inject
	private ReportPhaseRepository reportPhaseRepository;
	
	@Inject
	private ReportReviewTempRepository reportReviewTempRepository;  

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

	public List<Map<String,Object>> reportBaseLine(Integer baseLineId) {
		// TODO Auto-generated method stub
		return null;
	}

/**	public Page<ParticipantReadAdapter> participant(Integer reportId,
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

**/
}

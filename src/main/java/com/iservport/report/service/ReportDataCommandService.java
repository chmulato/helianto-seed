package com.iservport.report.service;

import java.util.Date;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.iservport.report.domain.ReportBaseLine;
import com.iservport.report.domain.ReportData;
import com.iservport.report.repository.ReportBaseLineRepository;
import com.iservport.report.repository.ReportDataRepository;

/**
 * ReportData command service.
 * 
 * @author Raphael Lira.
 */
@Service
public class ReportDataCommandService {

	@Inject
	protected ReportDataRepository reportDataRepository;

	@Inject
	private ReportBaseLineRepository reportBaseLineRepository; 

	public ReportData newReportData(Integer reportBaseLineId){
		ReportBaseLine reportBaseLine = reportBaseLineRepository.findOne(reportBaseLineId);
		return new ReportData(reportBaseLine, new Date());
	}
	
	public ReportData reportData(ReportData command){
		ReportData target = null;
		if (command.getId()==0) {
			target = newReportData(command.getReportBaseLineId());
			//TODO verify if exist.
			
		}else{
			//TODO update fields.
			
			target = reportDataRepository.findOne(command.getId());
		}
		return reportDataRepository.saveAndFlush(target); 
	}
	
}

package com.iservport.report.service;

import javax.inject.Inject;

import org.helianto.seed.PageDecorator;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;

import com.iservport.report.domain.ReportData;
import com.iservport.report.repository.ReportDataRepository;

/**
 * ReportData query service.
 * 
 * @author Raphael Lira.
 */
@Service
public class ReportDataQueryService {

	@Inject
	protected ReportDataRepository reportDataRepository;
	

	public ReportData getOne(Integer id){
		
		return reportDataRepository.findOne(id);
	}
	
	public Page<ReportData> list(int reportBaseLineId, Integer pageNumber,  Integer size) {
		Pageable page = new PageRequest(pageNumber, size,Direction.ASC, "folderCode");
		return new PageDecorator<> (reportDataRepository.findByReportBaseLineId(reportBaseLineId, page));
	}


//	public List<ReportData> getUserList(UserAuthentication userAuthentication) {
//		return ReportDataQueryService.userList().getContent();
//	}


}

package com.iservport.report.service;

import javax.inject.Inject;

import org.helianto.seed.PageDecorator;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;

import com.iservport.report.domain.ReportBaseLine;
import com.iservport.report.repository.ReportBaseLineRepository;

/**
 * ReportBaseLine query service.
 * 
 * @author Eldevan Nery Junior.
 */
@Service
public class ReportBaseLineQueryService {

	@Inject
	private ReportBaseLineRepository reportBaseLineRepository;
	
	/**
	 * Seleciona um por id.
	 * 
	 * @param id
	 * 
	 */
	public ReportBaseLine	getOne(Integer id){
		return reportBaseLineRepository.findOne(id);
	}
	
	/**
	 * Lista por projeto
	 * 
	 * @param reportFolderId
	 * @param pageNumber
	 * @param size
	 * 
	 */
	public PageDecorator<ReportBaseLine> list(int reportFolderId, Integer pageNumber, Integer size) {
		Pageable page = new PageRequest(pageNumber, size, Direction.ASC, "reportFolder.id");
		return new PageDecorator<>(reportBaseLineRepository.findByReportFolderId(reportFolderId, page));
	}
	
}

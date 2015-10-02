package com.iservport.report.service;

import javax.inject.Inject;

import org.helianto.security.internal.UserAuthentication;
import org.helianto.task.domain.ReportFolder;
import org.helianto.task.repository.ReportFolderRepository;
import org.springframework.stereotype.Service;

import com.iservport.report.domain.ReportBaseLine;
import com.iservport.report.repository.ReportBaseLineRepository;

/**
 * Report BaseLine command service.
 * 
 * @author Eldevan Nery Junior
 */
@Service
public class ReportBaseLineCommandService {

	@Inject
	private ReportBaseLineRepository reportBaseLineRepository;
	
	@Inject
	private ReportFolderRepository reportFolderRepository;
	
	/**
	 * Nova instância.
	 *  
	 * @param reportFolderId
	 * 
	 */
	public ReportBaseLine newReportBaseLine(Integer reportFolderId){
		ReportFolder reportFolder  = reportFolderRepository.findOne(reportFolderId);
		//TODO sequence?
		return new ReportBaseLine(reportFolder, 0);
	}
	
	/**
	 * Cria ou Atualiza baseLine.
	 * 
	 * @param command
	 * 
	 */
	public ReportBaseLine baseLine(UserAuthentication userAuthentication, ReportBaseLine command){
		ReportBaseLine target = null;
		if(command.getId()==0){
			//create 
			target = newReportBaseLine(command.getReportFolderId());
			//verify if exists TODO
		}else{
//			target = reportBaseLineRepository.findById(command.getId());
			target = target.setReportBaseLine(command);
		}
		return reportBaseLineRepository.saveAndFlush(target);
	}
	

}
package com.iservport.report.service;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.helianto.core.domain.Entity;
import org.helianto.core.repository.EntityRepository;
import org.helianto.core.repository.IdentityRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.iservport.task.domain.ReportFolder;
import com.iservport.task.domain.ReportFolderExported;
import com.iservport.task.repository.ReportFolderExportedRepository;
import com.iservport.task.repository.ReportFolderRepository;

/**
 * Report command service.
 * 
 * @author Eldevan Nery Junior
 */
@Service
public class ReportFolderExportedCommandService {

	public static final int DAYS_TO_WARN = 30;
	
	private static final Logger logger = LoggerFactory.getLogger(ReportFolderExportedCommandService.class);
	
	@Inject
	protected ReportFolderRepository reportFolderRepository;

	@Inject
	protected EntityRepository entityRepository;

	@Inject 
	protected IdentityRepository identityRepository;

	@Inject 
	protected ReportFolderExportedRepository reportFolderExportedRepository;
	
	//PASTA

	/** 
	 * Nova pasta exportada.
	 * 
	 * @param entityId
	 */
	public ReportFolderExported folderExportedNew(Integer entityId, Integer reportFolderId) {
		Entity entity = entityRepository.findOne(entityId);
		ReportFolder folder = reportFolderRepository.findOne(reportFolderId);
		if (entity!=null && folder !=null) {
			return new ReportFolderExported(folder, entity);
		}
		throw new UnsupportedOperationException("folder and entity required.");
	}
	
	/**
	 * 
	 * Exporta ou retira exportação baseado na lista de entidades enviadas.
	 * 
	 * @param reportFolderId
	 * @param entitiesIds
	 * @param exporterId
	 * @return
	 */
	public boolean export(Integer reportFolderId, List<Integer> entitiesIds, Integer exporterId ){
		if(entitiesIds==null){
			entitiesIds = new ArrayList<>();
		}
		List<Integer> entitiesExportedIds = reportFolderExportedRepository.exclusions(reportFolderId);
		//exporta para as entidades enviadas(entitiesIds) 
		//se elas ainda não veêm a pasta(!entitiesExportedIds.contains(entityId))
		for (Integer entityId : entitiesIds) {
			if (!entitiesExportedIds.contains(entityId)){
				ReportFolderExported folderExported = folderExportedNew(entityId, reportFolderId);
				folderExported.setExporter(identityRepository.findOne(exporterId));
				reportFolderExportedRepository.saveAndFlush(folderExported);
			}
		}
		entitiesExportedIds = reportFolderExportedRepository.exclusions(reportFolderId);
		// remove exportação se há entidades relacionadas à pasta(entitiesExportedIds)
		// que não estão na lista enviada(enititiesIds)
		for (Integer exportedEntity : entitiesExportedIds) {
			if (!entitiesIds.contains(exportedEntity)) {
				ReportFolderExported toDelete = reportFolderExportedRepository.
						findByExportedEntityIdAndReportFolderId(exportedEntity, reportFolderId);
				if(toDelete!=null){
					reportFolderExportedRepository.delete(toDelete); 	
				}
			}
		}
		return true;
	}
	

	
}

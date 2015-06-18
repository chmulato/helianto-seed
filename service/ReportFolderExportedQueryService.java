package com.iservport.report.service;

import java.util.List;

import javax.inject.Inject;

import org.helianto.core.domain.Entity;
import org.helianto.core.repository.EntityReadAdapter;
import org.helianto.core.repository.EntityRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;

import com.iservport.home.internal.FolderReadAdapter;
import com.iservport.task.repository.ReportFolderExportedRepository;

/**
 * Report query service.
 * 
 * @author Eldevan Nery Junior.
 */
@Service
public class ReportFolderExportedQueryService {

	public static final int DAYS_TO_WARN = 30;
	
	private static final Logger logger = LoggerFactory.getLogger(ReportFolderExportedQueryService.class);
	
	@Inject
	protected ReportFolderExportedRepository reportFolderExportedRepository;
	
	@Inject 
	protected EntityRepository entityRepository;

	// exported Folders.
	
	public Page<FolderReadAdapter> folder(Integer entityId, Integer pageNumber) {
		Pageable page = new PageRequest(pageNumber, 25, Direction.ASC, "id");
		return reportFolderExportedRepository.findByEntity_Id(entityId, page);
	}
	
	public Page<EntityReadAdapter> entities(Integer identityId, Integer entityId, Integer reportFolderId ){
		Entity entity = entityRepository.findOne(entityId);
		List<Integer> exclusions  = reportFolderExportedRepository.exclusions(reportFolderId);
		exclusions.add(entityId);
		Pageable page = new PageRequest(0, 100, Direction.ASC, "id");
		return entityRepository.findByIdentityIdAndEntityType(identityId, entity.getEntityType(), 'A', 'A', exclusions, page);
	}
	
	
	public Page<EntityReadAdapter> entities(Integer reportFolderId){
		Pageable page = new PageRequest(0, 100, Direction.ASC, "id");
		return reportFolderExportedRepository.findByReportFolderId(reportFolderId, page);
	}
	
}

package com.iservport.report.service;

import javax.inject.Inject;

import org.helianto.core.domain.Category;
import org.helianto.core.repository.CategoryRepository;
import org.helianto.partner.domain.Partner;
import org.helianto.partner.repository.PartnerRepository;
import org.helianto.user.domain.User;
import org.helianto.user.domain.UserGroup;
import org.helianto.user.repository.UserGroupRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.iservport.report.domain.Project;
import com.iservport.report.repository.ProjectRepository;

/**
 * Project command service.
 * 
 * @author mauriciofernandesdecastro
 */
@Service
public class ProjectCommandService {
	
	private static final Logger logger = LoggerFactory.getLogger(ProjectCommandService.class);
	
	@Inject
	protected UserGroupRepository userRepository;

	@Inject
	protected CategoryRepository categoryRepository;

	@Inject
	protected PartnerRepository partnerRepository;

	@Inject
	private ProjectRepository projectRepository;

	/**
	 * Pasta.
	 * 
	 * @param userId
	 * @param command
	 */
	public Project project(int userId, Project command) {
		User user = (User) userRepository.findOne(userId);
		if (user==null) {
			throw new IllegalArgumentException("Unable to persist, owner not found.");
		}
		Project project = null;
		if (command==null) {
			throw new IllegalArgumentException("Unable to persist null project.");
		}
		if (command.getId()==0) {
			logger.debug("New project.");
			project = command;
			project.setEntity(user.getEntity());
			project.setOwner(user.getIdentity());
			Category category = categoryRepository.findOne(command.getCategoryId());
			project.setCategory(category);
			Partner partner = partnerRepository.findOne(command.getPartnerId());
			project.setPartner(partner);
			UserGroup userGroup = userRepository.findOne(command.getUserGroupId());
			project.setUserGroup(userGroup);
		}
		else {
			project = projectRepository.findOne(command.getId());
		}
		project.setFolderCode(command.getFolderCode());
		project.setContent(command.getContent());
		project.setEncoding(command.getEncoding());
		project.setReportNumberPattern(command.getReportNumberPattern());
		project.setPatternSuffix(command.getPatternSuffix());
		project.setParsedContent(command.getParsedContent());
		project.setPrivacyLevel(command.getPrivacyLevel());
		project.setZIndex(command.getZIndex());
		project.setFolderCaption(command.getFolderCaption());
		project.setParentPath(command.getParentPath());
		project.setNature(command.getNature());
		project.setTraceabilityItems(command.getTraceabilityItems());
		project.setStartDate(command.getStartDate());
		project.setEndDate(command.getEndDate());
		project.setVolumeTags(command.getVolumeTags());
		project.setCategoryOverrideAllowed(command.isCategoryOverrideAllowed());
		project.setDeliverables(command.getDeliverables());
		project.setAssumptions(command.getAssumptions());
		project.setBenefits(command.getBenefits());
		project.setTools(command.getTools());
		return projectRepository.saveAndFlush(project) ;
	}
}

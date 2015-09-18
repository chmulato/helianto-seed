package com.iservport.report.domain;

import java.util.Date;

import javax.persistence.DiscriminatorValue;
import javax.persistence.Lob;

import org.helianto.core.domain.Category;
import org.helianto.core.domain.Entity;
import org.helianto.task.def.ReportFolderContentType;
import org.helianto.task.domain.ReportFolder;
import org.helianto.user.domain.User;

/**
 * Projetos.
 * 
 * @author mauriciofernandesdecastro
 */
@javax.persistence.Entity
@DiscriminatorValue("J")
public class Project 
	extends ReportFolder
{

	private static final long serialVersionUID = 1L;
	
	@Lob
	private String benefits;
	
	@Lob
	private String assumptions;
	
	@Lob
	private String deliverables;
	
	@Lob
	private String constraints;
	
	@Lob
	private String tools;
	
	/**
	 * Default constructor.
	 */
	public Project() {
		this(null, "");
	}

    /** 
     * Key constructor.
     * 
     * @param entity
     * @param folderCode
     */
    public Project(Entity entity, String folderCode) {
    	super(entity, folderCode);
    	setContentTypeAsEnum(ReportFolderContentType.PORTFOLIO);
    }
    
    /**
     * Create constructor.
     * 
     * @param entityId
     * @param ownerId
     * @param categoryId
     * @param partnerId
     * @param userGroupId
     */
	public Project(int entityId
			, int ownerId
			, int categoryId
			, int partnerId
			, int userGroupId) {
		super();
		setEntityId(entityId);
		setOwnerId(ownerId);
		setCategoryId(categoryId);
		setPartnerId(partnerId);
		setUserGroupId(userGroupId);
	}

	/**
	 * Form constructor.
	 * 
	 * @param id
	 * @param entityId
	 * @param folderCode
	 * @param content
	 * @param encoding
	 * @param ownerId
	 * @param reportNumberPattern
	 * @param patternSuffix
	 * @param parsedContent
	 * @param categoryId
	 * @param privacyLevel
	 * @param zIndex
	 * @param partnerId
	 * @param userGroupId
	 * @param folderCaption
	 * @param parentPath
	 * @param nature
	 * @param traceabilityItems
	 * @param startDate
	 * @param endDate
	 * @param volumeTags
	 * @param categoryOverrideAllowed
	 * @param benefits
	 * @param assumptions
	 * @param deliverables
	 * @param constraints
	 * @param tools
	 */
	public Project(int id
			, int entityId
			, String folderCode
			, byte[] content
			, String encoding
			, int ownerId
			, String reportNumberPattern
			, String patternSuffix
			, String parsedContent
			, int categoryId
			, char privacyLevel
			, String zIndex
			, int partnerId
			, int userGroupId
			, String folderCaption
			, String parentPath
			, String nature
			, String traceabilityItems
			, Date startDate
			, Date endDate
			, String volumeTags
			, boolean categoryOverrideAllowed
			, String benefits
			, String assumptions
			, String deliverables
			, String constraints
			, String tools) {
		super(id, entityId, folderCode, content, encoding, ownerId, reportNumberPattern, patternSuffix, parsedContent,
				categoryId, privacyLevel, zIndex, partnerId, userGroupId, folderCaption, parentPath, nature, traceabilityItems,
				startDate, endDate, volumeTags, categoryOverrideAllowed);
		setBenefits(benefits);
		setAssumptions(assumptions);
		setDeliverables(deliverables);
		setConstraints(constraints);
		setTools(tools);
	}

	public Project(User user, char contentType) {
		super(user, contentType);
	}

	public Project(User user) {
		super(user);
	}

	public String getBenefits() {
		return benefits;
	}
	public void setBenefits(String benefits) {
		this.benefits = benefits;
	}

	public String getAssumptions() {
		return assumptions;
	}
	public void setAssumptions(String assumptions) {
		this.assumptions = assumptions;
	}

	public String getDeliverables() {
		return deliverables;
	}
	public void setDeliverables(String deliverables) {
		this.deliverables = deliverables;
	}

	public String getConstraints() {
		return constraints;
	}
	public void setConstraints(String constraints) {
		this.constraints = constraints;
	}
	
	// Tarefas
     public String getTools(){
    	 return tools;
     }
    
     public void setTools(String tools){
    	 this.tools = tools;
    	 
     }
    
}

package com.iservport.report.domain;

import java.util.Date;
import java.util.Set;

import javax.persistence.DiscriminatorValue;
import javax.persistence.Lob;
import javax.persistence.OneToMany;
import javax.persistence.Transient;

import org.helianto.core.domain.Entity;
import org.helianto.task.def.ReportFolderContentType;
import org.helianto.task.def.Resolution2;
import org.helianto.task.domain.ReportFolder;
import org.helianto.user.domain.User;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.iservport.user.domain.UserJournal;

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
	
	@JsonIgnore
	@OneToMany(mappedBy="reportFolder")
	private Set<UserJournal> userJournals;

	@Transient
    private Date checkinDate;
	
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
	 * @param folderName
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
			, Integer entityId
			, String folderCode
			, String folderName
			, byte[] content
			, String encoding
			, int ownerId
			, String reportNumberPattern
			, String patternSuffix
			, String parsedContent
			, Integer categoryId
			, char privacyLevel
			, String zIndex
			, Integer partnerId
			, Integer userGroupId
			, String folderCaption
			, String parentPath
			, Resolution2 resolution
			, String nature
			, String traceabilityItems
			, Date startDate
			, Date endDate
			, String volumeTags
			, Boolean categoryOverrideAllowed
			, String benefits
			, String assumptions
			, String deliverables
			, String constraints
			, String tools) {
		super(id, entityId, folderCode, content, encoding, ownerId, reportNumberPattern, patternSuffix, parsedContent,
				categoryId, privacyLevel, zIndex, partnerId, userGroupId, folderCaption, parentPath, nature, traceabilityItems,
				startDate, endDate, volumeTags, categoryOverrideAllowed);
		setFolderName(folderName);
		setResolution(resolution);
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
     
     public Set<UserJournal> getUserJournals() {
		return userJournals;
	 }
     public void setUserJournals(Set<UserJournal> userJournals) {
		this.userJournals = userJournals;
	 }

 	public Date getCheckinDate() {
 		return checkinDate;
 	}
 	public void setCheckinDate(Date checkinDate) {
 		this.checkinDate = checkinDate;
 	}

     /**
      * Merger.
      * 
      * @param command
      */
     public Project merge(Project command) {
 		setFolderName(command.getFolderName());
 		setContent(command.getContent());
 		setEncoding(command.getEncoding());
 		setReportNumberPattern(command.getReportNumberPattern());
 		setPatternSuffix(command.getPatternSuffix());
 		setParsedContent(command.getParsedContent());
 		setPrivacyLevel(command.getPrivacyLevel());
 		setZIndex(command.getZIndex());
 		setFolderCaption(command.getFolderCaption());
 		setParentPath(command.getParentPath());
 		setNature(command.getNature());
 		setResolution(command.getResolution());
 		setTraceabilityItems(command.getTraceabilityItems());
 		setStartDate(command.getStartDate());
 		setEndDate(command.getEndDate());
 		setCheckinDate(command.getCheckinDate());
 		setVolumeTags(command.getVolumeTags());
 		setCategoryOverrideAllowed(command.isCategoryOverrideAllowed());
 		setDeliverables(command.getDeliverables());
 		setAssumptions(command.getAssumptions());
 		setBenefits(command.getBenefits());
 		setTools(command.getTools());
 		return this;
     }
}

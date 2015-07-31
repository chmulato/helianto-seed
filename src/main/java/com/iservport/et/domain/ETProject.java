package com.iservport.et.domain;

import java.io.Serializable;
import java.util.Date;

/**
 * Enterprise Tester Project.
 * 
 * @author mauriciofernandesdecastro
 */
public class ETProject implements Serializable {
	
	private static final long serialVersionUID = 1L;

	private String id; //": "53fd922b-eece-430e-8dc5-a35a00acf0cd",
	
	private String name; //ProjetoTeste",
	
	private String organisationId; //1f1acfdc-c9c1-497a-8361-a35901613432",
	
	private String organisationName; //Prime Control",
	
	private String projectCategoryId; //d779453e-d586-4ead-83b9-a49e00ff36e5",
	
	private String projectCategoryName; //Treinamento",
	
	private String description; //null,
	
	private String estimatedEndDate; //null,
	
	private String managerId; //fbeaf485-b308-4934-afe4-a35a00bbcca7",
	
	private String managerUserName; //fabricio",
	
	private String sSlug; //projetoteste",
	
	private Boolean autoNumberRequirements; //false,
	
	private Boolean autoNumberScripts; //false,
	
	private Boolean independent; //false,
	
	private Boolean requirementNumberReadOnly; //true,
	
	private Boolean scriptNumberReadOnly; //true,
	
	private Integer orderNumber; //1,
	
	private Date startDate; //null,
	
	/**
	 * Constructor.
	 */
	public ETProject() {
		super();
	}

	/**
	 * Constructor.
	 * 
	 * @param id
	 */
	public ETProject(String id) {
		this();
		setId(id);
	}

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}

	public String getOrganisationId() {
		return organisationId;
	}
	public void setOrganisationId(String organisationId) {
		this.organisationId = organisationId;
	}

	public String getOrganisationName() {
		return organisationName;
	}
	public void setOrganisationName(String organisationName) {
		this.organisationName = organisationName;
	}

	public String getProjectCategoryId() {
		return projectCategoryId;
	}
	public void setProjectCategoryId(String projectCategoryId) {
		this.projectCategoryId = projectCategoryId;
	}

	public String getProjectCategoryName() {
		return projectCategoryName;
	}
	public void setProjectCategoryName(String projectCategoryName) {
		this.projectCategoryName = projectCategoryName;
	}

	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}

	public String getEstimatedEndDate() {
		return estimatedEndDate;
	}
	public void setEstimatedEndDate(String estimatedEndDate) {
		this.estimatedEndDate = estimatedEndDate;
	}

	public String getManagerId() {
		return managerId;
	}
	public void setManagerId(String managerId) {
		this.managerId = managerId;
	}

	public String getManagerUserName() {
		return managerUserName;
	}
	public void setManagerUserName(String managerUserName) {
		this.managerUserName = managerUserName;
	}

	public String getsSlug() {
		return sSlug;
	}
	public void setsSlug(String sSlug) {
		this.sSlug = sSlug;
	}

	public Boolean getAutoNumberRequirements() {
		return autoNumberRequirements;
	}
	public void setAutoNumberRequirements(Boolean autoNumberRequirements) {
		this.autoNumberRequirements = autoNumberRequirements;
	}

	public Boolean getAutoNumberScripts() {
		return autoNumberScripts;
	}
	public void setAutoNumberScripts(Boolean autoNumberScripts) {
		this.autoNumberScripts = autoNumberScripts;
	}

	public Boolean getIndependent() {
		return independent;
	}
	public void setIndependent(Boolean independent) {
		this.independent = independent;
	}

	public Boolean getRequirementNumberReadOnly() {
		return requirementNumberReadOnly;
	}
	public void setRequirementNumberReadOnly(Boolean requirementNumberReadOnly) {
		this.requirementNumberReadOnly = requirementNumberReadOnly;
	}

	public Boolean getScriptNumberReadOnly() {
		return scriptNumberReadOnly;
	}
	public void setScriptNumberReadOnly(Boolean scriptNumberReadOnly) {
		this.scriptNumberReadOnly = scriptNumberReadOnly;
	}

	public Integer getOrderNumber() {
		return orderNumber;
	}
	public void setOrderNumber(Integer orderNumber) {
		this.orderNumber = orderNumber;
	}

	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	
	
}

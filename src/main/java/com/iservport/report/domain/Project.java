package com.iservport.report.domain;

import javax.persistence.DiscriminatorValue;
import javax.persistence.Lob;

import org.helianto.core.domain.Entity;
import org.helianto.task.def.ReportFolderContentType;
import org.helianto.task.domain.ReportFolder;

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

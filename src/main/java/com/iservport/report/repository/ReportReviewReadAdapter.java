package com.iservport.report.repository;

import java.io.Serializable;
import java.util.Date;

import org.helianto.core.domain.Identity;
import org.helianto.task.domain.Report;
import org.helianto.task.domain.ReportReview;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Adaptador para leitura de monitoramentos.
 *
 * @author mauriciofernandesdecastro
 */
public class ReportReviewReadAdapter
	implements Serializable
{

	private static final long serialVersionUID = 1L;
	
	private ReportReview adaptee;

	private Integer id;

	private Integer reportId;

	private Integer identityId;
	
    private Integer workflowLevel;

	private String firstName;

	private String lastName;

	private String displayName;

	private Date issueDate;
	
	private Date nextCheckDate;

	private Character resolution;

	private String reviewText;

	private String parsedContent;

	public ReportReviewReadAdapter() {
		super();
	}
	
	/**
	 * 	 Construtor.
	 * 
	 * @param id
	 * @param reportId
	 * @param identityId
	 * @param workflowLevel
	 * @param firstName
	 * @param lastName
	 * @param displayName
	 * @param issueDate
	 * @param nextCheckDate
	 * @param resolution
	 * @param reviewText
	 * @param parsedContent
	 */
	public ReportReviewReadAdapter(
		Integer id
		, Integer reportId
		, Integer identityId
		, Integer workflowLevel
		, String firstName
		, String lastName
		, String displayName
		, Date issueDate
		, Date nextCheckDate
		, Character resolution
		, String reviewText
		, String parsedContent
		) {
		super();
		this.id = id;
		this.reportId = reportId;
		this.identityId = identityId;
		this.workflowLevel = workflowLevel;
		this.firstName = firstName;
		this.lastName = lastName;
		this.displayName = displayName;
		this.issueDate = issueDate;
		this.resolution = resolution;
		this.reviewText = reviewText;
		this.parsedContent = parsedContent;
		this.nextCheckDate = nextCheckDate;
	}
	
	public ReportReviewReadAdapter(ReportReview adaptee) {
		super();
		this.adaptee = adaptee;
	}
	@JsonIgnore
	public ReportReview getAdaptee() {
		return adaptee;
	}
	
	public ReportReviewReadAdapter setAdaptee(ReportReview adaptee) {
		this.adaptee = adaptee;
		return this;
	}
	
	public ReportReviewReadAdapter build(Report report, Identity identity){
		if (adaptee==null) {
			throw new RuntimeException();
		}
		return new ReportReviewReadAdapter(adaptee.getId(), report.getId(), identity.getId(), adaptee.getWorkflowLevel(),  
				identity.getIdentityFirstName(), identity.getIdentityLastName(), identity.getDisplayName(), 
				adaptee.getIssueDate(), report.getNextCheckDate(), adaptee.getResolution(), adaptee.getReviewText(), 
				adaptee.getParsedContent());
	}
	
	
	public ReportReview merge(){
		adaptee.setId(getId());
		adaptee.setIssueDate(getIssueDate());
		adaptee.setResolution(getResolution());
		adaptee.setReviewText(getReviewText());
		adaptee.setParsedContent(getParsedContent());
		adaptee.setWorkflowLevel(getWorkflowLevel());
		return adaptee;
		
	}
	
	
	public Integer getId() {
		return id;
	}

	public Integer getReportId() {
		return reportId;
	}

	public Integer getIdentityId() {
		return identityId;
	}
	
	public Integer getWorkflowLevel() {
		return workflowLevel;
	}
	public void setWorkflowLevel(Integer workflowLevel) {
		this.workflowLevel = workflowLevel;
	}

	public String getFirstName() {
		return firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public String getDisplayName() {
		return displayName;
	}

	public Date getIssueDate() {
		return issueDate;
	}

	public Character getResolution() {
		return resolution;
	}

	public String getReviewText() {
		return reviewText;
	}

	public String getParsedContent() {
		return parsedContent;
	}

	public Date getNextCheckDate() {
		return nextCheckDate;
	}
	public void setNextCheckDate(Date nextCheckDate) {
		this.nextCheckDate = nextCheckDate;
	}
	
	public String getResolutionIcon() {
		switch(this.getResolution()){
		case 'T': return "fa fa-clock-o";
		case 'D': return "fa fa-check-circle-o";
		case 'P': return "fa fa-times-circle-o";
		}
		return "fa fa-circle-o";
	}
	
	
	@Override
	public int hashCode() {
		return 31 + ((id == null) ? 0 : id.hashCode());
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj) return true;
		if (obj == null) return false;
		if (getClass() != obj.getClass()) return false;
		ReportReviewReadAdapter other = (ReportReviewReadAdapter) obj;
		if (id == null) {
			if (other.id != null) return false;
		} else if (!id.equals(other.id)) return false;
		return true;
	}

}


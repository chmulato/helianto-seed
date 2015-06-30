package com.iservport.user.repository.adapter;

import java.io.Serializable;
import java.util.Date;

/**
 * Adaptador para avaliações de competência.
 * 
 * @author mauriciofernandesdecastro
 */
public class CompetenceAssessmentReadAdapter 
	implements Serializable
{
	
	private static final long serialVersionUID = 1L;

	private int id;
	
	private byte[] content;
	
	private Date issueDate;
	
	private char resolution;
	
	private char knowledgeLevel;
	
	private Date nextCheckDate;
	
	private String ownerName;
	
	private char userAssessmentType;
	
	private int countItems;
	
	private int countAlerts;
	
	private int countWarnings;
	
	/**
	 * Constructor.
	 * 
	 * @param id
	 * @param docName
	 * @param issueDate
	 * @param resolution
	 * @param nextCheckDate
	 * @param ownerName
	 * @param knowledgeLevel
	 */
	public CompetenceAssessmentReadAdapter(int id, String docName, Date issueDate
			, char resolution, Date nextCheckDate, String ownerName, char knowledgeLevel) {
		this(id, docName.getBytes(), issueDate
			, resolution, nextCheckDate, ownerName, 'D', knowledgeLevel);
	}
	
	/**
	 * Constructor.
	 * 
	 * @param id
	 * @param content
	 * @param issueDate
	 * @param resolution
	 * @param nextCheckDate
	 * @param ownerName
	 * @param userAssessmentType
	 */
	public CompetenceAssessmentReadAdapter(int id, byte[] content, Date issueDate
			, char resolution, Date nextCheckDate, String ownerName, char userAssessmentType) {
		this(id, content, issueDate, resolution, nextCheckDate, ownerName, userAssessmentType, '0');
	}

	/**
	 * Constructor.
	 * 
	 * @param id
	 * @param content
	 * @param issueDate
	 * @param resolution
	 * @param nextCheckDate
	 * @param ownerName
	 * @param userAssessmentType
	 * @param knowledgeLevel
	 */
	public CompetenceAssessmentReadAdapter(int id, byte[] content, Date issueDate
			, char resolution, Date nextCheckDate, String ownerName
			, char userAssessmentType, char knowledgeLevel) {
		super();
		this.id = id;
		this.content = content;
		this.issueDate = issueDate;
		this.resolution = resolution;
		this.nextCheckDate = nextCheckDate;
		this.ownerName = ownerName;
		this.userAssessmentType = userAssessmentType;
		this.knowledgeLevel = knowledgeLevel;
	}

	public int getId() {
		return id;
	}

	public byte[] getContent() {
		return content;
	}
	
	public String getContentAsString() {
		if (getContent()!=null) {
			return new String(getContent());
		}
		return "";
	}
	
	public Date getIssueDate() {
		return issueDate;
	}
	
	public char getResolution() {
		return resolution;
	}
	
	public char getKnowledgeLevel() {
		return knowledgeLevel;
	}
	
	public Date getNextCheckDate() {
		return nextCheckDate;
	}
	
	public String getOwnerName() {
		if (ownerName!=null) {
			return ownerName;
		}
		return "";
	}
	
	public char getUserAssessmentType() {
		return userAssessmentType;
	}
	
	public int getCountItems() {
		return countItems;
	}
	public void setCountItems(int countItems) {
		this.countItems = countItems;
	}
	
	public int getCountAlerts() {
		return countAlerts;
	}
	public void setCountAlerts(int countAlerts) {
		this.countAlerts = countAlerts;
	}
	
	public int getCountWarnings() {
		return countWarnings;
	}
	public void setCountWarnings(int countWarnings) {
		this.countWarnings = countWarnings;
	}
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + id;
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj) {
			return true;
		}
		if (obj == null) {
			return false;
		}
		if (!(obj instanceof CompetenceAssessmentReadAdapter)) {
			return false;
		}
		CompetenceAssessmentReadAdapter other = (CompetenceAssessmentReadAdapter) obj;
		if (id != other.id) {
			return false;
		}
		return true;
	}

}

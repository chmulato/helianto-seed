package com.iservport.report.repository;

import java.io.Serializable;
import java.util.Date;

import org.helianto.core.domain.Identity;
import org.helianto.task.domain.FollowUp;
import org.helianto.task.domain.Report;

/**
 * Adaptador para leitura de comentários.
 *
 * @author mauriciofernandesdecastro
 */
public class FollowUpReadAdapter
	implements Serializable
{

	private static final long serialVersionUID = 1L;
	
	private FollowUp adaptee ;

	private Integer id;

	private Integer reportId;

	private Long internalNumber;

	private Integer identityId;

	private String firstName;

	private String lastName;

	private String displayName;

	private Date followUpDate;

	private String followUpDesc;

	/**
	 * Construtor.
	 *
	 * @param id
	 * @param reportId;
	 * @param internalNumber;
	 * @param identityId;
	 * @param firstName;
	 * @param lastName;
	 * @param displayName;
	 * @param followUpDate;
	 * @param followUpDesc;
	 */
	public FollowUpReadAdapter(
		Integer id
		, Integer reportId
		, Long internalNumber
		, Integer identityId
		, String firstName
		, String lastName
		, String displayName
		, Date followUpDate
		, String followUpDesc
		) {
		super();
		this.id = id;
		this.reportId = reportId;
		this.internalNumber = internalNumber;
		this.identityId = identityId;
		this.firstName = firstName;
		this.lastName = lastName;
		this.displayName = displayName;
		this.followUpDate = followUpDate;
		this.followUpDesc = followUpDesc;
	}

	/**
	 * Adaptee contructor.
	 * 
	 * @param adaptee
	 */
	public FollowUpReadAdapter(FollowUp adaptee) {
		super();
		this.adaptee = adaptee;
	}
	
	public FollowUpReadAdapter  build(Report report, Identity identity){
		if (adaptee==null) {
			throw new RuntimeException("Null participant cannot be persisted.");
		}
		return new FollowUpReadAdapter(adaptee.getId(), report.getId(), adaptee.getInternalNumber(), identity.getId(), 
				identity.getIdentityFirstName(), identity.getIdentityLastName(), identity.getDisplayName(), 
				adaptee.getIssueDate(), adaptee.getFollowUpDesc());
	}
	
	public FollowUp getAdaptee() {
		return adaptee;
	}

	public Integer getId() {
		return id;
	}

	public Integer getReportId() {
		return reportId;
	}

	public Long getInternalNumber() {
		return internalNumber;
	}
	
	public Integer getIdentityId() {
		return identityId;
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

	public Date getFollowUpDate() {
		return followUpDate;
	}

	public String getFollowUpDesc() {
		return followUpDesc;
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
		FollowUpReadAdapter other = (FollowUpReadAdapter) obj;
		if (id == null) {
			if (other.id != null) return false;
		} else if (!id.equals(other.id)) return false;
		return true;
	}

}


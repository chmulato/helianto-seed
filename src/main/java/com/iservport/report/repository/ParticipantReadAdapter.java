package com.iservport.report.repository;

import java.io.Serializable;

import org.helianto.core.domain.Identity;
import org.helianto.task.domain.Participant;
import org.helianto.task.domain.Report;

/**
 * Adaptador para leitura de participantes.
 *
 * @author mauriciofernandesdecastro
 */
public class ParticipantReadAdapter
	implements Serializable
{

	private static final long serialVersionUID = 1L;

	private Participant adaptee;
	
	private Integer id;

	private Integer reportId;

	private Integer identityId;

	private String firstName;

	private String lastName;

	private String displayName;

	private Character assignmentType;

	private Integer staffMemberId;

	/**
	 * Construtor.
	 *
	 * @param id
	 * @param reportId;
	 * @param sequence;
	 * @param identityId;
	 * @param firstName;
	 * @param lastName;
	 * @param displayName;
	 * @param assignmentType;
	 * @param staffMemberId;
	 */
	public ParticipantReadAdapter(
		Integer id
		, Integer reportId
		, Integer identityId
		, String firstName
		, String lastName
		, String displayName
		, Character assignmentType
		, Integer staffMemberId
		) {
		super();
		this.id = id;
		this.reportId = reportId;
		this.identityId = identityId;
		this.firstName = firstName;
		this.lastName = lastName;
		this.displayName = displayName;
		this.assignmentType = assignmentType;
		this.staffMemberId = staffMemberId;
	}
	
	/**
	 * Adaptee c
	 * @param adaptee
	 */
	public ParticipantReadAdapter(Participant adaptee) {
		super();
		this.adaptee = adaptee;
	}
	
	public ParticipantReadAdapter build(Report report, Identity identity){
		if (adaptee==null) {
			throw new RuntimeException("Null participant cannot be persisted.");
		}
		//TODO verify participant.getStaffMember().getId()
		return new ParticipantReadAdapter(adaptee.getId(), report.getId(), identity.getId(), 
				identity.getIdentityFirstName(), identity.getIdentityLastName(), identity.getDisplayName(), 
				adaptee.getAssignmentType(), adaptee.getStaffMember().getId());
	}

	public Participant getAdaptee() {
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

	public String getFirstName() {
		return firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public String getDisplayName() {
		return displayName;
	}

	public Character getAssignmentType() {
		return assignmentType;
	}

	public Integer getStaffMemberId() {
		return staffMemberId;
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
		ParticipantReadAdapter other = (ParticipantReadAdapter) obj;
		if (id == null) {
			if (other.id != null) return false;
		} else if (!id.equals(other.id)) return false;
		return true;
	}

}

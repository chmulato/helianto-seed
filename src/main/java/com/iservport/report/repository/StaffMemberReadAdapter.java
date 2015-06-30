package com.iservport.report.repository;

import java.io.Serializable;

import org.helianto.core.domain.Identity;
import org.helianto.task.domain.ReportFolder;
import org.helianto.task.domain.StaffMember;
import org.helianto.task.repository.AbstractReadAdapter;

/**
 * Adaptador para leitura de membros da equipe.
 *
 * @author mauriciofernandesdecastro
 */
public class StaffMemberReadAdapter extends AbstractReadAdapter
	implements Serializable
{

	private static final long serialVersionUID = 1L;
	
	private StaffMember adaptee;
	
	private Integer reportFolderId;

	private Integer identityId;

	private String firstName;

	private String lastName;

	private String displayName;
	
	private String userImageUrl;

	/**
	 * Construtor.
	 *
	 * @param id
	 * @param reportFolderId;
	 * @param identityId;
	 * @param firstName;
	 * @param lastName;
	 * @param displayName;
	 */
	public StaffMemberReadAdapter(
		int id
		, int reportFolderId
		, int identityId
		, String firstName
		, String lastName
		, String displayName
		, String userImageUrl
		) {
		super(id);
		this.reportFolderId = reportFolderId;
		this.identityId = identityId;
		this.firstName = firstName;
		this.lastName = lastName;
		this.displayName = displayName;
		this.userImageUrl = userImageUrl;
	}
	
	public StaffMemberReadAdapter() {

	}
	
	/**
	 * Adaptee contructor.
	 * 
	 * @param adaptee
	 */
	public StaffMemberReadAdapter(StaffMember adaptee) {
		this.adaptee = adaptee;
	}
	
	public StaffMember getAdaptee() {
		return adaptee;
	}
	
	public StaffMemberReadAdapter setAdaptee(StaffMember adaptee) {
		this.adaptee = adaptee;
		return this;
	}
	
	public StaffMemberReadAdapter build(ReportFolder reportFolder, Identity identity) {
		if (adaptee!=null) {
			return new StaffMemberReadAdapter(adaptee.getId(), reportFolder.getId(), 
					identity.getId(), identity.getIdentityFirstName() ,
					identity.getIdentityLastName(), identity.getDisplayName(), identity.getImageUrl());
		}
		throw new RuntimeException("Null adaptee will not be persisted.");
	}
	
	public StaffMember merge(){
		//TODO colocar sets?
		//adaptee.set
		return adaptee;
	}
	
	
	public Integer getReportFolderId() {
		return reportFolderId;
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
		if(displayName==null || displayName.isEmpty()){
			return firstName!=null && !firstName.isEmpty()?firstName:lastName;
		}
		return displayName;
	}
	
	public String getUserImageUrl() {
		return userImageUrl;
	}
	
	public void setUserImageUrl(String userImageUrl) {
		this.userImageUrl = userImageUrl;
	}

	@Override
	public int hashCode() {
		return 31 + getId();
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj) return true;
		if (obj == null) return false;
		if (getClass() != obj.getClass()) return false;
		StaffMemberReadAdapter other = (StaffMemberReadAdapter) obj;
		if (getId() != other.getId()) return false;
		return true;
	}

}

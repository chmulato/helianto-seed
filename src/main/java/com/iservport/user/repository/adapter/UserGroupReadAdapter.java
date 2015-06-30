package com.iservport.user.repository.adapter;

import java.io.Serializable;

import org.helianto.user.domain.UserGroup;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Adaptador para leitura de usuários.
 * 
 * @author mauriciofernandesdecastro
 */
public class UserGroupReadAdapter 
	implements Serializable
{
	
	private static final long serialVersionUID = 1L;
	
	private UserGroup adaptee;

	private int id;
	
	private String userKey;
	
	private String userName;
	
	private char userType = 'I';
	
	private int minimalEducationRequirement;
	
	private int minimalExperienceRequirement;
	
	private int countItems;
	
	private int countAlerts;
	
	private int countWarnings;
	
	private boolean checked = false;
	
	/**
	 * Constructor.
	 * 
	 * @param id
	 * @param userKey
	 * @param userName
	 * @param userType
	 */
	public UserGroupReadAdapter(int id, String userKey, String userName, char userType) {
		super();
		this.id = id;
		this.userKey = userKey;
		this.userName = userName;
		this.userType = userType;
	}

	/**
	 * Constructor.
	 * 
	 * @param id
	 * @param userKey
	 * @param userName
	 * @param minimalEducationRequirement
	 * @param minimalExperienceRequirement
	 */
	public UserGroupReadAdapter(int id, String userKey, String userName
			, int minimalEducationRequirement, int minimalExperienceRequirement
			, char userType) {
		this(id, userKey, userName, 'I');
		this.minimalEducationRequirement = minimalEducationRequirement;
		this.minimalExperienceRequirement = minimalExperienceRequirement;
	}
	
	/**
	 * Adaptee contructor.
	 * 
	 * @param adaptee
	 * 
	 */
	public UserGroupReadAdapter(UserGroup adaptee) {
		super();
		this.adaptee = adaptee;
	}

	public UserGroupReadAdapter build(){
		if (adaptee==null) {
			throw new RuntimeException("Adaptee canoot be null.");
		}
		//oque é?
		//setChecked(adaptee.is);
		setId(adaptee.getId());
		setMinimalEducationRequirement(adaptee.getMinimalEducationRequirement());
		setMinimalExperienceRequirement(adaptee.getMinimalExperienceRequirement());
		setUserKey(adaptee.getUserKey());
		setUserName(adaptee.getUserName());
		setUserType(adaptee.getUserType());
		return this;
	}
	
	public UserGroup merge(){
		adaptee.setMinimalEducationRequirement(getMinimalEducationRequirement());
		adaptee.setMinimalExperienceRequirement(getMinimalExperienceRequirement());
		adaptee.setUserKey(getUserKey());
		adaptee.setUserName(getUserName());
		adaptee.setUserType(getUserType());
		return adaptee; 
	}
	
	@JsonIgnore
	public UserGroup getAdaptee() {
		return adaptee;
	}
	
	public UserGroupReadAdapter setAdaptee(UserGroup adaptee) {
		this.adaptee = adaptee;
		return this;
	}
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}
	
	public String getUserKey() {
		if (userKey==null) {
			return "";
		}
		return userKey;
	}

	public void setUserKey(String userKey) {
		this.userKey = userKey;
	}
	
	public String getUserName() {
		if (userName==null) {
			return "";
		}
		return userName;
	}
	
	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	public char getUserType() {
		return userType;
	}
	
	public void setUserType(char userType) {
		this.userType = userType;
	}
	
	public int getMinimalEducationRequirement() {
		return minimalEducationRequirement;
	}
	
	public void setMinimalEducationRequirement(int minimalEducationRequirement) {
		this.minimalEducationRequirement = minimalEducationRequirement;
	}
	
	public int getMinimalExperienceRequirement() {
		return minimalExperienceRequirement;
	}
	
	public void setMinimalExperienceRequirement(int minimalExperienceRequirement) {
		this.minimalExperienceRequirement = minimalExperienceRequirement;
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
	
	public boolean isChecked() {
		return checked;
	}
	public void setChecked(boolean checked) {
		this.checked = checked;
	}
	
	public boolean isEditable() {
		return (getUserType()!='A' && getUserType()!='G');
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
		if (!(obj instanceof UserGroupReadAdapter)) {
			return false;
		}
		UserGroupReadAdapter other = (UserGroupReadAdapter) obj;
		if (id != other.id) {
			return false;
		}
		return true;
	}

}

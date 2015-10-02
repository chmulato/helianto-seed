package com.iservport.user.domain;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.UniqueConstraint;
import javax.persistence.Version;

import org.helianto.task.domain.ReportFolder;
import org.helianto.user.domain.User;

@javax.persistence.Entity
@Table(name="core_journal",
       uniqueConstraints={@UniqueConstraint(columnNames={"userId","issueDate"})})
public class UserJournal implements Serializable, Comparable<UserJournal>  {

	private static final long serialVersionUID = 1L;
	
	@Id @GeneratedValue(strategy=GenerationType.AUTO)
	private int id;

	@Version
	private Integer version;
	
	@ManyToOne
	@JoinColumn(name="userId")
	private User user;
	
	@Temporal(TemporalType.TIMESTAMP)
	private Date issueDate;
	
	@Enumerated(EnumType.STRING)
	@Column(length=14)
	private UserJournalType userJournalType;
	
	@Column(length=24)
	private String journalCode;
	
	@ManyToOne
	@JoinColumn(name="reportFolderId")
	private ReportFolder reportFolder;
	
	public UserJournal() {
		super();
		setIssueDate(new Date());
	}
	
	public UserJournal(User user, Date issueDate) {
		this();
		this.user = user;
		this.issueDate = issueDate;
	}

	public UserJournal(Integer version, User user, Date issueDate,
			UserJournalType userJournalType, String journalCode,
			ReportFolder reportFolder) {
		super();
		this.version = version;
		this.user = user;
		this.issueDate = issueDate;
		this.userJournalType = userJournalType;
		this.journalCode = journalCode;
		this.reportFolder = reportFolder;
	}

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}

	public Integer getVersion() {
		return version;
	}
	public void setVersion(Integer version) {
		this.version = version;
	}

	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}

	public Date getIssueDate() {
		return issueDate;
	}
	public void setIssueDate(Date issueDate) {
		this.issueDate = issueDate;
	}

	public UserJournalType getUserJournalType() {
		return userJournalType;
	}
	public void setUserJournalType(UserJournalType userJournalType) {
		this.userJournalType = userJournalType;
	}

	public String getJournalCode() {
		return journalCode;
	}
	public void setJournalCode(String journalCode) {
		this.journalCode = journalCode;
	}

	public ReportFolder getReportFolder() {
		return reportFolder;
	}
	public void setReportFolder(ReportFolder reportFolder) {
		this.reportFolder = reportFolder;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((issueDate == null) ? 0 : issueDate.hashCode());
		result = prime * result + ((user == null) ? 0 : user.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		UserJournal other = (UserJournal) obj;
		if (issueDate == null) {
			if (other.issueDate != null)
				return false;
		} else if (!issueDate.equals(other.issueDate))
			return false;
		if (user == null) {
			if (other.user != null)
				return false;
		} else if (!user.equals(other.user))
			return false;
		return true;
	}
	
	@Override
	public int compareTo(UserJournal o) {
	    if (getIssueDate() == null || o.getIssueDate() == null)
	      return 0;
	    return getIssueDate().compareTo(o.getIssueDate());
	}
}

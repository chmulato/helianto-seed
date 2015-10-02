package com.iservport.report.domain;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;
import javax.persistence.UniqueConstraint;
import javax.persistence.Version;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Dados de projetos.
 * 
 * @author mauriciofernandesdecastro
 */
@javax.persistence.Entity
@Table(name="task_data",
uniqueConstraints = {@UniqueConstraint(columnNames={"reportBaseLineId", "issueDate"})}
)
public class ReportData 
	implements Serializable
{

	private static final long serialVersionUID = 1L;
	
    @Id @GeneratedValue(strategy=GenerationType.AUTO)
    private int id;
    
    @Version
    private Integer version;
    
   
    @ManyToOne
    @JoinColumn(name="reportBaseLineId", nullable=true)
	private ReportBaseLine reportBaseLine;
    
    @Transient
	private Integer reportBaseLineId;
	
    @Temporal(TemporalType.TIMESTAMP)
    private Date issueDate;

    /**
     * Default Contructor.
     */
    public ReportData() {
		super();
	}
    
    /**
     * Key Constructor.
     * 
     * @param reportBaseLine
     * @param issueDate
     * 
     */
	public ReportData(ReportBaseLine reportBaseLine, Date issueDate) {
		this();
		this.reportBaseLine = reportBaseLine;
		this.issueDate = issueDate;
	}

	/**
	 * Fields constructor.
	 * 
	 * @param id
	 * @param version
	 * @param reportBaseLine
	 * @param issueDate
	 * 
	 */
	
	/**
	 * 
	 * Transiente para ReportBaseLineId
	 * @return
	 */
	public Integer getReportBaseLineId() {
		return reportBaseLineId;
	}
	
	public void setReportBaseLineId(Integer reportBaseLineId) {
		this.reportBaseLineId = reportBaseLineId;
	}
	
	
	
	public ReportData(int id, Integer version, ReportBaseLine reportBaseLine,
			Date issueDate) {
		this(reportBaseLine, issueDate);
		this.id = id;
		this.version = version;
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

	@JsonIgnore
	public ReportBaseLine getReportBaseLine() {
		return reportBaseLine;
	}
	public void setReportBaseLine(ReportBaseLine reportBaseLine) {
		this.reportBaseLine = reportBaseLine;
	}

	public Date getIssueDate() {
		return issueDate;
	}
	public void setIssueDate(Date issueDate) {
		this.issueDate = issueDate;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + id;
		result = prime * result
				+ ((issueDate == null) ? 0 : issueDate.hashCode());
		result = prime * result
				+ ((reportBaseLine == null) ? 0 : reportBaseLine.hashCode());
		result = prime * result + ((version == null) ? 0 : version.hashCode());
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
		ReportData other = (ReportData) obj;
		if (id != other.id)
			return false;
		if (issueDate == null) {
			if (other.issueDate != null)
				return false;
		} else if (!issueDate.equals(other.issueDate))
			return false;
		if (reportBaseLine == null) {
			if (other.reportBaseLine != null)
				return false;
		} else if (!reportBaseLine.equals(other.reportBaseLine))
			return false;
		if (version == null) {
			if (other.version != null)
				return false;
		} else if (!version.equals(other.version))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "ReportData [id=" + id + ", version=" + version
				+ ", reportBaseLine=" + reportBaseLine + ", issueDate="
				+ issueDate + "]";
	}
	
}

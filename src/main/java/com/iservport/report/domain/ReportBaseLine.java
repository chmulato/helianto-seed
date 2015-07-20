package com.iservport.report.domain;

import java.io.Serializable;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.persistence.UniqueConstraint;
import javax.persistence.Version;

import org.helianto.task.domain.ReportFolder;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Base line.
 * 
 * @author mauriciofernandesdecastro
 */
@javax.persistence.Entity
@Table(name="task_baseline",
uniqueConstraints = {@UniqueConstraint(columnNames={"reportFolderId", "sequence"})}
)
public class ReportBaseLine 
	implements Serializable
{

	private static final long serialVersionUID = 1L;
	
    @Id @GeneratedValue(strategy=GenerationType.AUTO)
    private int id;
    
    @Version
    private Integer version;
    
    @ManyToOne
    @JoinColumn(name="reportFolderId", nullable=true)
	private ReportFolder reportFolder;
	
    private Integer sequence;
    
    @Transient
    private Integer reportFolderId;

    /**
     * Default Constructor.
     */
    public ReportBaseLine() {
		super();
	}
    
    /**
     * Key Constructor.
     * 
     * @param reportFolder
     * @param sequence
     * 
     */
	public ReportBaseLine(ReportFolder reportFolder, Integer sequence) {
		super();
		this.reportFolder = reportFolder;
		this.sequence = sequence;
	}

	/**
	 * Fields Constructor.
	 * 
	 * @param id
	 * @param version
	 * @param reportFolder
	 * @param sequence
	 * 
	 */
	public ReportBaseLine(int id, Integer version, ReportFolder reportFolder,
			Integer sequence) {
		this();
		this.id = id;
		this.version = version;
		this.reportFolder = reportFolder;
		this.sequence = sequence;
	}

	public ReportBaseLine setReportBaseLine(ReportBaseLine baseLine) {
		this.reportFolder = baseLine.getReportFolder();
		this.sequence = baseLine.getSequence();
		return this;
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
	public ReportFolder getReportFolder() {
		return reportFolder;
	}
	public void setReportFolder(ReportFolder reportFolder) {
		this.reportFolder = reportFolder;
	}

	public Integer getSequence() {
		return sequence;
	}
	public void setSequence(Integer sequence) {
		this.sequence = sequence;
	}
	
	public Integer getReportFolderId() {
		return reportFolderId;
	}
	public void setReportFolderId(Integer reportFolderId) {
		this.reportFolderId = reportFolderId;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + id;
		result = prime * result
				+ ((reportFolder == null) ? 0 : reportFolder.hashCode());
		result = prime * result
				+ ((sequence == null) ? 0 : sequence.hashCode());
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
		ReportBaseLine other = (ReportBaseLine) obj;
		if (id != other.id)
			return false;
		if (reportFolder == null) {
			if (other.reportFolder != null)
				return false;
		} else if (!reportFolder.equals(other.reportFolder))
			return false;
		if (sequence == null) {
			if (other.sequence != null)
				return false;
		} else if (!sequence.equals(other.sequence))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "ReportBaseLine [id=" + id + ", version=" + version
				+ ", reportFolder=" + reportFolder + ", sequence=" + sequence
				+ "]";
	}
	
}

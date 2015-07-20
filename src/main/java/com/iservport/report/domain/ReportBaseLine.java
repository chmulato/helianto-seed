package com.iservport.report.domain;

import java.io.Serializable;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;
import javax.persistence.Version;

import org.helianto.task.domain.ReportFolder;

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

}

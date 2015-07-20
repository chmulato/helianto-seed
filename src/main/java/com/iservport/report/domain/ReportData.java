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
import javax.persistence.UniqueConstraint;
import javax.persistence.Version;

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
	
    @Temporal(TemporalType.TIMESTAMP)
    private Date issueDate;

}

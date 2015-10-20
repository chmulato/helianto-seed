package com.iservport.report.repository;

import org.helianto.task.repository.FolderReadAdapter;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.iservport.report.domain.Project;

/**
 * Adaptador para leitura de comentários.
 *
 * @author mauriciofernandesdecastro
 */
public class ProjectReadAdapter
	extends FolderReadAdapter
{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * 
	 */
//	private static final long serialVersionUID = 1L;

	private Project adaptee;

	private String benefits;
	
	private String assumptions;
	
	private String deliverables;
	
	private String constraints;
	
	private Integer[] tools;
	
	public ProjectReadAdapter() {
		
	}

	public ProjectReadAdapter(int id, int categoryId, String folderCode,
			String folderName, String folderDecorationUrl, String patternPrefix,
			String patternSuffix, int exporterId,
			String benefits, String assumptions,
			String deliverables, String constraints,String tools) {
			super(id, categoryId, folderCode, folderName, folderDecorationUrl,
				patternPrefix, patternSuffix,exporterId);
		// TODO Auto-generated constructor stub
		
		this.benefits = benefits;
		this.assumptions =  assumptions;
		this.deliverables = deliverables;
		this.constraints = constraints;
		this.tools =stringToArray(tools);
	}
	

	public ProjectReadAdapter build(){
		if (adaptee==null) {
			throw new RuntimeException("Null actionPlan cannot be persisted.");
		}
		setBenefits(adaptee.getBenefits());
		setAssumptions(adaptee.getAssumptions());
		setDeliverables(adaptee.getDeliverables());
		setConstraints(adaptee.getConstraints());
		// Criado um array de Inteiros, e convertido para String
		
		setTools(stringToArray(adaptee.getTools()));
		return this;
	}
	
	public Integer[] stringToArray(String toolss){
		if (toolss == null) {
			return new Integer[]{};
		}
		String[] toolsStr = toolss.split(",");
		Integer[] tools = new Integer[toolsStr.length];
		for (int i = 0; i < toolsStr.length; i++) {
			String tool = toolsStr[i];
			if (!tool.isEmpty()) {
				tools[i] = Integer.valueOf(toolsStr[i]);
			}
		}
		return	tools;
		
	}
	
	 public String arrayToString(Integer[] toolss) {
		 
			String tools ="";
			String comma ="";
			
			for (Integer i: toolss) {
				tools += comma+i;
				comma =",";
			}
			return tools;
		 
	}
	public Project Merge(){
		adaptee.setBenefits(getBenefits());
		adaptee.setAssumptions(getAssumptions());
		adaptee.setDeliverables(getDeliverables());
		adaptee.setConstraints(getConstraints());
		
	
		adaptee.setTools(arrayToString(getTools()));
		return adaptee;
	}
	
	 public ProjectReadAdapter(Project adaptee) {
		super();
		this.adaptee = adaptee;
	}
	 
	 
	
	@JsonIgnore
	public Project getAdaptee() {
		return adaptee;
	}

	public ProjectReadAdapter setAdaptee(Project adaptee) {
		this.adaptee = adaptee;
		return this;
	}
	
	@JsonProperty("benefits")
	public String getBenefits() {
		return new String(benefits);
	}

	
	public void setBenefits(String benefits) {
		this.benefits = benefits;
	}

	@JsonProperty("assumptions")
	public String getAssumptions() {
		return new String(assumptions);
	}


	public void setAssumptions(String assumptions) {
		this.assumptions = assumptions;
	}

	@JsonProperty("deliverables")
	public String getDeliverables() {
		return new String(deliverables);
	}


	public void setDeliverables(String deliverables) {
		this.deliverables = deliverables;
	}

	@JsonProperty("constraints")
	public String getConstraints() {
		return  new String(constraints);
	}


	public void setConstraints(String constraints) {
		this.constraints = constraints;
	}

	@JsonProperty("tools")
	public Integer[] getTools() {
		return tools;
	}

	public void setTools(Integer[] tools) {
		this.tools = tools;
	}

	
	
}


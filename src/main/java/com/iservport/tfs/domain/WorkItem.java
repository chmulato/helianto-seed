package com.iservport.tfs.domain;

import java.io.Serializable;

/**
 * Work item.
 * 
 * @author mauriciofernandesdecastro
 */
public class WorkItem 
	implements Serializable
{
	
	private static final long serialVersionUID = 1L;

	private Integer id;
	
	private String rev;
	
	private String fields;
	
	private String _links;
	
	private String relations;
	
	private String url;
	
	/**
	 * Constructor.
	 */
	public WorkItem() {
		super();
	}

	/**
	 * Full constructor.
	 * 
	 * @param id
	 * @param rev
	 * @param fields
	 * @param _links
	 * @param relations
	 * @param url
	 */
	public WorkItem(Integer id, String rev, String fields, String _links,
			String relations, String url) {
		this();
		this.id = id;
		this.rev = rev;
		this.fields = fields;
		this._links = _links;
		this.relations = relations;
		this.url = url;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}

	public String getRev() {
		return rev;
	}
	public void setRev(String rev) {
		this.rev = rev;
	}

	public String getFields() {
		return fields;
	}
	public void setFields(String fields) {
		this.fields = fields;
	}

	public String get_links() {
		return _links;
	}
	public void set_links(String _links) {
		this._links = _links;
	}

	public String getRelations() {
		return relations;
	}
	public void setRelations(String relations) {
		this.relations = relations;
	}

	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result + ((rev == null) ? 0 : rev.hashCode());
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
		WorkItem other = (WorkItem) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		if (rev == null) {
			if (other.rev != null)
				return false;
		} else if (!rev.equals(other.rev))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "WorkItem [id=" + id + ", rev=" + rev + ", fields=" + fields
				+ ", _links=" + _links + ", relations=" + relations + ", url="
				+ url + "]";
	}

}

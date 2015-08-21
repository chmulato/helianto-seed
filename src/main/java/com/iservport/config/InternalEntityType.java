package com.iservport.config;

import java.io.Serializable;

import org.helianto.core.internal.KeyNameAdapter;

/**
 * Enumeração interna para definir tipos
 * de entidade para este contexto de aplicação.
 * 
 * @author mauriciofernandesdecastro
 */
public enum InternalEntityType implements KeyNameAdapter {
	
	CUSTOMERS('C', "Clientes"),
	AGENTS('A', "Agentes");
	
	private char value;
	private String desc;
	
	/**
	 * Construtor.
	 * 
	 * @param value
	 */
	private InternalEntityType(char value, String desc) {
		this.value = value;
		this.desc = desc;
	}
	
	public Serializable getKey() {
		return this.value;
	}
	
	@Override
	public String getCode() {
		return value+"";
	}
	
	@Override
	public String getName() {
		return desc;
	}
	
}
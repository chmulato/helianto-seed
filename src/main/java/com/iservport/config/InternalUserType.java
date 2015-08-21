package com.iservport.config;

import java.io.Serializable;

import org.helianto.core.internal.KeyNameAdapter;

/**
 * Internal user types.
 * 
 * @author mauriciofernandesdecastro
 */
public enum InternalUserType implements KeyNameAdapter {
	
	USER('A', "Usuários")
	, GUEST('X', "Convidados")
	, ADMIN('G', "Administradores");
	
	private char value;
	private String desc;
	
	/**
	 * Constructor.
	 * 
	 * @param value
	 */
	private InternalUserType(char value, String desc) {
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
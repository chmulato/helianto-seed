package com.iservport.primesw.client;

import java.util.Date;

import org.springframework.ws.client.core.support.WebServiceGatewaySupport;

/**
 * Cliente para o serviço FolhaService.
 * 
 * @author mauriciofernandesdecastro
 *
 */
public class PrimeSwClient extends WebServiceGatewaySupport {
	
	public Integer readWorkingHours(int userId, Date day) {
		
		// preciso extrair cnpj do user (via entity)
		// preciso trocar userId pelo PIS do usuário
		// criar um filtro para ler o dia - dataHoraInicio até dataHoraTermino
		
		// entity - ler tabela publicEntityKey via keyValue onde keyTypeId corresponde ao CNPJ
		// user - ler tabela userKey via keyValue onde keyTypeId corresponde ao PIS

		return 0;
	}

}

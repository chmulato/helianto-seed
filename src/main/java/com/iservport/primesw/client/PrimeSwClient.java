package com.iservport.primesw.client;

import java.util.Date;
import java.util.GregorianCalendar;

import javax.inject.Inject;
import javax.xml.datatype.DatatypeConfigurationException;
import javax.xml.datatype.DatatypeFactory;
import javax.xml.datatype.XMLGregorianCalendar;

import org.helianto.core.domain.Entity;
import org.helianto.core.domain.KeyType;
import org.helianto.core.domain.Operator;
import org.helianto.core.domain.PublicEntityKey;
import org.helianto.core.repository.EntityRepository;
import org.helianto.core.repository.KeyTypeRepository;
import org.helianto.core.repository.OperatorRepository;
import org.helianto.core.repository.PublicEntityKeyRepository;
import org.helianto.core.repository.PublicEntityRepository;
import org.helianto.user.domain.User;
import org.helianto.user.domain.UserKey;
import org.helianto.user.repository.UserRepository;
import org.joda.time.DateTime;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ws.client.core.support.WebServiceGatewaySupport;

import com.iservport.primesw.repository.UserKeyRepository;
import com.iservport.primesw.wsdl.FolhaFilterIn;
import com.iservport.primesw.wsdl.FolhaPonto;
import com.iservport.primesw.wsdl.FolhaPontoResponse;
import com.iservport.primesw.wsdl.PointItem;

/**
 * Cliente para o serviço FolhaService.
 * 
 * @author mauriciofernandesdecastro
 *
 */
public class PrimeSwClient extends WebServiceGatewaySupport {
	
	@Inject
	private KeyTypeRepository keyTypeRepository;
	
	@Inject 
	private OperatorRepository operatorRepository;

	@Inject 
	private EntityRepository entityRepository;

	@Inject 
	private PublicEntityKeyRepository publicEntityKeyRepository;
	
	@Inject 
	private PublicEntityRepository publicEntityRepository ;
	
	@Inject
	private UserRepository userRepository;
	
	@Inject
	private UserKeyRepository userKeyRepository;
	
	public Integer readWorkingHours(int userId, Date day) throws DatatypeConfigurationException {
		
		User user = userRepository.findAdapter(userId);
		Entity entity = userRepository.findEntityByUserId(userId);
		Operator context = entityRepository.findOperatorByEntity(entity.getId());
		
		// preciso extrair cnpj do user (via entity)
		// preciso trocar userId pelo PIS do usuário
		// criar um filtro para ler o dia - dataHoraInicio até dataHoraTermino
		
		// entity - ler tabela publicEntityKey via keyValue onde keyTypeId corresponde ao CNPJ
		// user - ler tabela userKey via keyValue onde keyTypeId corresponde ao PIS
		
		KeyType keyTypeCNPJ = keyTypeRepository.findByOperatorAndKeyCode(context, "CNPJ");
		
		KeyType keyTypePIS = keyTypeRepository.findByOperatorAndKeyCode(context, "PIS");
		
		PublicEntityKey cnpj =  
				publicEntityKeyRepository
					.findByPublicEntityAndKeyType(publicEntityRepository.findByEntity(entity), keyTypeCNPJ);
		
		UserKey pis = userKeyRepository.findByUserGroup_IdAndKeyType(userId, keyTypePIS);
		
		GregorianCalendar c = new GregorianCalendar();
		c.setTime(new DateTime(day).withHourOfDay(0).withMinuteOfHour(0).withSecondOfMinute(0).toDate());
		XMLGregorianCalendar date = DatatypeFactory.newInstance().newXMLGregorianCalendar(c);
		c.setTime(new DateTime(day).withHourOfDay(23).withMinuteOfHour(59).withSecondOfMinute(59).toDate());
		XMLGregorianCalendar date2 = DatatypeFactory.newInstance().newXMLGregorianCalendar(c);
		
		FolhaFilterIn filterIn = new FolhaFilterIn();
		filterIn.setCnpj(cnpj.getKeyValue());
		filterIn.setPis(pis.getKeyValue());
		filterIn.setDataHoraInicio(date);
		filterIn.setDataHoraTermino(date2);
		//TODO e  o CPF?
		//filterIn.setCpf(value); 
		
		FolhaPonto folhaPonto = new FolhaPonto();
		folhaPonto.setFilter(filterIn);
		FolhaPontoResponse response = (FolhaPontoResponse) getWebServiceTemplate().marshalSendAndReceive(folhaPonto);
		
		Integer totalHT = 0;
		
		for ( PointItem item: response.getReturn().getItens()) {
			totalHT=+item.getHt();
		}
		return totalHT;
	}

}

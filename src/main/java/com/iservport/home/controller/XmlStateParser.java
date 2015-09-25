package com.iservport.home.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.xml.stream.XMLInputFactory;
import javax.xml.stream.XMLStreamConstants;
import javax.xml.stream.XMLStreamException;
import javax.xml.stream.XMLStreamReader;

import org.helianto.core.domain.Country;
import org.helianto.core.domain.Operator;
import org.helianto.core.domain.State;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Service;

/**
 * XML state parser.
 * 
 * @author mauriciofernandesdecastro
 */
@Service
public class XmlStateParser implements StateParser {

	private static final Logger logger = LoggerFactory.getLogger(XmlCountryParser.class);
	
	/**
	 * Analisa estados da federação de um arquivo xml.
	 * 
	 * @param context
	 * @param rs
	 */
	public List<State> parseStates(Operator context, Country country, Resource rs) {
		List<State> stateList = new ArrayList<>();
		logger.debug("About to read state list from {}.", rs);
		try {
			XMLInputFactory factory = XMLInputFactory.newInstance();
			XMLStreamReader parser = factory.createXMLStreamReader(rs.getInputStream());
			while (true) {
			    int event = parser.next();
			    if (event == XMLStreamConstants.END_DOCUMENT) {
			       parser.close();
			       break;
			    }
			    if (event == XMLStreamConstants.START_ELEMENT && parser.getLocalName().equals("state")) {
			    	String stateCode = parser.getAttributeValue("", "stateCode");
			    	State state = new State(context, stateCode, parser.getAttributeValue("", "stateName"));
			    	state.setCountry(country);
			    	stateList.add(state);
			    	logger.debug("Added {} to state list.", state);
			    }
			}
		} catch (XMLStreamException e) {
			throw new IllegalArgumentException("Unable to parse state data file", e);
		} catch (IOException e) {
			throw new IllegalArgumentException("Unable to read from state data file", e);
		}
		return stateList;
	}
	
}

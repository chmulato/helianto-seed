//
// Este arquivo foi gerado pela Arquitetura JavaTM para Implementação de Referência (JAXB) de Bind XML, v2.2.11 
// Consulte <a href="http://java.sun.com/xml/jaxb">http://java.sun.com/xml/jaxb</a> 
// Todas as modificações neste arquivo serão perdidas após a recompilação do esquema de origem. 
// Gerado em: 2015.09.08 às 03:27:44 PM BRT 
//


package com.iservport.primesw.wsdl;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java de folhaPonto complex type.
 * 
 * <p>O seguinte fragmento do esquema especifica o conteúdo esperado contido dentro desta classe.
 * 
 * <pre>
 * &lt;complexType name="folhaPonto"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="filter" type="{http://folha.primews.com.br/}folhaFilterIn" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "folhaPonto", propOrder = {
    "filter"
})
@XmlRootElement
public class FolhaPonto {

    protected FolhaFilterIn filter;

    /**
     * Obtém o valor da propriedade filter.
     * 
     * @return
     *     possible object is
     *     {@link FolhaFilterIn }
     *     
     */
    public FolhaFilterIn getFilter() {
        return filter;
    }

    /**
     * Define o valor da propriedade filter.
     * 
     * @param value
     *     allowed object is
     *     {@link FolhaFilterIn }
     *     
     */
    public void setFilter(FolhaFilterIn value) {
        this.filter = value;
    }

}

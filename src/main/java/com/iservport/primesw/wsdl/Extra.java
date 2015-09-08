//
// Este arquivo foi gerado pela Arquitetura JavaTM para Implementação de Referência (JAXB) de Bind XML, v2.2.11 
// Consulte <a href="http://java.sun.com/xml/jaxb">http://java.sun.com/xml/jaxb</a> 
// Todas as modificações neste arquivo serão perdidas após a recompilação do esquema de origem. 
// Gerado em: 2015.09.08 às 03:27:44 PM BRT 
//


package com.iservport.primesw.wsdl;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java de extra complex type.
 * 
 * <p>O seguinte fragmento do esquema especifica o conteúdo esperado contido dentro desta classe.
 * 
 * <pre>
 * &lt;complexType name="extra"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="banco" type="{http://www.w3.org/2001/XMLSchema}boolean"/&gt;
 *         &lt;element name="minutes" type="{http://www.w3.org/2001/XMLSchema}int"/&gt;
 *         &lt;element name="noturno" type="{http://www.w3.org/2001/XMLSchema}boolean"/&gt;
 *         &lt;element name="percentual" type="{http://www.w3.org/2001/XMLSchema}double"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "extra", propOrder = {
    "banco",
    "minutes",
    "noturno",
    "percentual"
})
public class Extra {

    protected boolean banco;
    protected int minutes;
    protected boolean noturno;
    protected double percentual;

    /**
     * Obtém o valor da propriedade banco.
     * 
     */
    public boolean isBanco() {
        return banco;
    }

    /**
     * Define o valor da propriedade banco.
     * 
     */
    public void setBanco(boolean value) {
        this.banco = value;
    }

    /**
     * Obtém o valor da propriedade minutes.
     * 
     */
    public int getMinutes() {
        return minutes;
    }

    /**
     * Define o valor da propriedade minutes.
     * 
     */
    public void setMinutes(int value) {
        this.minutes = value;
    }

    /**
     * Obtém o valor da propriedade noturno.
     * 
     */
    public boolean isNoturno() {
        return noturno;
    }

    /**
     * Define o valor da propriedade noturno.
     * 
     */
    public void setNoturno(boolean value) {
        this.noturno = value;
    }

    /**
     * Obtém o valor da propriedade percentual.
     * 
     */
    public double getPercentual() {
        return percentual;
    }

    /**
     * Define o valor da propriedade percentual.
     * 
     */
    public void setPercentual(double value) {
        this.percentual = value;
    }

}

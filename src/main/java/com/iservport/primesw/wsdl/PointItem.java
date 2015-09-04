//
// Este arquivo foi gerado pela Arquitetura JavaTM para Implementação de Referência (JAXB) de Bind XML, v2.2.11 
// Consulte <a href="http://java.sun.com/xml/jaxb">http://java.sun.com/xml/jaxb</a> 
// Todas as modificações neste arquivo serão perdidas após a recompilação do esquema de origem. 
// Gerado em: 2015.09.04 às 11:33:12 AM BRT 
//


package com.iservport.primesw.wsdl;

import java.util.ArrayList;
import java.util.List;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlSchemaType;
import javax.xml.bind.annotation.XmlType;
import javax.xml.datatype.XMLGregorianCalendar;


/**
 * <p>Classe Java de pointItem complex type.
 * 
 * <p>O seguinte fragmento do esquema especifica o conteúdo esperado contido dentro desta classe.
 * 
 * <pre>
 * &lt;complexType name="pointItem"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="data" type="{http://www.w3.org/2001/XMLSchema}dateTime" minOccurs="0"/&gt;
 *         &lt;element name="intervalos" type="{http://folha.primews.com.br/}interval" maxOccurs="unbounded" minOccurs="0"/&gt;
 *         &lt;element name="chp" type="{http://www.w3.org/2001/XMLSchema}int"/&gt;
 *         &lt;element name="ht" type="{http://www.w3.org/2001/XMLSchema}int"/&gt;
 *         &lt;element name="htn" type="{http://www.w3.org/2001/XMLSchema}int"/&gt;
 *         &lt;element name="hnt" type="{http://www.w3.org/2001/XMLSchema}int"/&gt;
 *         &lt;element name="hi" type="{http://www.w3.org/2001/XMLSchema}int"/&gt;
 *         &lt;element name="faltas" type="{http://www.w3.org/2001/XMLSchema}int"/&gt;
 *         &lt;element name="extras" type="{http://folha.primews.com.br/}extra" maxOccurs="unbounded" minOccurs="0"/&gt;
 *         &lt;element name="dsr" type="{http://folha.primews.com.br/}dsr" minOccurs="0"/&gt;
 *         &lt;element name="banco" type="{http://www.w3.org/2001/XMLSchema}int"/&gt;
 *         &lt;element name="bancoAuto" type="{http://www.w3.org/2001/XMLSchema}boolean"/&gt;
 *         &lt;element name="justParcial" type="{http://folha.primews.com.br/}justParcial" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "pointItem", propOrder = {
    "data",
    "intervalos",
    "chp",
    "ht",
    "htn",
    "hnt",
    "hi",
    "faltas",
    "extras",
    "dsr",
    "banco",
    "bancoAuto",
    "justParcial"
})
public class PointItem {

    @XmlSchemaType(name = "dateTime")
    protected XMLGregorianCalendar data;
    @XmlElement(nillable = true)
    protected List<Interval> intervalos;
    protected int chp;
    protected int ht;
    protected int htn;
    protected int hnt;
    protected int hi;
    protected int faltas;
    @XmlElement(nillable = true)
    protected List<Extra> extras;
    protected Dsr dsr;
    protected int banco;
    protected boolean bancoAuto;
    protected JustParcial justParcial;

    /**
     * Obtém o valor da propriedade data.
     * 
     * @return
     *     possible object is
     *     {@link XMLGregorianCalendar }
     *     
     */
    public XMLGregorianCalendar getData() {
        return data;
    }

    /**
     * Define o valor da propriedade data.
     * 
     * @param value
     *     allowed object is
     *     {@link XMLGregorianCalendar }
     *     
     */
    public void setData(XMLGregorianCalendar value) {
        this.data = value;
    }

    /**
     * Gets the value of the intervalos property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the intervalos property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getIntervalos().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link Interval }
     * 
     * 
     */
    public List<Interval> getIntervalos() {
        if (intervalos == null) {
            intervalos = new ArrayList<Interval>();
        }
        return this.intervalos;
    }

    /**
     * Obtém o valor da propriedade chp.
     * 
     */
    public int getChp() {
        return chp;
    }

    /**
     * Define o valor da propriedade chp.
     * 
     */
    public void setChp(int value) {
        this.chp = value;
    }

    /**
     * Obtém o valor da propriedade ht.
     * 
     */
    public int getHt() {
        return ht;
    }

    /**
     * Define o valor da propriedade ht.
     * 
     */
    public void setHt(int value) {
        this.ht = value;
    }

    /**
     * Obtém o valor da propriedade htn.
     * 
     */
    public int getHtn() {
        return htn;
    }

    /**
     * Define o valor da propriedade htn.
     * 
     */
    public void setHtn(int value) {
        this.htn = value;
    }

    /**
     * Obtém o valor da propriedade hnt.
     * 
     */
    public int getHnt() {
        return hnt;
    }

    /**
     * Define o valor da propriedade hnt.
     * 
     */
    public void setHnt(int value) {
        this.hnt = value;
    }

    /**
     * Obtém o valor da propriedade hi.
     * 
     */
    public int getHi() {
        return hi;
    }

    /**
     * Define o valor da propriedade hi.
     * 
     */
    public void setHi(int value) {
        this.hi = value;
    }

    /**
     * Obtém o valor da propriedade faltas.
     * 
     */
    public int getFaltas() {
        return faltas;
    }

    /**
     * Define o valor da propriedade faltas.
     * 
     */
    public void setFaltas(int value) {
        this.faltas = value;
    }

    /**
     * Gets the value of the extras property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the extras property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getExtras().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link Extra }
     * 
     * 
     */
    public List<Extra> getExtras() {
        if (extras == null) {
            extras = new ArrayList<Extra>();
        }
        return this.extras;
    }

    /**
     * Obtém o valor da propriedade dsr.
     * 
     * @return
     *     possible object is
     *     {@link Dsr }
     *     
     */
    public Dsr getDsr() {
        return dsr;
    }

    /**
     * Define o valor da propriedade dsr.
     * 
     * @param value
     *     allowed object is
     *     {@link Dsr }
     *     
     */
    public void setDsr(Dsr value) {
        this.dsr = value;
    }

    /**
     * Obtém o valor da propriedade banco.
     * 
     */
    public int getBanco() {
        return banco;
    }

    /**
     * Define o valor da propriedade banco.
     * 
     */
    public void setBanco(int value) {
        this.banco = value;
    }

    /**
     * Obtém o valor da propriedade bancoAuto.
     * 
     */
    public boolean isBancoAuto() {
        return bancoAuto;
    }

    /**
     * Define o valor da propriedade bancoAuto.
     * 
     */
    public void setBancoAuto(boolean value) {
        this.bancoAuto = value;
    }

    /**
     * Obtém o valor da propriedade justParcial.
     * 
     * @return
     *     possible object is
     *     {@link JustParcial }
     *     
     */
    public JustParcial getJustParcial() {
        return justParcial;
    }

    /**
     * Define o valor da propriedade justParcial.
     * 
     * @param value
     *     allowed object is
     *     {@link JustParcial }
     *     
     */
    public void setJustParcial(JustParcial value) {
        this.justParcial = value;
    }

}

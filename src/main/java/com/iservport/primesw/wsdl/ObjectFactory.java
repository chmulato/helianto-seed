//
// Este arquivo foi gerado pela Arquitetura JavaTM para Implementação de Referência (JAXB) de Bind XML, v2.2.11 
// Consulte <a href="http://java.sun.com/xml/jaxb">http://java.sun.com/xml/jaxb</a> 
// Todas as modificações neste arquivo serão perdidas após a recompilação do esquema de origem. 
// Gerado em: 2015.09.08 às 03:27:44 PM BRT 
//


package com.iservport.primesw.wsdl;

import javax.xml.bind.JAXBElement;
import javax.xml.bind.annotation.XmlElementDecl;
import javax.xml.bind.annotation.XmlRegistry;
import javax.xml.namespace.QName;


/**
 * This object contains factory methods for each 
 * Java content interface and Java element interface 
 * generated in the com.iservport.primesw.wsdl package. 
 * <p>An ObjectFactory allows you to programatically 
 * construct new instances of the Java representation 
 * for XML content. The Java representation of XML 
 * content can consist of schema derived interfaces 
 * and classes representing the binding of schema 
 * type definitions, element declarations and model 
 * groups.  Factory methods for each of these are 
 * provided in this class.
 * 
 */
@XmlRegistry
public class ObjectFactory {

    private final static QName _Folha_QNAME = new QName("http://folha.primews.com.br/", "folha");
    private final static QName _FolhaPonto_QNAME = new QName("http://folha.primews.com.br/", "folhaPonto");
    private final static QName _FolhaPontoResponse_QNAME = new QName("http://folha.primews.com.br/", "folhaPontoResponse");

    /**
     * Create a new ObjectFactory that can be used to create new instances of schema derived classes for package: com.iservport.primesw.wsdl
     * 
     */
    public ObjectFactory() {
    }

    /**
     * Create an instance of {@link PointMirror }
     * 
     */
    public PointMirror createPointMirror() {
        return new PointMirror();
    }

    /**
     * Create an instance of {@link FolhaPonto }
     * 
     */
    public FolhaPonto createFolhaPonto() {
        return new FolhaPonto();
    }

    /**
     * Create an instance of {@link FolhaPontoResponse }
     * 
     */
    public FolhaPontoResponse createFolhaPontoResponse() {
        return new FolhaPontoResponse();
    }

    /**
     * Create an instance of {@link FolhaFilterIn }
     * 
     */
    public FolhaFilterIn createFolhaFilterIn() {
        return new FolhaFilterIn();
    }

    /**
     * Create an instance of {@link PointItem }
     * 
     */
    public PointItem createPointItem() {
        return new PointItem();
    }

    /**
     * Create an instance of {@link Interval }
     * 
     */
    public Interval createInterval() {
        return new Interval();
    }

    /**
     * Create an instance of {@link Extra }
     * 
     */
    public Extra createExtra() {
        return new Extra();
    }

    /**
     * Create an instance of {@link Dsr }
     * 
     */
    public Dsr createDsr() {
        return new Dsr();
    }

    /**
     * Create an instance of {@link JustParcial }
     * 
     */
    public JustParcial createJustParcial() {
        return new JustParcial();
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link PointMirror }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://folha.primews.com.br/", name = "folha")
    public JAXBElement<PointMirror> createFolha(PointMirror value) {
        return new JAXBElement<PointMirror>(_Folha_QNAME, PointMirror.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link FolhaPonto }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://folha.primews.com.br/", name = "folhaPonto")
    public JAXBElement<FolhaPonto> createFolhaPonto(FolhaPonto value) {
        return new JAXBElement<FolhaPonto>(_FolhaPonto_QNAME, FolhaPonto.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link FolhaPontoResponse }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://folha.primews.com.br/", name = "folhaPontoResponse")
    public JAXBElement<FolhaPontoResponse> createFolhaPontoResponse(FolhaPontoResponse value) {
        return new JAXBElement<FolhaPontoResponse>(_FolhaPontoResponse_QNAME, FolhaPontoResponse.class, null, value);
    }

}

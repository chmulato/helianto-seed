package com.iservport.primesw.service;

import org.joda.time.DateTime;
import org.joda.time.Interval;
import org.joda.time.Period;
import org.joda.time.format.PeriodFormatter;
import org.joda.time.format.PeriodFormatterBuilder;

public class TimeJournalService {
	
	public TimeJournalService() {
		super();
	}

	public static void main(String [] args) {
		DateTime dataFinal  = new DateTime();
		DateTime dataInicio = new DateTime(2011, 1, 1, 0, 0);
		Interval intervalo  = new Interval(dataInicio, dataFinal);
		System.out.println("Intervalo: " + intervalo);		                                        
		Period period = intervalo.toPeriod();
		System.out.println("Período: " + period);		                                        
		System.out.println("Anos do período: "  + period.getYears());
		System.out.println("Meses do período: " + period.getMonths());
		System.out.println("Dias do período: "  + period.getDays());
		System.out.println("Horas do período: " + period.getHours());
		System.out.println("Minutos do período: " + period.getMinutes());
		System.out.println("Segundos do período: " + period.getSeconds());
		PeriodFormatter formatter=new PeriodFormatterBuilder().appendYears().appendSuffix(" ano "," anos ")
															  .appendMonths().appendSuffix(" mês "," meses ")
															  .appendDays().appendSuffix(" dia "," dias ")
															  .appendHours().appendSuffix(" hora "," horas ")
															  .appendMinutes().appendSuffix(" minuto "," minutos ")
															  .appendSeconds().appendSuffix(" segundo "," segundos ")
															  .printZeroNever().toFormatter();
		System.out.println("Período total seguido: " + formatter.print(period));
}
	
}

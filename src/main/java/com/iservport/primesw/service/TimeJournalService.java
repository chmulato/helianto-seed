package com.iservport.primesw.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.helianto.task.domain.ReportFolder;
import org.helianto.user.domain.User;
import org.joda.time.DateTime;
import org.joda.time.Interval;
import org.joda.time.Period;
import org.joda.time.format.PeriodFormatter;
import org.joda.time.format.PeriodFormatterBuilder;

import com.iservport.user.domain.UserJournal;
import com.iservport.user.domain.UserJournalType;

public class TimeJournalService {
	
	private List<UserJournal> listDatabase;
	
	public TimeJournalService() {
		super();
		 this.getListData();
	}

	// recupera o id da tabela UserJournal
	private int getUserJournalId() {
		int lastId = 0;
		if ((listDatabase != null) && (listDatabase.size() > 0)) {
			for (UserJournal userJournal : listDatabase) {
				if (userJournal.getId() > 0) {
					int userJornalId = userJournal.getId();
					if (userJornalId > lastId) {
						lastId = userJornalId;
					}
				}
			}
		}
		return (lastId + 1);
	}
	
	private boolean saveUserJournal(UserJournal userJournal) {
		boolean saveOK = false;
		if ((userJournal != null) && (userJournal.getUser() != null) && (userJournal.getUserJournalType() != null)) {
			if ((listDatabase != null) && (listDatabase.size() > 0)) {
				listDatabase.add(userJournal);
				saveOK = true;
			}
		}
		return saveOK;
	}
	
	
	// recupera o último checkIn do usuario 
	private UserJournal getLastCheckInByUser(User user) {
		UserJournal userJournalResult = null;
		if ((listDatabase != null) && (listDatabase.size() > 0)) {
			for (UserJournal userJournalList : listDatabase) {
				if (userJournalList.getUser() != null) {					
					//TODO
					// buscar o mais recente checkIn do usuário passado pelo prâmetro					
				}
			}
		}			
		return userJournalResult;
	}
	
	
	// carrega lista de dados do UserJournal
	private void getListData() {
		// start of false data
		DateTime dateTime_User01_checkIn = new DateTime(2015, 9, 17, 9, 46);		
		DateTime dateTime_User01_checkOut = new DateTime(2015, 9, 17, 11, 59);		
		User user01 = new User();
		user01.setId(1000);
		user01.setUserName("teste@iserverport.com.br");
		ReportFolder reportFolder01 = new ReportFolder(user01);
		reportFolder01.setId(500);
		
		DateTime dateTime_User02_checkIn = new DateTime(2015, 9, 17, 9, 50);	
		DateTime dateTime_User02_checkOut = new DateTime(2015, 9, 17, 12, 05);	
		User user02 = new User();
		user02.setId(1000);
		user02.setUserName("teste01@iserverport.com.br");
		ReportFolder reportFolder02 = new ReportFolder(user02);
		reportFolder02.setId(1000);
		
		UserJournal userJournal01_User01 = new UserJournal();
		userJournal01_User01.setId(1);
		userJournal01_User01.setUser(user01);
		userJournal01_User01.setIssueDate(dateTime_User01_checkIn.toDate());
		userJournal01_User01.setJournalCode(null);
		userJournal01_User01.setUserJournalType(UserJournalType.USER_CHECK_IN);
		userJournal01_User01.setReportFolder(reportFolder01);

		UserJournal userJournal02_User01 = new UserJournal();
		userJournal02_User01.setId(2);
		userJournal02_User01.setUser(user01);
		userJournal02_User01.setIssueDate(dateTime_User01_checkOut.toDate());
		userJournal02_User01.setJournalCode(null);
		userJournal02_User01.setUserJournalType(UserJournalType.USER_CHECK_OUT);
		userJournal02_User01.setReportFolder(reportFolder01);

		UserJournal userJournal01_User02 = new UserJournal();
		userJournal01_User02.setId(1);
		userJournal01_User02.setUser(user02);
		userJournal01_User02.setIssueDate(dateTime_User02_checkIn.toDate());
		userJournal01_User02.setJournalCode(null);
		userJournal01_User02.setUserJournalType(UserJournalType.USER_CHECK_IN);
		userJournal01_User02.setReportFolder(reportFolder01);

		UserJournal userJournal02_User02 = new UserJournal();
		userJournal02_User02.setId(2);
		userJournal02_User02.setUser(user02);
		userJournal02_User02.setIssueDate(dateTime_User02_checkOut.toDate());
		userJournal02_User02.setJournalCode(null);
		userJournal02_User02.setUserJournalType(UserJournalType.USER_CHECK_OUT);
		userJournal02_User02.setReportFolder(reportFolder01);
		
		listDatabase = new ArrayList<UserJournal>();
		listDatabase.add(userJournal01_User01);
		listDatabase.add(userJournal02_User01);
		listDatabase.add(userJournal01_User02);
		listDatabase.add(userJournal02_User02);	
		// end of false data
	}
	
	private List<UserJournal> findUserJournalList(User paramUser) {
		List<UserJournal> listResult = null;
		boolean blnResult = true;
		if ((listDatabase != null) && (listDatabase.size() > 0)) {
			for(UserJournal userJournal : listDatabase) {
				if ((userJournal.getUser() != null) && (!userJournal.getUser().equals(""))) {
				    User userFromList = (User) userJournal.getUser();				    
				    if (userFromList.getUserName().equals(paramUser.getUserName())) {
				    	if (blnResult) {
				    		listResult = new ArrayList<UserJournal>();
				    		blnResult = false;
				    	}
				    	listResult.add(userJournal);
				    }
				}
			}
		}
		return listResult;
	}
	
	private boolean isThereCheckIn(User user) {
		boolean result = false;
		return result;
	}
	
	
	
	public void checkIn(User user, UserJournalType enumUserJornalType, ReportFolder reportFolder) throws Exception {	
		// verifica se ja existe um
		if (isThereCheckIn(user)) {
			UserJournal userJournal = new UserJournal();
			userJournal.setId(getUserJournalId());
			userJournal.setUser(user);
			userJournal.setIssueDate(new Date());
			userJournal.setUserJournalType(enumUserJornalType);
			userJournal.setReportFolder(reportFolder);
			if (!saveUserJournal(userJournal)) {
				throw new Exception("Falha ao salvar checkIn!");
			}
		}
	}
	
	public void checkOut(User user, UserJournalType enumUserJornalType, ReportFolder reportFolder) throws Exception {
		
	}
	
	public void workLoad(User user) {
		List<UserJournal> list = findUserJournalList(user);
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

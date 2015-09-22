package com.iservport.user.repository;

import java.io.Serializable;
import java.util.Collection;
import java.util.Date;

import org.helianto.core.internal.SimpleCounter;
import org.helianto.user.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.iservport.user.domain.UserJournal;

/**
 * User journal repository.
 * 
 * @author mauriciofernandesdecastro
 */
public interface UserJournalRepository extends JpaRepository<UserJournal, Serializable> {
	
	/**
	 * Find by natural key.
	 */
	UserJournal findByUserAndIssueDate(User user, Date issueDate);
	
	/**
	 * Last user journal project check-in.
	 */
	@Query("select new "
			+ "org.helianto.core.internal.SimpleCounter("
			+ "  userJournal_.reportFolder.id"
			+ ", count(userJournal_.reportFolder.id)"
			+ ", max(userJournal_.issueDate)"
			+ ") "
			+ "from UserJournal userJournal_ "
			+ "where userJournal_.reportFolder.id in ?1 "
			+ "and userJournal_.user.id = ?2 "
			+ "and userJournal_.userJournalType = 'PRJ_CHECK_IN' "
			+ "group by userJournal_.reportFolder.id "
			+ "order by userJournal_.issueDate DESC ")
	SimpleCounter findLastByProjectCheckIn(Collection<Integer> projectIds, int userId);

}

package com.iservport.user.repository;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

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
	 * 
	 * @param userId
	 */
	@Query("select new "
			+ "org.helianto.core.internal.SimpleCounter("
			+ "  project_.id"
			+ ", count(project_.id)"
			+ ", max(userJournal_.issueDate)"
			+ ") "
			+ "from Project project_ "
			+ "join project_.userJournals userJournal_ "
			+ "where userJournal_.user.id = ?1 "
			+ "and project_.resolution = 'DOING' "
			+ "and userJournal_.userJournalType = 'PRJ_CHECK_IN' "
			+ "group by project_.id "
			+ "order by userJournal_.issueDate DESC ")
	List<SimpleCounter> findByProjectCheckIn(int userId);

}

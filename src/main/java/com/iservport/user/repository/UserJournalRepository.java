package com.iservport.user.repository;

import java.io.Serializable;
import java.util.Date;

import org.helianto.user.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;

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

}

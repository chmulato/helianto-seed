package com.iservport.report.repository;

import java.io.Serializable;

import org.helianto.task.domain.StaffMember;
import org.springframework.data.jpa.repository.JpaRepository;

public interface StaffMemberTempRepository 
extends JpaRepository<StaffMember, Serializable>
{

	
}

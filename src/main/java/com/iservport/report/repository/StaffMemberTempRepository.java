package com.iservport.report.repository;

import java.io.Serializable;
import java.util.List;

import org.helianto.task.domain.StaffMember;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface StaffMemberTempRepository 
extends JpaRepository<StaffMember, Serializable>
{

	
}

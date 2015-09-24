package com.iservport.report.service;

import java.util.List;

import javax.inject.Inject;

import org.helianto.security.internal.UserAuthentication;
import org.helianto.task.domain.StaffMember;
import org.helianto.task.repository.StaffMemberRepository;
import org.helianto.user.domain.User;
import org.helianto.user.repository.UserRepository;
import org.helianto.user.service.UserQueryService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;

/**
 * Report staff query service.
 * 
 * @author mauriciofernandesdecastro
 */
@Service
public class ReportStaffQueryService {

	@Inject 
	private StaffMemberRepository staffMemberRepository;
	
	@Inject
	private UserRepository userRepository;
	
	@Inject 
	private UserQueryService userQueryService;

	/**
	 * List staff.
	 * 
	 * @param folderId
	 * @param pageNumber
	 */
	public Page<StaffMember> staffMemberList(Integer folderId, Integer pageNumber) {
		Pageable page = new PageRequest(pageNumber, 100, Direction.ASC, "identity.displayName", "identity.personalData.firstName");
		return staffMemberRepository.findByFolderId(folderId, page );
	}

	/**
	 * List users from entity.
	 * 
	 * @param userAuthentication
	 */
	public List<User> getUserList(UserAuthentication userAuthentication) {
		return userQueryService.userList(userAuthentication.getEntityId(), 'G', "A", 0, 1000).getContent();
	}

	public StaffMember staffMemberOpen(Integer staffMemberId) {
		return staffMemberRepository.findById(staffMemberId);

	}
	
	/**
	 * Search users.
	 * 
	 * @param userAuthentication
	 * @param searchString
	 * @param searchFolderId
	 */
	public List<User> getUserListSearch(UserAuthentication userAuthentication, String searchString, Integer searchFolderId) {
		List<Integer> exclusions = staffMemberRepository.findIdentityIdsByReportFolderOnStaffMember(searchFolderId);
		// não há exclusões
		exclusions.add(0);
		Pageable page = new PageRequest(0, 1000, Direction.ASC, "userName", "userKey");
		Page<User> userList = 
				userRepository.searchByParentUserType(userAuthentication.getEntityId(), exclusions
				, searchString, 'A', "A".toCharArray(), page);
		return userList.getContent();
	}

}

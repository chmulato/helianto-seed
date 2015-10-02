package com.iservport.report.service;

import javax.inject.Inject;

import org.helianto.core.domain.Identity;
import org.helianto.core.repository.IdentityRepository;
import org.helianto.task.domain.ReportFolder;
import org.helianto.task.domain.StaffMember;
import org.helianto.task.repository.ReportFolderRepository;
import org.helianto.task.repository.StaffMemberRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Report staff command service.
 * 
 * @author mauriciofernandesdecastro
 */
@Service
public class ReportStaffCommandService {

	@Inject 
	private StaffMemberRepository staffMemberRepository;
	
	@Inject
	private ReportFolderRepository reportFolderRepository;
	
	@Inject 
	private IdentityRepository identityRepository;

	/**
	 * Recupera um StaffMember baseado no Id.
	 * 
	 * @param staffMemberId
	 */
	public StaffMember staffMemberOpen(Integer staffMemberId) {
		StaffMember staffMember = staffMemberRepository.findById(staffMemberId);
		if (staffMember!=null) {
			return staffMember;
		}
		throw new UnsupportedOperationException("staffMemberId required.");
	}

	/**
	 * Atualiza.
	 * 
	 * @param command
	 */
	@Transactional
	public StaffMember staffMember(StaffMember command) {
		StaffMember target = null;
		ReportFolder reportFolder = null;
		Identity identity = null;
		if (command.getId()==0) {
			if (command.getReportFolderId()==null || command.getIdentityId()==null) {
				throw new RuntimeException("Report Folder and identity required");
			}
			reportFolder = reportFolderRepository.findOne(command.getReportFolderId());
			identity = identityRepository.findOne(command.getIdentityId());
			if (reportFolder==null || identity ==null) {
				throw new RuntimeException("Report Folder and identity required");
			}
			Integer existing = staffMemberRepository.findByReportFolderIdAndIdentityId(reportFolder.getId(), identity.getId());
			if (existing!=null)  {
				throw new RuntimeException("StaffMember not unique.");
			}
			target = new StaffMember(reportFolder, identity);
		}
		else {
			target = staffMemberRepository.findOne(command.getId());
		}
		return staffMemberRepository.saveAndFlush(target.merge(command));
	}

	
	public String staffMemberDelete(Integer staffMemberId) {
			StaffMember member = staffMemberRepository.findOne(staffMemberId);
			if (member!=null) {
				try {
					staffMemberRepository.delete(member);	
				} catch (Exception e) {
					throw new RuntimeException("STAFF_MEMBER_CANNOT_DELETE");	
				}
			}else{
				throw new RuntimeException("STAFF_MEMBER_NOT_FOUND");	
			}			
			return "{\"deleted\":true}";
	}

}

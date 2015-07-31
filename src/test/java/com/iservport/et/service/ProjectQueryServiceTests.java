package com.iservport.et.service;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import com.iservport.testit.TestConfig;

/**
 * 
 * @author mauriciofernandesdecastro
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes={TestConfig.class})
//@Transactional
public class ProjectQueryServiceTests {

	@Test
	public void project() {
		service.project("53fd922b-eece-430e-8dc5-a35a00acf0cd");
	}
	
	private ProjectQueryService service;
	
	@Before
	public void setUp() {
		service = new ProjectQueryService();
	}

}

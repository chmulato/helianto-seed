package com.iservport.et.service;

import javax.inject.Inject;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.iservport.testit.TestConfig;

/**
 * 
 * @author mauriciofernandesdecastro
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes={TestConfig.class})
//@Transactional
public class ProjectQueryServiceTests {

	@Inject
	private ETProjectQueryService service;

	@Test
	public void project() {
		service.project("53fd922b-eece-430e-8dc5-a35a00acf0cd");
	}
	
	@Before
	public void setUp() {
		service = new ETProjectQueryService();
	}

}

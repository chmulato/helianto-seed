package com.iservport.category.service;

import javax.inject.Inject;

import org.helianto.core.domain.Category;
import org.helianto.core.domain.Entity;
import org.helianto.core.repository.CategoryReadAdapter;
import org.helianto.core.repository.CategoryRepository;
import org.helianto.core.repository.EntityRepository;
import org.helianto.core.repository.IdentityRepository;
import org.helianto.user.repository.UserRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;


/**
 * Serviço de criação e atualização de categorias.
 * 
 * @author Eldevan Nery Junior
 */
@Service
public class CategoryCommandService {

	private static final Logger logger = LoggerFactory.getLogger(CategoryCommandService.class);
	
	@Inject 
	protected CategoryRepository categoryRepository;
	
	@Inject 
	protected UserRepository userRepository;
	
	@Inject 
	protected EntityRepository entityRepository;
	
	@Inject 
	protected IdentityRepository identityRepository;
	
	public CategoryReadAdapter categoryNew(int entityId, Character categoryGroup) {
		Entity entity = entityRepository.findOne(entityId); 
		Category category = new Category(entity, categoryGroup,"");
		return new CategoryReadAdapter(category).build();

	}

	public CategoryReadAdapter category(int entityId, CategoryReadAdapter command) {
		Category target = null;
		//criar novo
		if(command.getId()==0){
			Integer existing 
			= categoryRepository.findByEntity_IdAndCategoryGroupAndCategoryCode(entityId
				, command.getCategoryGroup() 
				, command.getCategoryCode());
			if(existing==null || existing==0){
				target = categoryNew(entityId, command.getCategoryGroup()).merge();
			}
			else {
				logger.debug("Category code={} already exists.", command.getCategoryCode());
				throw new RuntimeException();
				//throw new SaveEntityException(existing,"CATEGORY_EXISTS", 404);
			}
		//update	
		}
		else{
			target = categoryRepository.findOne(command.getId());
		}
		target = categoryRepository.saveAndFlush(command.setAdaptee(target).merge());
		return categoryRepository.findAdapter(target.getId());
	}
	
}

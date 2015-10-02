package com.iservport.category.service;
  
import java.util.List;

import javax.inject.Inject;

import org.helianto.core.domain.Category;
import org.helianto.core.internal.QualifierAdapter;
import org.helianto.core.internal.SimpleCounter;
import org.helianto.core.repository.CategoryReadAdapter;
import org.helianto.core.repository.CategoryRepository;
import org.helianto.core.repository.EntityRepository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;

import com.iservport.category.controller.CategorySearchController.InternalCategoryGroup;
import com.iservport.category.repository.CategoryTmpRepository;

/**
 * Category query service.
 * 
 * @author mauriciofernandesdecastro
 */
@Service
public class CategoryQueryService {

	@Inject
	protected CategoryRepository categoryRepository;
	
	@Inject CategoryTmpRepository categoryTmpRepository; 
	
	@Inject 
	protected EntityRepository entityRepository;
	

	public List<QualifierAdapter> qualifier(int entityId) {
		List<QualifierAdapter> qualifierList 
			= QualifierAdapter.qualifierAdapterList(InternalCategoryGroup.values());
	
		// realiza a contagem
		qualifierCount(entityId, qualifierList);
		
		return qualifierList;
	}
	
	/**
	 * Método auxiliar para contar os qualificadores.
	 * 
	 * @param entityId
	 * @param qualifierList
	 */
	public void qualifierCount(Integer entityId, List<QualifierAdapter> qualifierList) {
		
		// conta categorias agrupadas
		List<SimpleCounter> counterListAll 
			= categoryTmpRepository.countCategoriesByEntityIdGroupByGroup(entityId);
	
		// para cada qualificador preenchemos as contagens
		for (QualifierAdapter qualifier: qualifierList) {
			qualifier.setCountItems(counterListAll);
		}
		
	}

	public Page<CategoryReadAdapter> category(int entityId, Character categoryGroup, Integer pageNumber) {
		Pageable page = new PageRequest(pageNumber, 20, Direction.ASC, "categoryCode");
		return categoryRepository.findByEntity_IdAndCategoryGroup(entityId, categoryGroup, page);
	}
	
	public Page<CategoryReadAdapter> categorySearch(int entityId, Character categoryGroup, Integer pageNumber, String search, String orderString) {
		Pageable page = new PageRequest(pageNumber, 20, Direction.ASC, orderString);
		char[] categoryGroups = {categoryGroup} ;
		if(categoryGroup.equals('_')){
			 categoryGroups = InternalCategoryGroup.valuesAsArray();
		}
		return categoryTmpRepository
				.findByEntityIdAndCategoryGroupAndCategoryCodeLikeOrCategoryNameLike(entityId, categoryGroups, search, page);
	}
	
	public CategoryReadAdapter categoryOne(int id) {
		//TODO arrumar construtor do findAdapter ; adicionar categoryGroup ...
		Category category = categoryRepository.findOne(id);
		CategoryReadAdapter adapter= new CategoryReadAdapter(category);
		return  adapter.build();
	}

}

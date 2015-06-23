package com.iservport.category.repository;

import java.io.Serializable;
import java.util.List;

import org.helianto.core.domain.Category;
import org.helianto.core.internal.SimpleCounter;
import org.helianto.core.repository.CategoryReadAdapter;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

/**
 * Repositório de categorias temporário.
 * 
 * @author Eldevan Nery Junior.
 */
public interface CategoryTmpRepository 
	extends JpaRepository<Category, Serializable>
{

	@Query("select new "
			+ "org.helianto.core.repository.CategoryReadAdapter"
			+ "(category.id"
			+ ", category.entity.id"
			+ ", category.categoryGroup"
			+ ", category.categoryCode"
			+ ", category.categoryName"
			+ ", category.categoryIcon"
			+ ", category.scriptItems"
			+ ", category.customProperties"
			+ ", category.content"
			+ ") "
			+ "from Category category "
			+ "where category.entity.id = ?1 "
			+ "and category.categoryGroup in ?2 "
			+ "and (category.categoryCode like %?3% OR category.categoryName like %?3% )")
	Page<CategoryReadAdapter> findByEntityIdAndCategoryGroupAndCategoryCodeLikeOrCategoryNameLike(int entityId, char[] categoryGroup
			, String search, Pageable page);
	
	/**
	 * Conta lista de categorias por entidade, agrupadas por grupo.
	 * 
	 * @param entityId
	 */
	@Query("select new " +
			"org.helianto.core.internal.SimpleCounter" +
			"(category.categoryGroup, count(category)) " +
			"from Category category " +
			"where category.entity.id = ?1 " +
			"group by category.categoryGroup")
	List<SimpleCounter> countCategoriesByEntityIdGroupByGroup(int entityId);

	

}

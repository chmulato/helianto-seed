package com.iservport.report.repository;

import java.io.Serializable;
import java.util.List;

import org.helianto.core.domain.Category;
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
public interface CategoryReportTmpRepository 
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
			+ "and category.categoryGroup = ?2 "
			+ "OR category.id in(select e.reportFolder.category.id from ReportFolderExported e where e.exportedEntity.id = ?1)")
	List<CategoryReadAdapter> findByEntityIdAndCategoryGroup(int entityId, char categoryGroup);

}

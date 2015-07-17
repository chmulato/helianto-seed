package com.iservport.category.controller;


import java.io.Serializable;
import java.util.List;

import javax.inject.Inject;

import org.helianto.core.internal.KeyNameAdapter;
import org.helianto.core.internal.QualifierAdapter;
import org.helianto.core.repository.CategoryReadAdapter;
import org.helianto.home.controller.SearchForm;
import org.helianto.security.internal.UserAuthentication;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.iservport.category.service.CategoryCommandService;
import com.iservport.category.service.CategoryQueryService;


/**
 * Controlador de categorias.
 * 
 * @author mauriciofernandesdecastro
 */
 @Controller
@RequestMapping("/api/category")
public class CategorySearchController {
	
	 private static final Logger logger = LoggerFactory.getLogger(CategorySearchController.class);
		
		@Autowired
		private CategoryQueryService categoryQueryService;
		
		@Inject 
		private CategoryCommandService categoryCommandService;
		
		/**
		 * List qualifiers
		 *
		 * GET		/app/category/qualifier
		 */
		@PreAuthorize("isAuthenticated()")
		@RequestMapping(value={"/qualifier"}, method=RequestMethod.GET)
		@ResponseBody
		public List<QualifierAdapter> qualifier(UserAuthentication userAuthentication) {
			return categoryQueryService.qualifier(userAuthentication.getEntityId());
		}
		
		/**
		 * List qualifiers by group.
		 *
		 * GET       /app/category?categoryGroup
		 */
		@PreAuthorize("isAuthenticated()")
		@RequestMapping(method=RequestMethod.GET, params={"categoryGroup"})
		@ResponseBody
		public Page<CategoryReadAdapter> categoryList(UserAuthentication userAuthentication
				, @RequestParam Character categoryGroup 
				, @RequestParam(defaultValue="0")Integer pageNumber) {
			return categoryQueryService.category(userAuthentication.getEntityId(), categoryGroup, pageNumber);
		}
		
		/**
		 * Seleciona uma categoria.
		 *
		 * GET       /app/category?categoryId
		 */
		@PreAuthorize("isAuthenticated()")
		@RequestMapping(method=RequestMethod.GET, params={"categoryId"})
		@ResponseBody
		public CategoryReadAdapter category(@RequestParam Integer categoryId) {
			return categoryQueryService.categoryOne(categoryId);
		}
		
		/**
		 * Cria categoria por grupo.
		 *
		 * POST       /app/category?categoryGroup
		 */
		@PreAuthorize("isAuthenticated()")
		@RequestMapping(method=RequestMethod.POST, params={"categoryGroup"})
		@ResponseBody
		public CategoryReadAdapter categoryNew(UserAuthentication userAuthentication
				, @RequestParam Character categoryGroup) {
			return categoryCommandService.categoryNew(userAuthentication.getEntityId(), categoryGroup);
		}

		
		/**
		 * Pesquisa categoria por grupo.
		 *
		 * POST       /app/category/search
		 */
		@PreAuthorize("isAuthenticated()")
		@RequestMapping(value={"/search"},method=RequestMethod.POST)
		@ResponseBody
		public Page<CategoryReadAdapter> categorySearch(UserAuthentication userAuthentication
				, @RequestBody SearchForm command) {
			return categoryQueryService.categorySearch(userAuthentication.getEntityId() 
					, command.getQualifierValueChar()
					, command.getPageNumber(), command.getSearchString()
					, command.getOrderString());
		}
	
		/**
		 * Atualiza categoria.
		 *
		 * PUT       /app/category
		 */
		@PreAuthorize("isAuthenticated()")
		@RequestMapping(method=RequestMethod.PUT, consumes="application/json")
		@ResponseBody
		public CategoryReadAdapter category(UserAuthentication userAuthentication
				, @RequestBody CategoryReadAdapter command) {
			return categoryCommandService.category(userAuthentication.getEntityId(), command);
		}
		
		/**
		 * Category groups.
		 * 
		 * @author Mauricio Fernandes de Castro
		 */
		public enum InternalCategoryGroup implements KeyNameAdapter {
			
			/**
			 * Not defined.
			 */
			NOT_DEFINED('N', "Indefinido"),
			/**
			 * Documento.
			 */
			DOCUMENT('D', "Documentos"),
			/**
			 * Projeto.
			 */
			PROJECT('J', "Projetos"),
			/**
			 * Projeto.
			 */
			REPORT('R', "Relatórios");
			
			private InternalCategoryGroup(char value, String caption) {
				this.value = value;
				this.caption = caption;
			}
			
			private char value;
			
			private String caption;
			
			public Serializable getKey() {
				return value;
			}
			
			@Override
			public String getCode() {
				return value+"";
			}
			
			@Override
			public String getName() {
				return caption;

			}
			
			public static char[] valuesAsArray(){
				InternalCategoryGroup.values();
				String values = "";
				for (InternalCategoryGroup categoryGroup : InternalCategoryGroup.values()) {
					values+=categoryGroup.getCode();
				}
				return values.toCharArray();
			}
			
		}
		
	
}




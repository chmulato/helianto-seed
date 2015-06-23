(function() {
	app = angular.module('category', ['ui.bootstrap', 'app.services', 'angular-redactor']);
	
	app.controller('CategoryController', ['$scope', '$window', '$http', '$resource' , 'genericServices', 'securityServices'
	                                  , function($scope, $window, $http, $resource, genericServices, securityServices) {
	
		//$scope.baseName = "category";
		
	
		// Métodos do controlador Angular para Catagorias

		var baseUrl = '/app/category/';

	
		$scope.showMenuItem =  function(code){
			return securityServices.showMenuItem(code);
		}
		$scope.isAuthorized = function(role, ext){
			return securityServices.isAuthorized(role, ext);
		}
		$scope.logout = function(){
			return securityServices.logout();
		}

	//	$scope.menu = menu;
		$scope.baseName = "category";
	//	$scope.menuName = "categories";

		$scope.categoryNotExists = true;


		$scope.open = function($event,value) {
			$event.preventDefault();
			$event.stopPropagation();
			$scope.datePicker = [];
			$scope.datePicker[value]= true;
		};
		
		/**
		 * Change state.
		 */
		$scope.changeState = 0;
		$scope.getChangeState = function(state) {
			return 	$scope.isAuthorized('CATEGORY', 'WRITE') 
					&& 	state===$scope.changeState;
		}
		$scope.setChangeState = function(state) {
			$scope.changeState = state;
		}

		/**
		 * Qualifier = tipo de conteúdo
		 */
		$scope.qualifierValue = 0;
		$scope.qualifierResource = $resource(baseUrl + "qualifier");
		$scope.listQualifiers = function() {
			$scope.qualifiers = $scope.qualifierResource.query();
			$scope.qualifiers.$promise.then(function(data) {
				if ($scope.qualifierValue === 0 && data.length>0 && $scope.externalId==0) {
					$scope.setQualifier($scope.qualifiers[0]);
				}
			})
		};
		$scope.setQualifier = function(qualifierItem) {
			$scope.qualifierValue = qualifierItem.qualifierValue;
			$scope.qualifierName = qualifierItem.qualifierName;
			$scope.categoryFolders = [];
			$scope.qualifier = qualifierItem;
			$scope.listCategories(qualifierItem.qualifierValue);
		}
		$scope.listQualifiers();


		/**
		 * Categories
		 */
		// search
		
		$scope.search = false;
		$scope.isSearch = function(){
			return $scope.search;
		}
		$scope.setSearch = function(val){
			$scope.search = val;
		}
		$scope.searchFilterVar=1;
		$scope.searchFilter = function(value){
			$scope.searchFilterVar= value;
		}
		
		$scope.searchResource= $resource(baseUrl+'search', null, {
			search:{ method: 'POST', isArray: false }});
		$scope.searchCategory = function(searchForm, page) {
			if(searchForm==null || searchForm=='undefined'){
				searchForm = {};	
			}
			if($scope.searchFilterVar!=1){
				searchForm.qualifierValueChar = $scope.qualifierValue;
			}else{
				searchForm.qualifierValueChar = '_';
			}	
			searchForm.pageNumber = page;
			searchForm.qualifierValueString = $scope.qualifierValue;
			console.log(searchForm);
			console.log(page);
			// resource search
			$scope.categorySearchList = $scope.searchResource.search(searchForm);
			$("#searchString").val("");
			$scope.categorySearchList.$promise.then(function(data) {
				//$scope.searchBool = true;
				$scope.page = page;
				$scope.nextAndPrevious = genericServices.getNextAndPreviousLinkByList(data);
				console.log(data);
				if(data.totalElements == 1){
					$scope.instrument = data.content[0];
				}
				else if(data.totalElements>1){
					$scope.categorySearchList = data;	
					openForm('form-search');
				}else{
					$("#searchMsg").fadeIn(1000);
					$("#searchMsg").fadeOut(5000);
					$("#searchMsg2").fadeIn(1000);
					$("#searchMsg2").fadeOut(5000);
					$scope.categorySearchList = [];
				}
			})    
		}
		
		$scope.categoryResource = $resource(baseUrl , { categoryGroup:"@categoryGroup"}, {
			save: { method: 'PUT' },
			create: { method: 'POST' },
		});
		//list
		$scope.listCategories = function(categoryGroupValue, page) {
			$scope.qualifierValue = categoryGroupValue;
			$scope.categoryList = $scope.categoryResource.get({categoryGroup:categoryGroupValue, pageNumber: page});
			$scope.categoryList.$promise.then(function(data) {
				$scope.nextAndPrevious = genericServices.getNextAndPreviousLinkByList(data);
				$scope.categoryList = data;
				if($scope.externalId==0){
					if (data.content.length>1 || data.totalElements == 0) {
						$scope.categories = data.content;
					//verifica se tem só um na lista e já mostra-o	
					}
					else if(data.totalPages == 1 && data.totalElements == 1 && data.numberOfElements == 1){
						$scope.category = data.content[0];
					}
				}
			})
		};

		//getOne
		$scope.getCategory = function(id, sectionVal, retrieveCascade, editing) {
			$scope.category = $scope.categoryResource.get({categoryId: id});
			if(sectionVal==null || sectionVal=='undefined'){
				sectionVal=1;
			}
			$scope.categorySection = sectionVal ;
			if(retrieveCascade==null || retrieveCascade=='undefined'){
				retrieveCascade=false;
			}
			if(editing==null || editing=='undefined'){
				retrieveCascade=false;
			}
			
			$scope.category.$promise.then(function(data) {
				if(data.id>0 ){
					$scope.qualifierValue = data.categoryGroup;
					if(editing){
						openForm('form-category');	
					}
				}
			});
		};

		if($scope.externalId>0){
			$scope.getCategory($scope.externalId,null, true);
		}

		$scope.setExternalId = function(val){
			$scope.externalId = val ;
		}

		//create
		$scope.newCategory = function(categoryGroupValue) {
			$scope.category = $scope.categoryResource.create({categoryGroup:categoryGroupValue});
			openForm('form-category');
		};
		//Update
		$scope.updateCategory = function() {
			//$scope.setChangeState(0);
			if($scope.category.categoryName.length>0){
				$scope.category = $scope.categoryResource.save($scope.category);
				$scope.category.$promise.then(
						function(data, getReponseHeaders) {
							$scope.listCategories($scope.qualifierValue);
							$scope.getCategory(data.id, 1);
							$("#modalBody").modal('hide');
						},
						function(data, getReponseHeaders) {
							console.log(data);
							if(data.status === 302) {
								$scope.message= data.data;
								$scope.message.exist= true;
							}
						}
				);
			};
		}

		$scope.categorySection = 1;
		$scope.setCategorySection = function(value){
			$scope.categorySection = value;
		}

		$scope.isCategorySection = function(value){
			return $scope.categorySection === value;
		}

		/**
		 * Abre um modal.
		 * 
		 * @param formName Nome do Fragmento (form-YYYY)
		 * 
		 */
		$scope.openForm = function(formName){
			openForm(formName);
		}

		function openForm(formName){
			$scope.message = [];
			//inicialização em form-report
			$scope.formUrl = '/assets/category/'+formName+'.html';
			$("#modalBody").modal('show');

		}

		/**
		 * Retorna o form a ser mostrado no Modal
		 */
		$scope.getFormUrl = function(){
			return $scope.formUrl;
		} 


	}]);

	/**
	 * View Controller
	 */
	app.controller('ViewController', ['$scope', '$http', 'securityServices', function($scope, $http, securityServices) {
		
		/**
		 * Abas
		 */
		$scope.sectionTab = 1;
		$scope.setSectionTab = function(value) {
			this.sectionTab = value;
	    };
	    $scope.isSectionTabSet = function(value) {
	      return this.sectionTab === value;
	    };

		/**
		 * Autorização
		 */
		$scope.authList =[];
		defineAuthorities();
		function defineAuthorities(){
			securityServices.getAuthorizedRoles(null).success(function(data, status, headers, config) {
				$scope.authList = data.content;
			});
		}
		$scope.isAuthorized =function(role, ext){
			return securityServices.isAuthorized($scope.authList, role, ext);
		}
		 
	}]);
	
} )();

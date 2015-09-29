(function() {
	/**
	 * Angular user module.
	 */
	app = angular.module('user', ['ui.bootstrap', 'app.services', 'angular-redactor'])
	/**
	 * Resources service.
	 */
	.factory('resources', ['$resource', function($resource) {
		var service = {};
		service.qualifier = $resource("/api/user/qualifier");
		service.user = $resource("/api/user/");
		service.resource = $resource("/app/user3/:method"
				, {qualifierValue:"@qualifierValue",groupId:"@groupId"
					, userGroupId : "@userGroupId", search:"@search"
					, novo:"@novo", pageNumber:"@pageNumber"}
				, { save: { method: 'PUT'}, create: {method: 'POST' }, remove:{method:'DELETE'}});
			service.identityResource = $resource('/app/identity/' 
					, { type : "@type", type2:"@type2", gender:"@gender"
						, pageNumber:"@pageNumber", identityId:"@identityId", mine:"@mine"
					  }
					, {	save: { method: 'PUT' }, create: { method: 'POST' 
					  }
				});
		return service;
	}]) 
	/**
	 * Angular user controller
	 */
	.controller('UserController', ['$scope', '$window', 'resources', 'qualifierService', 'genericServices', 'securityServices'
	                                  , function($scope, $window, resources, qualifierService, genericServices, securityServices) {
	
		$scope.baseName = "user";
		$scope.userStates = "A";
		$scope.itemsPerPage = 20;
		
		/**
		 * Qualifiers
		 */
		$scope.setQualifier = function(value, data) {
			if (Array.isArray(data)) {
				$scope.qualifiers = data;
			}
			$scope.qualifierValue = value;
			$scope.userList = {};
			$scope.listUsers(value);
		}
		qualifierService.run(resources.qualifier, $scope.setQualifier, 0);
		
		/**
		 * Users
		 */
		$scope.user = {};
		$scope.userId = 0;
		$scope.listUsers = function(userType, pageNumber) {
			$scope.userType = userType;
			$scope.userList = resources.user.get(
				{userType: userType, userStates: $scope.userStates, pageNumber: pageNumber, itemsPerPage: $scope.itemsPerPage})
			$scope.userList.$promise.then(function(data) {
				if (data.content.length>0) {
					if ($scope.userId === 0  && externalId==0) {
						$scope.user = data.content[0];
						$scope.userId = user.id;
					}
				}
			})
		}
		$scope.pageChanged = function() {
			var value = $scope.userList.number;
		    $scope.listUsers($scope.qualifierValue, value);
		}
		$scope.setItemsPerPage = function(value) {
			$scope.itemsPerPage = value;
		    $scope.listUsers($scope.qualifierValue, 1);
		}
		$scope.getUser = function(value) {
			$scope.user = resources.user.get(
				{userId: value});
			$scope.user.$promise.then(function(data) {
				if (data.length>0) {
					$scope.user = data;
					$scope.userId = user.id;
				}
			})
		}
		
		$scope.newUser = function(){
			$scope.openForm('user-new');	
		};
		/**
		 * Procura usuário antes de criar um novo.
		 * 
		 * Caso haja uma identidade para ele
		 */
		$scope.userSearch= function(){
			resources.resource.create($scope.search).$promise.then(
			function(data) {
				$scope.searchDetails = data;
				if(!data.cannotCreate){
					//não existe identity
					if(data.createIdentity){
						var userName = data.userName;
						resources.identityResource.create().$promise.then(
						function(data) {
							$scope.identity = data;
							$scope.identity.principal = userName;
							$scope.identity.notification = 'A';
							$scope.identity.identityType = 'ORGANIZATIONAL_EMAIL';
							$scope.openForm('identity');	
						});
					}
					//existe identity mas não usuário amarrá-los	
					else if(data.createUser){
						$scope.identity = resources.identityResource.get({identityId: data.identityId});
						$scope.openForm('identity');	
					}
				}
				console.log(data);
			});
		};

		
		/**
		 * Identity data
		 */
		$scope.userGenderIcon = [];
		$scope.userGenderIcon.F ="fa fa-female";
		$scope.userGenderIcon.M ="fa fa-male";
		$scope.userGenderIcon.N ="fa fa-transgender";
		$scope.userGenderIcon.FEMALE ="fa fa-female";
		$scope.userGenderIcon.MALE ="fa fa-male";
		$scope.userGenderIcon.NOT_SUPPLIED ="fa fa-transgender";
		
		$scope.identityTypes = ["NOT_ADDRESSABLE", "ORGANIZATIONAL_EMAIL", "PERSONAL_EMAIL" ];
		$scope.genders = ["NOT_SUPPLIED", "MALE", "FEMALE" ];
		
		//variável que define se está criando usuário ou atualizando a pŕopria identidade
		$scope.myIdentity= false;		
		$scope.updateUser = function(){
			console.log($scope.identity);
			if($scope.myIdentity){
				$scope.identity = resources.identityResource.save({mine:true}, $scope.identity);
			}else{
				$scope.identity = resources.identityResource.save($scope.identity);
			}	
			$scope.identity.$promise.then(function(data) {
				if(data.id>0){
					$("#modalBody").modal('hide');	
					$scope.listUsers($scope.userType, 1);
					$scope.myIdentity= false;
				}
			});
		};

		$scope.updateMyIdentity = function(){
			$scope.myIdentity = true;
			$scope.identity = resources.identityResource.get({ mine: true});
			$scope.openForm('identity');	
		};
		
		$scope.search = {"search": "", "novo":true};
		//flag para dizer que ainda não pesquisou
		$scope.searchDetails = {"identityId":-1};

	    $scope.getFormUrl = function(){
			return $scope.formUrl;
		} 

		$scope.openForm = function(formName){
			$scope.message =[];
			$scope.formUrl = '/assets/user/form/'+formName+'.html';
			$("#modalBody").modal('show');
		}
		$scope.todayDate =  new Date();
		$scope.dateOptionsBirthDate = {
		};

	
		$scope.open = function($event,value) {
			$event.preventDefault();
			$event.stopPropagation();
			$scope.datePicker = [];
			$scope.datePicker[value]=true;
		};
		
	}]); // userController
	
} )();

(function() {
	app = angular.module('home', ['ui.bootstrap', 'app.layout', 'app.services', 'ngResource', 'ngSanitize', 'angular-loading-bar', 'angular-redactor', 'ui.bootstrap.accordion'])
	/**
	 * Recursos de home
	 */
	.factory('resources', ['$resource', function($resource) {
		var service = {};
		service.resource = $resource("/api/home/:method"
			, null
			, { save: { method: 'PUT'}, create: {method: 'POST' }, remove:{method:'DELETE'}});
		return service;
	}])
	.controller('HomeController', ['$scope', '$window', '$http', 'resources' , 'genericServices', 'securityServices'
	                                  , function($scope, $window, $http, resources, genericServices, securityServices) {
	
		$scope.baseName = "home";
		
		/**
		 * Lista projetos do usuário logado.
		 */
		$scope.testCheckedProject = 0;
		$scope.listProjects = function() {
			resources.resource.query({method:'project'}).$promise.then(
			function(data) {
				$scope.projetos = data;
				if ($scope.testCheckedProject==0) {
					$scope.testCheckedProject = data[0];
				}
			})
		};
		$scope.listProjects();
		
		/**
		 * Verdadeiro se o projeto é o atual para o usuário.
		 */
		$scope.isUserCheckedInProject = function(value) {
			return value==$scope.testCheckedProject;
		};
		$scope.checkIn = function(value) {
			$scope.testCheckedProject = value;
		};
		$scope.ordenarPor = function (campo) {
			$scope.criterioDeOrdenacao = campo;
			$scope.direcaoDaOrdenacao = !$scope.direcaoDaOrdenacao;				
		};
		$scope.confirmarProjeto = function () {
			value = $scope.testCheckedProject;
			if (value > 0) {
				return value;
			} else {
				return 0;
			}
		};
		$scope.ativarBtnConfirmar = function () {
			value = $scope.testCheckedProject;
			if (value > 0) {
				return false;
			} else {
				return true;
			}
		};

	}]); // HomeController
	

} )();
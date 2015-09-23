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
		
		$scope.adicionarProjeto = function (projeto) {
			if (projeto != null) {
				$scope.projetos.push(angular.copy(projeto));
 				delete $scope.projeto;
 				$scope.projetoForm.$setPristine();
			}
		};
		$scope.apagarProjetos = function (projetos) {
			$scope.projetos = projetos.filter(function (projeto) {
				if (!projeto.selecionado) return projeto;
			});
		};
		$scope.isProjetoSelecionado = function (projetos) {
			return projetos.some(function (projeto) {
				return projeto.selecionado;
			});
		};
		$scope.classe1 = "selecionado";
		$scope.classe2 = "negrito";
		$scope.ordenarPor = function (campo) {
			$scope.criterioDeOrdenacao = campo;
			$scope.direcaoDaOrdenacao = !$scope.direcaoDaOrdenacao;				
		};

	}]); // HomeController
	

} )();
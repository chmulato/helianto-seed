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
		$scope.projetos = [
				{nome: "Projeto 1", cor: "black", data: new Date(), checkin: "true" , checkout: "false"},
				{nome: "Projeto 2", cor: "white", data: new Date(), checkin: "false", checkout: "true" }, 
				{nome: "Projeto 3", cor: "white", data: new Date(), checkin: "false", checkout: "true" },
				{nome: "Projeto 4", cor: "white", data: new Date(), checkin: "false", checkout: "true" },
				{nome: "Projeto 5", cor: "white", data: new Date(), checkin: "false", checkout: "true" }
		];
		
		$scope.listReportFolders = function(reportCategory) {
			$scope.report = {"id":-1};
			resources.resource.get({method:'project', qualifierValue:reportCategory}).$promise.then(
			function(data) {
				$scope.reportFolders = data;
				if (data.content.length>0 && $scope.externalId==0) {
					if($scope.folderValue==0) {
						$scope.reportFolder = data.content[0];
					}
					$scope.setReportFolder($scope.reportFolder);
				}
			})
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
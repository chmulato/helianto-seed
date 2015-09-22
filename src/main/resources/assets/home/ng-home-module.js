(function() {
	app = angular.module('home', ['ui.bootstrap', 'app.services']);
	
	app.controller('HomeController', ['$scope', '$window', '$http', '$resource' , 'genericServices', 'securityServices'
	                                  , function($scope, $window, $http, $resource, genericServices, securityServices) {
	
		$scope.baseName = "home";
		$scope.projetos = [
				{nome: "Projeto 1", cor: "black", data: new Date(), checkin: "true" , checkout: "false"},
				{nome: "Projeto 2", cor: "white", data: new Date(), checkin: "false", checkout: "true" }, 
				{nome: "Projeto 3", cor: "white", data: new Date(), checkin: "false", checkout: "true" },
				{nome: "Projeto 4", cor: "white", data: new Date(), checkin: "false", checkout: "true" },
				{nome: "Projeto 5", cor: "white", data: new Date(), checkin: "false", checkout: "true" }
		];
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
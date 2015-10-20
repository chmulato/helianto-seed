(function() {
	app = angular.module('home', ['ui.bootstrap', 'app.layout', 'app.services', 'ngResource', 'ngSanitize', 'angular-loading-bar', 'angular-redactor', 'ui.bootstrap.accordion'])
	/**
	 * Recursos de home
	 */
	.factory('resources', ['$resource', function($resource) {
		var service = {};
		service.resource = $resource("/api/home/:method"
			, {folderId : "@folderId"}
			, { save: { method: 'PUT'}, create: {method: 'POST' }, remove:{method:'DELETE'}});
		return service;
	}])
	.controller('HomeController', ['$scope', '$window', '$http', 'resources' , 'genericServices'
	                                  , function($scope, $window, $http, resources, genericServices) {
	
		$scope.baseName = "home";
		
		/**
		 * Lista projetos do usuário logado.
		 */
		$scope.checked = false;
		$scope.checkout = false;
		$scope.testCheckedProject = 0;

		/**
		 * atributo para mensagem de sucesso.
		 */
		$scope.getChecked = function() {
			return $scope.checked;
		};

		/**
		 * nenhum projeto checkin ativo.
		 */
		$scope.getCheckout = function() {
			var checkout = $scope.checkout;
			var projetos = $scope.projetos;
			if ((projetos != null) && (projetos.length > 0)) {
				for (i = 0; i < projetos.length; i++) { 
					if (projetos[i].checkinDate == null) {
						checkout = true;
					} else {
						checkout = false;
					}
				}
			}
			$scope.checkout = checkout;
		};
		
		/**
		 * recupera a lista de projetos do usuario.
		 */
		$scope.listProjects = function() {
			resources.resource.query({method:'project'}).$promise.then(
			function(data) {
				$scope.projetos = data;
				console.log("recuperando lista de projetos ...")
				if ($scope.testCheckedProject==0) {
					$scope.testCheckedProject = data[0];
				}
			})
		};
		$scope.listProjects();
		$scope.getCheckout();
		$scope.getChecked();

		/**
		 * Verdadeiro se o projeto é o atual para o usuário.
		 */
		$scope.isUserCheckedInProject = function(projeto) {
			if (projeto == null) {
				return false;
			} else {
				if (projeto.checkinDate == null) {
					return false;
				} else {
					return true;
				}
			}
		};
		
		/**
		 * recuperar a data de agora para o checkin do projeto.
		 */
		$scope.now = new Date();
		$scope.convertToDate = function (strDate) {
			var nowDate = new Date(strDate);
		    var dia = nowDate.getDate();
		    if (dia.toString().length == 1) {
			      dia = "0" + dia;
		    }
		    var mes = nowDate.getMonth()+1;
		    if (mes.toString().length == 1) {
			      mes = "0" + mes;
		    }
		    var ano = nowDate.getFullYear();  
		    return dia + "/" + mes + "/" + ano;
		};
		$scope.convertToTime = function (strTime) {
			var nowTime = new Date(strTime);
			var year = "" + nowTime.getFullYear();
			var month = "" + (nowTime.getMonth() + 1);
			if (month.length == 1) { 
				month = "0" + month; 
			}
			var day = "" + nowTime.getDate();
			if (day.length == 1) {
				day = "0" + day; 
			}
			var hour = "" + nowTime.getHours();
			if (hour.length == 1) {
				hour = "0" + hour; 
			}
			var minute = "" + nowTime.getMinutes();
			if (minute.length == 1) {
				minute = "0" + minute;
			}
			var second = "" + nowTime.getSeconds();
			if (second.length == 1) {
				second = "0" + second;
			}
			return day + "/" + month + "/" + year + " " + hour + ":" + minute + ":" + second;
		};

		$scope.setCheckinDateNull = function() {
			var projetos = $scope.projetos;
			if ((projetos != null) && (projetos.length > 0)) {
				for (i = 0; i < projetos.length; i++) { 
					projetos[i].checkinDate = null;
				}
				$scope.projetos = projetos;
			}
		};

		$scope.setCheckinDateNow = function(projeto) {
			var projetoId = projeto.id;
			var projetos = $scope.projetos;
			if ((projetos != null) && (projetos.length > 0)) {
				for (i = 0; i < projetos.length; i++) { 
					if (projetoId == projetos[i].id) {
						projetos[i].checkinDate = $scope.now;
					}
				}
				$scope.projetos = projetos;
			}
		};
		
		$scope.checkIn = function(projeto) {
			$scope.checked = false;
			$scope.setCheckinDateNull();
			$scope.setCheckinDateNow(projeto);
			$scope.testCheckedProject = projeto;
		};
		
		$scope.ordenarPor = function (campo) {
			$scope.criterioDeOrdenacao = campo;
			$scope.direcaoDaOrdenacao = !$scope.direcaoDaOrdenacao;				
		};
		$scope.confirmar = function () {
			var checkinDate = $scope.now;
			var project = $scope.testCheckedProject;
			project.checkinDate = checkinDate;
			console.log("project.checkinDate => " + project.checkinDate);
			var value = project;
			console.log("project id checkin => " + value.id);
			if (value > 0) {
				$scope.testCheckedProject = value;
 				$scope.contatoForm.$setPristine();
				return value;
			} else {
				return 0;
			}
		};
		$scope.setCheckedProject = function(projeto) {
			console.log("set projeto retornado");
			$scope.testCheckedProject = projeto;
			$scope.projetos.push(projeto);
			$scope.listProjects();
		};
		$scope.updateCheckedProject = function() {
			var project = $scope.testCheckedProject;
			console.log("project id updated => " + project.id);
			console.log("checkin date => " + project.checkinDate);
			resources.resource.save({method:'project'}, $scope.testCheckedProject).$promise.then(
			function(data, getReponseHeaders) {
				console.log("data log => " + data);
				console.log("response project id => " + data.id);
				$scope.setCheckedProject(data);
				$scope.checked = true;
			});
		};

	}]); // HomeController
	
} )();

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
	.controller('HomeController', ['$scope', '$window', '$http', 'resources' , 'genericServices', 'securityServices'
	                                  , function($scope, $window, $http, resources, genericServices, securityServices) {
	
		$scope.baseName = "home";
		
		/**
		 * Lista projetos do usuário logado.
		 */
		$scope.checked = false;
		$scope.testCheckedProject = 0;

		/**
		 * atributo para mensagem de sucesso.
		 */
		$scope.getChecked = function() {
			return $scope.checked;
		};
		
		/**
		 * recupera a lista de projetos do usuario.
		 */
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
		$scope.getChecked();
		
		/**
		 * recupera o projeto que esta em checkin.
		 */
		$scope.checkinDate = function(projetos) {
			if (projetos != null) {
				for (var i = 0; i < projetos.length; i++) {
					var projeto = projetos[i];
					if (projeto.checkinDate != null) {
						console.log("value  [i] => " + i);
						console.log("project id => " + projeto.id);
						$scope.testCheckedProject = projeto.id;	
					}
				}
			}
		};
		$scope.checkinDate($scope.listProjects());
		
		/**
		 * Verdadeiro se o projeto é o atual para o usuário.
		 */
		$scope.isUserCheckedInProject = function(value) {
			var id = $scope.testCheckedProject.id;
			if (value == id) {
				return true;
			} else {
				return false;
			}
		};
		$scope.isUserCheckedInProject($scope.testCheckedProject);
		
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

		$scope.checkIn = function(value) {
			$scope.testCheckedProject = value;
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
		$scope.setCheckedProject = function(project) {
			$scope.testCheckedProject = project;
			$scope.listProjects();
		};
		$scope.updateCheckedProject = function() {
			var project = $scope.testCheckedProject;
			console.log("project id updated => " + project.id);
			console.log("checkin date => " + project.checkinDate);
			resources.resource.save({method:'project'}, $scope.testCheckedProject).$promise.then(
			function(data, getReponseHeaders) {
				console.log("data log => " + data);
				$scope.setCheckedProject(data);
				$scope.checked = true;
			});
		};

	}]); // HomeController
	
} )();

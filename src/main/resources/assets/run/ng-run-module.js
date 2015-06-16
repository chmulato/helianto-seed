(function() {
	app = angular.module('run', ['ui.bootstrap', 'app.services']);
	
	app.controller('RunController', ['$scope', '$window', '$http', '$resource' , 'genericServices', 'securityServices'
	                                  , function($scope, $window, $http, $resource, genericServices, securityServices) {
	
		$scope.baseName = "run";
		
	}]); // RunController
} )();

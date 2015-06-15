(function() {
	app = angular.module('rum', ['ui.bootstrap', 'app.services']);
	
	app.controller('RumController', ['$scope', '$window', '$http', '$resource' , 'genericServices', 'securityServices'
	                                  , function($scope, $window, $http, $resource, genericServices, securityServices) {
	
		$scope.baseName = "rum";
		
	}]); // RumController
} )();

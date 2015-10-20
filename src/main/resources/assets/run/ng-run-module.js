(function() {
	app = angular.module('run', ['ui.bootstrap', 'app.services']);
	
	app.controller('RunController', ['$scope', '$window', '$http', '$resource' , 'genericServices'
	                                  , function($scope, $window, $http, $resource, genericServices) {
	
		$scope.baseName = "run";
		
	}]); // RunController
	
} )();
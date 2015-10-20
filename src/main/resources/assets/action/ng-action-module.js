(function() {
	app = angular.module('action', ['ui.bootstrap', 'app.services']);
	
	app.controller('ActionController', ['$scope', '$window', '$http', '$resource' , 'genericServices'
	                                  , function($scope, $window, $http, $resource, genericServices) {
	
		$scope.baseName = "action";
		
	}]); // ActionController
	
} )();

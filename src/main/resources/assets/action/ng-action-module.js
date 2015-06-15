(function() {
	app = angular.module('action', ['ui.bootstrap', 'app.services']);
	
	app.controller('ActionController', ['$scope', '$window', '$http', '$resource' , 'genericServices', 'securityServices'
	                                  , function($scope, $window, $http, $resource, genericServices, securityServices) {
	
		$scope.baseName = "action";
		
	}]); // ActionController
} )();


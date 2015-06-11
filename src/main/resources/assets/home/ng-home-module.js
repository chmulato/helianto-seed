(function() {
	app = angular.module('home', ['ui.bootstrap', 'app.services']);
	
	app.controller('HomeController', ['$scope', '$window', '$http', '$resource' , 'genericServices', 'securityServices'
	                                  , function($scope, $window, $http, $resource, genericServices, securityServices) {
	
		$scope.baseName = "home";
		
	}]); // HomeController
} )();



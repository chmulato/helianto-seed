(function() {
	app = angular.module('user', ['ui.bootstrap', 'app.services', 'angular-redactor']);
	
	app.controller('UserController', ['$scope', '$window', '$http', '$resource' , 'genericServices', 'securityServices'
	                                  , function($scope, $window, $http, $resource, genericServices, securityServices) {
	
		$scope.baseName = "user";
		
	}]); // userController
} )();


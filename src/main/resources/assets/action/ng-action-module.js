(function() {
	app = angular.module('action', ['ui.bootstrap', 'app.services']);
	
	app.controller('ActionController', ['$scope', '$window', '$http', '$resource' , 'genericServices', 'securityServices'
	                                  , function($scope, $window, $http, $resource, genericServices, securityServices) {
	
		$scope.baseName = "action";
		
	}]); // ActionController
	
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


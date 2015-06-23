/* Generic Services */                                                                                                                                                                                                    


var myMod = angular.module('app.services', ['ngResource'])
.config(function (datepickerConfig, datepickerPopupConfig) {
    datepickerConfig.showWeeks = false;
    // datepickerPopupConfig.toggleWeeksText = null;
    datepickerPopupConfig.showButtonBar = false;

})
.config(function ($provide, $httpProvider) {
	$provide.factory('MyHttpInterceptor', ['$q','$location', function ($q, $location) {
		return {
			request: function (config) {
				return config || $q.when(config);
			},
			requestError: function (rejection) {
				return $q.reject(rejection);
			},
			response: function (response) {
				
				 if(response.config.url=="/logout"){
					 //nao funciona ainda, 
					 //resolvi com o href="/login" mas talvez isto seja uma idéia interessante
					 //ele chega até aqui,,,
					 $location.path('login');
				 }
				return response || $q.when(response);
			},
			responseError: function (rejection) {
				return $q.reject(rejection);
			}
		};
	}]);

	$httpProvider.interceptors.push('MyHttpInterceptor');

})
.constant("optionsX", {
	allowedContent: true,
    entities: false,
	toolbar : [{ name: 'document', 
				 items: ['Format', '-', 'Bold', 'Italic', 'Underline', 'TextColor', '-', 
						'NumberedList', 'BulletedList', '-', 'Checkbox', '-' , 
						'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock', '-', 
						'Image', 'Link', 'Table', '-' , 
						'Undo', 'Redo', '-', 'Source' ]
			  }]
})
.factory("securityServices", ['$http', function($http) {
	var categoryMapList =  {};
	var getCategoryMap = function() {
		return $http.get('/app/category/qualifier')
		.success(function(data, status, headers, config) {
			categoryMapList = data;
		});
	}
	var roleList = [];
	var getAuthorizedRoles = function(userId) {
		return $http.get('/entity/auth'+((userId!=null && userId!='null')?'?userId='+userId:''))
		.success(function(data, status, headers, config) {
			roleList = data.content;
		});
	}
	return {
		getAuthorizedRoles : (getAuthorizedRoles) ,
		isAuthorized: function(role, extension) {
			var result = false;
			roleList.forEach(function(entry) {
				if(entry.serviceName == (role) && entry.serviceExtension.indexOf(extension)>-1){
					result = true;
				}
			});
			return result;
		
		}
		, getCategoryMap:(getCategoryMap)
		, showMenuItem : function(menuCode){
			var result = false;
			categoryMapList.forEach(function(entry) {
				if(entry.qualifierValue == menuCode && entry.countItems>0){
					result = true;
				}	
			});
			return result;
		}
		, logout: function() {return $http.post('/logout')}
		}
}])
.factory("genericServices", function() {                                                                                                                                                   
	return {                                                                                                                                                                                                              
		getNextAndPreviousLinkByList: function(list) {   
			var page = {next:0, previous:0, hasNext:false, hasPrevious:false}; 
			if(list.number!=0){
				page.previous = list.number-1;
				page.hasPrevious = true;
			}
			if(list.number+1<list.totalPages){				
				page.next = list.number+1;
				if(list.numberOfElements==list.size && list.totalElements > list.size ){
					page.hasNext = true;	
				}				
			}
			return page;
		},
		/**
		 * Transforma um Form num object pronto para ser Transformado em Json
		 * @param form
		 */
		serializeObject : function(form)
		{ //from : http://jsfiddle.net/sxGtM/3/
			var json = {};
			var formData = form.serializeArray();
			$.each(formData, function() {
				if (json[this.name] !== undefined) {
					if (!json[this.name].push) {
						json[this.name] = [json[this.name]];
					}
					json[this.name].push(this.value || '');
				} else {
					json[this.name] = this.value || '';
				}
			});
			return json;
		}
	}
})
//filters
//================================================= 
.filter('pad', function() {
	return function(num) {
		return (num < 10 ? '0' + num : num); // coloca o zero na frente
	};
})
//directives
.directive('ngClock', ["$timeout", function($timeout){
	return {
		restrict: 'EA',
		template:'<span class = "time">'
			+ '<span class = "hours">'
			+ ' {{date.getHours() | pad}}'
			+ '</span>:<span class = "minutes">'
			+ ' {{date.getMinutes() | pad}}'
			+ '</span>:<span class = "seconds">'
			+ ' {{date.getSeconds() | pad}}'
			+ '</span>'
			+ '</span>',
			controller: function($scope, $element) {
				$scope.date = new Date();

				var tick = function() {
					$scope.date = new Date();
					$timeout(tick, 1000);
				};
				$timeout(tick, 1000);
			}
	}

}])
/**
 * Diretiva para customizar peças (veículos, etc..)
 */
.directive('dynamic', function ($compile) {
	return {
		restrict: 'A',
		replace: true,
		link: function (scope, ele, attrs) {
			scope.$watch(attrs.dynamic, function(template) {
				ele.html(template);
				$compile(ele.contents())(scope);
			});
		}
	};
})
/**
 * Directiva lista qualificadores 
 */
//TODO colocar atributos variáveis para a lista ex: img,class icons ,etc..
.directive('listQualifier', [ '$http', function($http) {
	return {
		restrict: 'E',				  	    
		scope: {
			ngClickFn: '& onclick'
		},				    
		link:function(scope, element, attrs){
			$http.get(attrs.href)
			.success(function(data, status, headers, config) {
				scope.qualifiers = data;
				
				scope.$parent.categoryId = data[0].id;
				scope.$parent.qualifierValue = data[0].id;
			});		
			scope.setCategoryId=scope.$parent.setCategoryId;
			scope.$parent.$watch('categoryId', function() {
				scope.categoryId = scope.$parent.categoryId;
				scope.qualifierValue = scope.$parent.categoryId;
			}); 
			if (!attrs.countlabel) { 
				attrs.countlabel = 'Item(s)'; 
			}			
			scope.countLabel=attrs.countlabel;
		},	
		templateUrl: '/assets/_template/list-qualifier.html'
	};
}])
/**
 * Directiva lista qualificadores (segunda versão)
 */
.directive('listQualifiers', [ function() {
	return {
		restrict: 'C'		  	    
		, link:function(scope, element, attrs){
			if (!attrs.countlabel) { 
				attrs.countlabel = 'Item(s)'; 
			}			
			scope.countLabel=attrs.countlabel;
		}
		, templateUrl: '/assets/_template/list-qualifiers.html'
	};
}])
.directive('iservportMain', function(){
		return {
			restrict: 'EA',			
			template :'<div ng-include="iservportMainPath"></div>',
			controller: function($scope) {
				$scope.iservportMainPath = "/assets/"+$scope.baseName+"/selection-main.html";
			}

		}

})
.directive('iservportFilter', function(){
		return {
			restrict: 'EA',			
			template :'<div ng-include="iservportFilterPath"></div>',
			controller: function($scope) {
				$scope.iservportFilterPath = "/assets/"+$scope.baseName+"/selection-filter.html";
			}

		}

})
.directive('iservportProperties', function(){
		return {
			restrict: 'EA',			
			template :'<div ng-include="iservportPropertiesPath"></div>',
			controller: function($scope) {				
				$scope.iservportPropertiesPath = "/assets/"+$scope.baseName+"/selection-properties.html";
			}
		}

})
.directive('iservportInfo', function(){
	return {
		restrict: 'EA',			
		template :'<div ng-include="iservportInfoPath"></div>',
		controller: function($scope) {				
			$scope.iservportInfoPath = "/assets/"+$scope.baseName+"/info.html";
		}
	}

})

/**
 * Diretiva para recuperar entidade autorizada.
 */
.directive('authorizedEntity', [ '$http', function($http) {
		return {
			restrict: 'A',			
			link:function(scope, element, attrs) {
				$http.get('/entity')
				.success(function(data, status, headers, config) {
					scope.authorizedEntity = data;
				});		
			},
			template :'<div id="authorizedEntity">{{authorizedEntity.entityAlias.length>0?authorizedEntity.entityAlias:"UBIVIS"}}</div>'
		}

}])
/**
 * Diretiva para recuperar usuário autorizado.
 * 
 * Default : userKey 
 * 
 */
.directive('authorizedUser', [ '$http', function($http) {
		return {
			restrict: 'EA',
			link:function(scope, element, attrs) {
				$http.get('/entity/user')
				.success(function(data, status, headers, config) {
					
					scope.userLabel = data.userKey; 
					if(typeof attrs.typeName != 'undefined' && attrs.typeName.indexOf('name')>-1 ){
						scope.userLabel = data.userName;
					}else if(typeof attrs.typeName != 'undefined' && attrs.typeName.indexOf('display')>-1){
						scope.userLabel = data.displayName;
					}
					console.log(scope.userLabel);
				});		
			},
			template :'<div id="authorizedUser">{{userLabel}}</div>'
		}

}])
/**
 * Directiva para tratar erro de imagens.
 * from: http://plnkr.co/edit/KGvqfvKA5n979mu6BJT2?p=preview
 * Usage:<img src="URL" err-src="URL_DEFAULT">
 * 
 */
.directive('errSrc', function() {
	return {
		link: function(scope, element, attrs) {
			element.bind('error', function() {
				if (attrs.src != attrs.errSrc) {
					attrs.$set('src', attrs.errSrc);
				}
			});

			attrs.$observe('ngSrc', function(value) {
				if (!value && attrs.errSrc) {
					attrs.$set('src', attrs.errSrc);
				}
			});
		}
	}
})
/**
 * Diretiva para gráfico de estatísticas de treinamento.
 */
.directive('knldgStatsGraph', function(){
	function createChart(el_id, value) {
		var dataChart  = [];
		value.forEach(function(entry) {
			var labelName = '';
			switch (entry.baseClass) {
				case "1":
					labelName = "Treinar";
					break;
				case "2":
					labelName = "Acompanhar";
					break;
				case "3":
					labelName = "Treinado";
					break;
				case "4":
					labelName = "Pode treinar";
					break;
			} 
			var value = {value: entry.itemCount, label: labelName};
			dataChart.push(value);
		});
		var options = 
		{ 	  
			  element: el_id
			, data: dataChart
			, backgroundColor: '#ccc'
			, labelColor: '#155882'
			, colors: [ '#F89520', '#9AA6BF', '#7487A8', '#155882']
			, formatter: function (x) { return x }
		}
		var r = new Morris.Donut(options);
		return r;
	}
	return {
		restrict: 'EA',
		scope: {
			options: '='
		},
		replace: true,
		template: '<div></div>',
		link: function link(scope, element, attrs) {
			return createChart(attrs.id, scope.options);
		}
	};
})
.directive('paging', function() {
	return {
		restrict: 'EA',				  	    
		scope: {
			PreviousFn: '& previous',
			NextFn:'& next',
			nextAndPrevious : '=',
			pageList : '='
		},				    
		link:function(scope, element, attrs){
		},	
		templateUrl: '/assets/_template/pagination.html'
	};
})
;
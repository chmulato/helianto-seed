(function() {
    'use strict';

    /**
     * usage: <textarea ng-model="content" redactor></textarea>
     *
     *    additional options:
     *      redactor: hash (pass in a redactor options hash)
     *
     */    
    var redactorOptions = {
		buttons: ['html', 'formatting', 'bold', 'italic', 'deleted',
		          'unorderedlist', 'orderedlist', 'outdent', 'indent',
		          'image', 'file', 'link', 'alignment', 'horizontalrule']
		, uploadImageFields: {
	        '_csrf': '#_csrf',
	        'contentId': '#contentId'
	    }
    	, fileUpload:'/app/content'
		, uploadFileFields: {
	        '_csrf': '#_csrf',
	        'contentId': '#contentId'
	    }
		, fileUploadErrorCallback: function(json) {
			if(json.error){
				$('#errorMsg').html(json.errorMsg);
				$('#fileUploadError').fadeIn(2000);
			}
		}
		, imageUploadErrorCallback: function(json) {
			if(json.error){
				$('#errorMsg').html(json.errorMsg);
				$('#fileUploadError').fadeIn(2000);
			}	
		}
		, fileUploadCallback: function(link, json) {
			//success save do something
		}
	};

    angular.module('angular-redactor', [])
        .constant('redactorOptions', redactorOptions)
        .directive('redactor', ['$timeout', function($timeout) {
            return {
                restrict: 'A',
                require: 'ngModel',
                link: function(scope, element, attrs, ngModel) {

                    // Expose scope var with loaded state of Redactor
                    scope.redactorLoaded = false;
                   // console.log(attrs.itemId);
                   // redactorOptions.imageUpload =  redactorOptions.imageUpload + attrs.itemId;
                   // redactorOptions.fileUpload = redactorOptions.fileUpload + attrs.itemId;
                   //  console.log(redactorOptions.fileUpload);
                    var updateModel = function updateModel(value) {
                            // $timeout to avoid $digest collision
                            $timeout(function() {
                                scope.$apply(function() {
                                    ngModel.$setViewValue(value);
                                });
                            });
                        },
                        options = {
                            changeCallback: updateModel
                        },
                        additionalOptions = attrs.redactor ?
                            scope.$eval(attrs.redactor) : {},
                        editor,
                        $_element = angular.element(element);

                    angular.extend(options, redactorOptions, additionalOptions);

                    // prevent collision with the constant values on ChangeCallback
                    var changeCallback = additionalOptions.changeCallback || redactorOptions.changeCallback;
                    if (changeCallback) {
                        options.changeCallback = function(value) {
                            updateModel.call(this, value);
                            changeCallback.call(this, value);
                        }
                    }

                    // put in timeout to avoid $digest collision.  call render() to
                    // set the initial value.
                    $timeout(function() {
                        editor = $_element.redactor(options);
                        ngModel.$render();
                    });

                    ngModel.$render = function() {
                        if(angular.isDefined(editor)) {
                            $timeout(function() {
                                $_element.redactor('code.set', ngModel.$viewValue || '');
                                $_element.redactor('placeholder.toggle');
                                scope.redactorLoaded = true;
                            });
                        }
                    };
                }
            };
        }]);
})();


[#ftl]
<!DOCTYPE html >
<html id="ng-app" xmlns:ng="http://angularjs.org" 
    data-ng-app="${baseName}" 
    data-ng-controller="ViewController as ViewCtrl" 
    data-ng-cloak>

<head>
    <meta content="text/html; iso-8859-1" http-equiv="content-type">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	
    <!-- Styles -->
	<!-- Bootstrap style -->
	<link rel='stylesheet' href='/webjars/bootstrap/3.3.2/css/bootstrap.min.css'>
	<!-- Slim Style -->
	<link rel='stylesheet' href='/css/slim-main-1.3.css'>
	<link rel='stylesheet' href='/css/slim-ui-1.3.css'>
	<!-- Loading bar -->
	<link rel='stylesheet' href='/webjars/angular-loading-bar/0.7.1/loading-bar.min.css'>
	<!-- Morris style -->
	<link rel="stylesheet" href="/webjars/morrisjs/0.5.0/morris.css">
	<!-- font-awesome -->
	<link rel='stylesheet' href="/webjars/font-awesome/4.3.0/css/font-awesome.css">
	<!-- font-ionicons -->
	<link rel='stylesheet' href="/webjars/ionicons/1.5.2/css/ionicons.min.css">
	<!-- font-foundation -->
	<link rel='stylesheet' href="/webjars/foundation-icon-fonts/d596a3cfb3/foundation-icons.css">
	<!--[if lte IE 7]>
		<script src="/webjars/json3/3.3.2/json3.min.js"></script>
	<![endif]-->
	<!-- Redactor -->
    <link rel="stylesheet" href="/redactor/redactor.css" />
	<!-- iservport css extension -->
	<link rel='stylesheet' href='/css/iservport.css'>
	
	
    <!-- Javascript -->
    <!-- JQuery -->
	<script type="text/javascript" src="/webjars/jquery/2.1.1/jquery.min.js"></script>
	<!-- Bootstrap package -->
	<script type="text/javascript" src="/webjars/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<!-- Knob -->
	<script type="text/javascript" src="/webjars/jquery-knob/1.2.2/jquery.knob.min.js"></script>
	<!-- Morris -->
	<script src="/webjars/raphaeljs/2.1.2/raphael-min.js"></script>
	<script src="/webjars/morrisjs/0.5.0/morris.min.js"></script>
    <!-- CK Editor -->
    <!-- script type="text/javascript" src="/webjars/ckeditor/4.4.1/ckeditor.js"> </script-->
    <!-- Js padrão
    <script type="text/javascript" src='/js/defaut.js'></script>-->
    <link rel="localization"  href="/locales/manifest.json">
     <!-- Redactor -->
    <script src="/redactor/redactor.min.js"></script>
	<script type="text/javascript" src="/assets/angular-redactor.js"> </script>
    <!-- i18n para menu -->
    <script type="text/javascript">var externalId = ${externalId!0};</script>
	<link type="image/x-icon" href="/images/favicon.ico" rel="shortcut icon">
	<link type="image/x-icon" href="/images/favicon.ico" rel="icon">

    <title>${title!''}</title>
	<meta name="_csrf" content="${_csrf.token}"/>
    <!-- default header name is X-CSRF-TOKEN -->
    <meta name="_csrf_header" content="${_csrf.headerName}"/>

</head>
<body id="app" 
	data-ng-controller="${baseName?capitalize}Controller as ${baseName}Ctrl"
	class="app ng-animate">
	
	<!-- 
	 ! Linha superior.
	 ! -->
	<section id="header" 
		class="header-container header-fixed bg-dark" >
		[#include "/_top.html" /]
	</section>
	
	<!-- 
	 ! Conteúdo principal
	 ! -->
	<div class="main-container" >
	
	    <aside id="nav-container" 
	    	class="nav-container nav-fixed nav-vertical bg-white">
	    	[#include "/_menu.html" /]
	    </aside>

	    <div id="content" class="content-container">
	    <section class="view-container animate-fade-up">
		<div class="page page-dashboard" >
	    	<div class="row">
	    	<div data-iservport-title  class="col-md-12"></div><!-- title -->
	     	</div>
	    	<div class="row" data-ng-include="'/assets/${baseName}/selection-${baseName}.html'"></div>
	    	</div>
	    	
	    	
		</div><!-- end of page -->
	    <div id="info" class="panel panel-default">
			<div class="panel-body" data-iservport-info ></div><!-- info -->
		</div><!-- panel -->
		
		</section>
	    </div><!--content-->
		</div><!--main-container-->
	
	<!--
	 ! Modal mostrado quando o modelo exibe modalBody.
	 !-->
	<div class="modal fade" id="modalBody" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
	   	<div class="modal-content">
	    	<div data-ng-include="getFormUrl()" ></div>
		</div>
		
		</div><!-- modal-dialog -->
	</div><!-- modal-fade -->	
	
	<!-- AngularJs package -->
	<script type="text/javascript" src="/webjars/angularjs/1.3.1/angular.min.js"></script>
	<script type="text/javascript" src="/webjars/angularjs/1.3.1/angular-sanitize.min.js"></script>
	<script type="text/javascript" src="/webjars/angularjs/1.3.1/angular-resource.js"></script>
	<script type="text/javascript" src="/webjars/angularjs/1.3.1/angular-route.min.js"></script>
	<script type="text/javascript" src="/webjars/angularjs/1.3.1/angular-cookies.min.js"></script>
	<script type="text/javascript" src="/webjars/angularjs/1.3.1/angular-animate.min.js"></script>
	<script type="text/javascript" src="/webjars/angular-ui-bootstrap/0.11.2/ui-bootstrap-tpls.js"></script>
	<script type="text/javascript" src="/webjars/angular-ui-utils/0.1.1/ui-utils.min.js"></script>
    <!-- Redactor -->
    <script src="/redactor/redactor.min.js"></script>
	<script type="text/javascript" src="/assets/angular-redactor.js"> </script>
    <!-- Services to apps-->
	<script type="text/javascript" src="/assets/services.js"></script>
	<script type="text/javascript" src="/assets/${baseName}/ng-${baseName}-module.js"></script>
	[#if customControllerBody??]
	<script type="text/javascript" >
		var app = angular.module(${baseName});
		app.controller('CustomController', ['$scope', '$http','$resource', 'genericServices', 'securityServices', 'commomLang', 'controllerLang'
                                       , function($scope, $http, $resource, genericServices, securityServices, commomLang, contentLocale) {
			${customControllerBody}
        }
	</script>
	[/#if]
	<input type="hidden" id="_csrf" name="${_csrf.parameterName}" value="${_csrf.token}" />
	

</body>

</html>
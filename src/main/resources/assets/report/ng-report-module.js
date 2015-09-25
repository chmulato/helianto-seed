(function() {
	app = angular.module('report', ['ui.bootstrap', 'app.layout', 'app.services', 'ngResource', 'ngSanitize', 'angular-loading-bar', 'angular-redactor', 'ui.bootstrap.accordion'])
	/**
	 * Recursos de relatórios
	 */
	.factory('resources', ['$resource', function($resource) {
		var service = {};
		service.qualifierResource = $resource("/api/report/project/qualifier");
		service.resource = $resource("/api/report/:method"
			, {folderId : "@folderId"}
			, { save: { method: 'PUT'}, create: {method: 'POST' }, remove:{method:'DELETE'}});
		return service;
	}])
	/**
	 * Controlador de relatórios.
	 */
	.controller('ReportController', ['$scope', '$window', '$http', 'resources', 'qualifierService', 'lang', '$log'
	                                  , function($scope, $window, $http, resources, qualifierService, lang, $log) {
		
		
		/*
		 * initializers
		 */
		var baseUrl = '/app/report/';
		$scope.externalId = (externalId==null || externalId=='undefined')?0:externalId;
		$scope.menuName = "control";		
		$scope.baseName="report";
		$scope.customTemplate = "<p>sem Script</p>";
		$scope.reportResolution = 'T';
		$scope.reportAll = true;
		$scope.report = [];			
		$scope.qualifiers = [];
		//uasado para verificar se é uma pesquisa ou nao
		$scope.searchBool = false; 
		$scope.message ={"categoryExists":true};
		$scope.date = new Date();

		$scope.dateNow = new Date(); 
		$scope.reportFolder ={"numberOfDigits":3};
		$scope.report={"relativeSize": 0,"priority":0, "frequency":0};
		
		$scope.categoryList = [];
		//usado para paginação
		$scope.nextAndPrevious = [];
		$scope.page = 0;
		$scope.pageFolder  = 0;
		var sectionTab = 1;
		$scope.categoryId = 0;
		$scope.aggregate = 0;
		$scope.qualifierType = 1;
		$scope.typeOfReviewBar = 'success';

		$scope.reportSection = -1;
		$scope.setReportSection = function(value){
			$scope.reportSection = value;
		}

		$scope.isReportSection = function(value){
			return $scope.reportSection === value;
		};
		
		/**
		 * Qualifier
		 */
		$scope.setQualifier = function(value, data) {
			if (Array.isArray(data)) {
				$scope.qualifiers = data;
			}
			$scope.qualifierValue = value;
			$scope.reportFolderValue = 0;
			$scope.listReportFolders(value);
		}
		qualifierService.run(resources.qualifierResource, $scope.setQualifier, 0);
		
		
		/**
		 * Report folders.
		 */
		$scope.folderValue = 0;
		$scope.listReportFolders = function(reportCategory) {
			$scope.report = {"id":-1};
			resources.resource.get({method:'project', qualifierValue:reportCategory}).$promise.then(
			function(data) {
				$scope.reportFolders = data;
				if (data.content.length>0 && $scope.externalId==0) {
					if($scope.folderValue==0) {
						$scope.reportFolder = data.content[0];
					}
					$scope.setReportFolder($scope.reportFolder);
				}
			})
		};
		$scope.getReportFolder = function(id) {
			resources.resource.get({method:'project', projectId: id}).$promise.then(
			function(data) {
				$scope.reportFolder = data;
			});
		};
		$scope.setReportFolder = function(reportFolder) {
			$scope.folderValue = reportFolder.id;
			$scope.listReports($scope.folderValue);
			$scope.listReportPhases($scope.folderValue);
			$scope.listStaffMembers($scope.folderValue);
		};
		$scope.newReportFolder = function() {
			resources.resource.create({method:'project', qualifierValue:$scope.qualifierValue}, null).$promise.then(
			function(data) {
				$scope.reportFolder = data;
				$scope.openForm('report-folder');
			});
		};
		$scope.updateReportFolder = function() {
			resources.resource.save({method:'project'}, $scope.reportFolder).$promise.then(
			function(data, getReponseHeaders) {
				$scope.reportFolder = data;
				$scope.listReportFolders($scope.qualifierValue);
				$scope.setReportFolder(data);
				$("#modalBody").modal('hide');
			});
		};
		/**
		 * Controle de exibição de textos do projeto
		 */
		$scope.projectSection = 0;
		$scope.setProjectSection = function(value) {
			$scope.projectSection = value;
		};
		$scope.isProjectSection = function(value) {
			return (value == $scope.projectSection);
		};
		/**
		 * Exports
		 */
		$scope.entitiesIds = [];
		$scope.exportFolder = function(){
			resources.resource.get({method:'export', reportFolderId:$scope.reportFolder.id}).$promise.then(
			function(data, getReponseHeaders) {
				$scope.entityList = data;
			});
			resources.resource.get({method:'export', reportFolderId:$scope.reportFolder.id, selected:true}).$promise.then(
			function(data, getReponseHeaders) {
				$scope.entityListExported = data;
			});
			$scope.openForm('form-folder-export');
		}
		$scope.isExported = function(targetId){
			return false; //$scope.authorizedEntity.id != targetId;
		}
		$scope.saveExport = function(){
			$scope.entitiesIds = [];
			resources.resource.save({method:'export', reportFolderId:$scope.reportFolder.id, entitiesIds:$scope.entitiesIds}, null).$promise.then(
			function(data, getReponseHeaders) {
				$("#modalBody").modal('hide');
				$scope.entityListExported = data;
			});
		}
		/**
		 * Método usado para inserir ou retirar valores de um array.
		 * 
		 * Uso com checkBox: <input data-ng-click="toggleSelection(idToAdd)"  type="checkbox" id="item-" name="{{idToAdd}}" > 
		 */
		$scope.toggleSelection = function toggleSelection(id) {
			var idx = $scope.entitiesIds.indexOf(id);
			if (idx > -1) {
				$scope.entitiesIds.splice(idx, 1);
			}
			else {
				$scope.entitiesIds.push(id);
			}
		};
		$scope.isProjectLate = function(project) {
			return project.resolution!='DONE' && new Date().getDate() > new Date(project.endDate).getDate();
		}
		
		/**
		 * Ações
		 */
		// search
		
		$scope.search = false;
		$scope.isSearch = function(){
			return $scope.search;
		}
		$scope.setSearch = function(val){
			$scope.search = val;
		}
		$scope.searchFilterVar=1;
		$scope.searchFilter = function(value){
			$scope.searchFilterVar= value;
		}
		
		$scope.searchReport = function(searchForm, page) {
			if(searchForm==null || searchForm=='undefined'){
				searchForm = {};	
			}
			if($scope.searchFilterVar!=1){
				searchForm.qualifierValue = $scope.folderValue;
			}else{
				searchForm.qualifierValue = 0;
			}	
			searchForm.pageNumber = page;
			searchForm.qualifierValueString = $scope.qualifierValue;
			console.log(searchForm);
			console.log(page);
			// resource search
			resources.resource.search({method:'search'}, searchForm).$promise.then(function(data) {
				$scope.reportSearchList = data;
				$("#searchString").val("");
				//$scope.searchBool = true;
				$scope.page = page;
				console.log(data);
				if(data.totalElements == 1){
					$scope.report = data.content[0];
				}
				else if(data.totalElements>1){
					$scope.reportSearchList = data;	
					openForm('form-search');
				}else{
					$("#searchMsg").fadeIn(1000);
					$("#searchMsg").fadeOut(5000);
					$("#searchMsg2").fadeIn(1000);
					$("#searchMsg2").fadeOut(5000);
					$scope.reportSearchList = [];
				}
			})    
		};
		
		$scope.phaseLiterals = [];
		$scope.toggleSelectionPhase = function(id) {
			var idx = $scope.phaseLiterals.indexOf(id);
			if (idx > -1) {
				$scope.phaseLiterals.splice(idx, 1);
			}
			else {
				$scope.phaseLiterals.push(id);
			}
			console.log($scope.phaseLiterals);
		};
		
		$scope.phaseLiteralsContains= function(literal){
			return $scope.phaseLiterals.indexOf(literal)>-1?true:false;
		};
		
		/**
		 * Reports
		 */
		$scope.reportFolder= {};
		if($scope.externalId>0){
			$scope.getReport($scope.externalId,null, true);
		}
		$scope.setExternalId = function(val){
			$scope.externalId = val ;
		}
		$scope.listReports = function(folderValue, page, isFilter) {
			$scope.folderValue = folderValue;
			//zera os reports
			if($scope.externalId==0){
				$scope.report = {"id":-1};
			}
			if(!isFilter){
				$scope.getReportFolder(folderValue);
			}
			resources.resource.get({folderId:folderValue, pageNumber: page, phases:$scope.phaseLiterals}).$promise.then(function(data) {
				$scope.reportList = data;
				if (angular.isDefined(data.content) && data.content.length>1) {
					$scope.reports = data.content;
				}
			})
		};
		$scope.getReport = function(idVal, sectionVal, retrieveCascade, openForm) {
			if(retrieveCascade==null || retrieveCascade=='undefined'){
				retrieveCascade=false;
			}
			resources.resource.get({id: idVal}).$promise.then(
			function(data) {
				$scope.report = data;
				if(data.id>0 ){
					$scope.getReporter(data.identityId);
					$scope.getCategory(data.categoryId);
					if(openForm){
						$scope.openForm('report');	
					}
					if(retrieveCascade){
						$scope.listReports(data.reportPlanFolderId);
						$scope.reportFolder = $scope.reportFolderResource.get({folderId: data.reportFolderId});
						$scope.reportFolder.$promise.then(function(data) {
							$scope.listReportFolders(data.categoryId);
						});
					}
				}
			});
		};
		$scope.getReporter = function(reportId) {
			resources.resource.get({reportId: reportId}).$promise.then(function(data) {
				$scope.report.identityId = data.reporterId;
			});
		};
		$scope.getCategory = function(reportId) {
//			$scope.categoryResource.get({categoryId: data.categoryId}).$promise.then(
//			function(data) {
//				$scope.reportCategory = data;
//				if(data.id>0 ){
//					//TODO verify
//					//$scope.customProperties = JSON.parse(data.customProperties);
//				}
//			});
		};
		$scope.newReport = function(folderValue) {
			$scope.report = resources.resource.create({folderId:folderValue});
			$scope.openForm('report');
		};
		$scope.updateReport = function() {
			$scope.report = resources.resource.save($scope.report).$promise.then(
			function(data, getReponseHeaders) {
				$scope.listReports($scope.folderValue);
				$scope.getReport(data.id, 1);
				$("#modalBody").modal('hide');	
			});
		}
		
		/**
		 * Report phase
		 */
		$scope.listReportPhases = function(folderValue) {
			$scope.folderValue = folderValue;
			resources.resource.query({method:'phase', folderId:folderValue}).$promise.then(
			function(data) {
				$scope.reportPhaseList = data;
				$scope.reportPhases = data;
				$scope.phaseLiterals = [];
				$scope.reportPhases.forEach(function(entry) {
					if ($scope.phaseLiterals.indexOf(entry.literal) == -1) {
						$scope.phaseLiterals.push(entry.literal);
				    }
				});
			})
		};
		$scope.getReportPhase = function(idVal, sectionVal, retrieveCascade) {
			resources.resource.get({method:'phase', id: idVal}).$promise().then(
			function(data) {
				$scope.reportPhase = data;
				$scope.setReportPhase(data);
			});
		};
		$scope.setReportPhase = function(reportPhase) {
		};
		$scope.newReportPhase = function(folderValue) {
			resources.resource.create({method:'phase', folderId:folderValue}, null).$promise().then(
			function(data) {
				$scope.reportPhase = data;
				$scope.setReportPhase(data);
				$scope.openForm('report-phase');
			});
		};
		$scope.updateReportPhase = function() {
			resources.resource.save({method:'phase'}, $scope.reportPhase).$promise.then(
			function(data, getReponseHeaders) {
				$scope.reportPhase =  data;
				$scope.setReportPhase(data);
				$("#modalBody").modal('hide');	
			});
		};
		$scope.openReportPhase = function(id){
			$scope.getReportPhase(id);
			$scope.openForm('report-phase');
		}
	
		/**
		 * Staff members.
		 */
		$scope.staffMember={};
		
		$scope.folderId =0;
		$scope.listStaffMembers = function(folderId) {
			$scope.folderId = folderId;
			resources.resource.get({method:'staff', folderId: folderId}).$promise.then(
			function(data) {
				$scope.staffMemberList = data;
				$scope.staffMembers = data.content;
			});
		};
		$scope.getStaffMember = function(staffMemberId) {
			$scope.message= [];
			resources.resource.get({method:'staff', staffMemberId: staffMemberId}).$promise.then(
			function(data) {
				$scope.staffMember = data;
				$scope.setStaffMember(data);
			});
		};
		$scope.setStaffMember = function(staffMember) {
		};
		$scope.newStaffMember = function(identityId) {
			resources.resource.create({method:'staff', folderId: $scope.folderValue}, null).$promise.then(
			function(data) {
				$scope.staffMember = data;
				$scope.setStaffMember(data);
				
//				$scope.staffMember = data;
				console.log($scope.staffMember);
				console.log(identityId);
				$scope.staffMember.identityId = identityId;
				console.log($scope.staffMember);
//				$scope.updateStaffMember();
				$scope.valueOnTypeAhead = "";
				$scope.identityMember = {"userId" : -1};
				$scope.updateStaffMember();
//				$scope.openForm('staff-member');
			});
		};
		$scope.updateStaffMember = function() {
			resources.resource.save({method:'staff'}, $scope.staffMember).$promise.then(
			function(data, getReponseHeaders) {
				$scope.staffMember = data;
				$("#modalBody").modal('hide');
			});
		};
		$scope.memberToDelete = function(staffMember) {	
			$scope.message=[];
			$scope.memberToDelete = staffMember;
		};
		$scope.deleteMember = function(id) {
			resources.resource.remove({method:'staff', targetId: id}).$promise.then(
			function(data) {
				$("#deleteStaffModal").modal('hide');
				$scope.listStaffMembers($scope.folderValue);
			});
			$scope.memberToDelete = {};
		};
		/**
		 * Chamada de pesquisa de usuário para typeAhead
		 */		
		$scope.searchRemainingUsers = function(searchUser){
			return $scope.userList = resources.resource.query({method:'staff', searchUser:searchUser, searchFolderId: $scope.folderValue})
			.$promise.then(function(response) {
				var items = response.map(function(e) {
					if(e.userName==null || e.userName.length <=0){
						e.userName=e.userKey;
					}
					return e;
				});
				return items;
			});
		}
		$scope.onSelect = function ($item, $model, $label) {
			$scope.identityMember  = $item;
		};
		
		/**
		 * Users.
		 */
		$scope.users = function(){
			$scope.userList = resources.resource.query({method:'staff', users: true});
		}
		$scope.users();
		
		$scope.getUser = function(id){
			return resources.resource.get({method:'staff', users: true, userId: id});
		}
		$scope.identityMember = {"userId" : -1};
		
		$scope.showStaffAddButton = function() {
			return ($scope.identityMember.identityId>0 );
		};
		$scope.confirmStaffMember = function(identityId){
			$scope.newStaffMember().$promise.then(function(data) {
				$scope.staffMember = data;
				console.log($scope.staffMember);
				console.log(identityId);
				$scope.staffMember.identityId = identityId;
				console.log($scope.staffMember);
				$scope.updateStaffMember();
				$scope.valueOnTypeAhead = "";
				$scope.identityMember = {"userId" : -1};
			});
			
		}
		
		/**
		 * Review
		 */
		$scope.review={'progress':0};
		$scope.reportId =0;
		$scope.listReviews = function(reportId) {
			$scope.reportId = reportId;
			resources.resource.query({method:'review', reportId: reportId}).$promise.then(
			function(data) {
				$scope.reviews = data;
				if (data.length===1) {
				}
			});
		};
		$scope.getReview = function(id) {
			resources.resource.get({method:'review', reportReviewId: id}).$promise.then(
			function(data) {
				$scope.review = data;
				$scope.openForm('form-report-review');
			});
		};
		$scope.newReview = function() {
			resources.resource.create({method:'review', reportId: $scope.reportId}, null).$promise.then(
			function(data) {
				$scope.review = data;
				$scope.openForm('form-report-review');
			});
		};
		$scope.updateReview = function() {
			$scope.review = resources.resource.save({method:'review'}, $scope.review).$promise.then(
			function(data, getReponseHeaders) {
				$scope.listReviews(data.reportId);
				$scope.reportResource.get({id: data.reportId}).$promise.then(function(data){
					$scope.listReports(data.reportFolderId);
					$scope.setSectionTab(1);
				});
				$("#modalBody").modal('hide');
			});
		};
		$scope.$watch('review.workflowLevel', function () { 
			$scope.typeOfReviewBar = $scope.getTypeOfReviewBar($scope.review.workflowLevel);
		}, true);
		$scope.getTypeOfReviewBar = function (value){
			if (value < 25) {
				return  'danger';
			} else if (value  < 50) {
				return  'warning';
			} else if (value  < 75) {
				return  'info';
			} else {
				return  'success';
			}	
		}

		/**
		 * Participants.
		 */
		$scope.participant={};
		$scope.reportId =0;
		$scope.listParticipants = function(reportId) {
			$scope.reportId = reportId;
			resources.resource.query({method:'participant', reportId: reportId}).$promise.then(
			function(data) {
				$scope.participants = data;
				if (data.length===1) {
				}
			});
		};
		$scope.getParticipant = function(id) {
			$scope.message= [];
			resources.resource.getParticipant({method:'participant', participantId: id}).$promise.then(
			function(data) {
				$scope.participant = data;
				$scope.setParticipant(data);
			});
		};
		$scope.setParticipant = function(participant) {
		};
		$scope.newParticipant = function() {
			resources.resource.newParticipant({method:'participant', reportId: $scope.reportId}, null).$promise.then(
			function(data) {
				$scope.participant = data;
				$scope.setParticipant(data);
			});
		};
		$scope.updateParticipant = function() {
			resources.resource.save({method:'participant'}, $scope.participant).$promise.then(
			function(data, getReponseHeaders) {
				$scope.participant = data;
				$scope.setParticipant(data);
				$("#modalBody").modal('hide');
			});
		};

		
		/**
		 * FollowUps.
		 */
		$scope.followUp={};
		$scope.reportId =0;
		$scope.listFollowUps = function(reportId) {
			$scope.reportId = reportId;
			resources.resource.query({method:'followUp', reportId: reportId}).$promise.then(
			function(data) {
				$scope.followUps = data;
				if (data.length===1) {
				}
			});
		};
		$scope.getFollowUp = function(followUpId) {
			$scope.message= [];
			resources.resource.get({method:'followUp', followUpId: followUpId}).$promise.then(
			function(data) {
				$scope.followUp = data;
				$scope.setFollowUp(data);
			});
		};
		$scope.setFollowUp = function(followUp) {
		};
		$scope.newFollowUp = function() {
			resources.resource.create({method:'followUp', reportId: $scope.reportId}, null).$promise.then(
			function(data) {
				$scope.followUp = data;
				$scope.setFollowUp(data);
			});
		};
		$scope.updateFollowUp = function() {
			resources.resource.save({method:'followUp'}, $scope.followUp).$promise.then(
			function(data, getReponseHeaders) {
				$scope.followUp = data;
				$("#modalBody").modal('hide');
			});
		};

		$scope.getFavouriteIcon = function() {
			return $scope.favouriteIcon;
		}
		$scope.setFavouriteId = function(favouriteId) {
			$scope.favouriteId = favouriteId;
		}

		/**
		 * Retorna o form a ser mostrado no Modal
		 */
		$scope.getFormUrl = function(){
			return $scope.formUrl;
		} 

		$scope.setSearch  = function(value) {
			$scope.searchBool = value;
		};
		$scope.isSearch = function() {
			return $scope.searchBool;
		};		
		
		$scope.open = function($event,value) {
			$event.preventDefault();
			$event.stopPropagation();
			$scope.datePicker = [];
			$scope.datePicker[value]=true;
		};
		
		
		// Códigos testes Raphael
		// Abrir Formulario
		
			$scope.openReportReview = function(id){
			//$scope.getReportMonitoramento(id);
			$scope.openForm('form-report-review');
			
		}
		
		/**
		 * Abre um modal.
		 * 
		 * @param formName Nome do Fragmento (form-YYYY)
		 * 
		 */
		$scope.openForm = function(formName){
			$scope.message =[];
			//inicialização em form-report
			$scope.createPart = false;
			$('#save-report input[type="text"]').removeAttr('readonly').val('');
			
			$scope.formUrl = '/assets/report/form/'+formName+'.html';
			$("#modalBody").modal('show');
			}
			
	}])
	;

})();

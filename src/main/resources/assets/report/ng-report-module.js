(function() {
	app = angular.module('report', ['ui.bootstrap', 'app.services','angular-redactor' ,'ngResource']);
//		return {
//			restrict: 'E',
//			templateUrl:'/assets/report/selection-main.html',
//		}
//
//	})
	app.controller('ReportController', ['$scope', '$window', '$http', '$resource' , 'genericServices', 'securityServices'
	                              	                                  , function($scope, $window, $http, $resource, genericServices, securityServices) {
	
		securityServices.getCategoryMap();
		$scope.showMenuItem =  function(code){
			return securityServices.showMenuItem(code);
		}
		$scope.isAuthorized = function(role, ext){
			return securityServices.isAuthorized(role, ext);
		}
		$scope.logout = function(){
			return securityServices.logout();
		}
		$http.get('/app/home/entity').success(function(data, status, headers, config) {
			return 	$scope.authorizedEntity = data;
		})
		
		/*
		 * Recursos
		 */
		var baseUrl = '/api/report/';
		$scope.qualifierResource = $resource("/api/category/qualifier");
		$scope.categoryResource = $resource("/api/category/", { categoryId:"@categoryId" });
		$scope.qualifierResource = $resource(baseUrl + "qualifier");
		$scope.reportFolderResource = $resource(baseUrl + "folder", { qualifierValue:"@qualifierValue",folderId:"@folderId"}, {
			save: { method: 'PUT' },
			create: { method: 'POST' }
		});
		$scope.reportFolderExportResource = $resource(baseUrl + "folder/export", { reportFolderId:"@reportFolderId", entitiesIds:"@entitiesIds" }, {
			save: { method: 'PUT' },
			exportFolder: { method: 'POST' }
		});
		$scope.searchResource= $resource(baseUrl+'search', null, {
			search:{ method: 'POST', isArray: false }});
		$scope.reportResource = $resource(baseUrl , { folderId:"@folderId", reportId:"@reportId"}, {
			save: { method: 'PUT' },
			create: { method: 'POST' },
		});
		$scope.reportPhaseResource = $resource(baseUrl+"phase" , { folderId:"@folderId"}, {
			save: { method: 'PUT' },
			create: { method: 'POST' },
		});
		$scope.staffMemberResource = $resource(baseUrl + "staffMember" ,{search:"@search", searchFolderId:"@searchFolderId", staffMemberId:"@staffMemberId", folderId:"@folderId", users:"@users", userId:"@userId", targetId:"@targetId"}, {
			save: { method: 'PUT'},
			newStaffMember:{method: 'POST'}
		});
		$scope.reviewResource = $resource(baseUrl + "review" ,{reportId:"@reportId"}, {
			save: { method: 'PUT'},
			newReview:{method: 'POST'},
			getReview:{method: 'GET', isArray:false},
			query:{method: 'GET', isArray:false}
		});
		$scope.participantResource = $resource(baseUrl + "participant" ,{reportId:"@reportId"}, {
			save: { method: 'PUT'},
			newParticipant:{method: 'POST'},
			getParticipant:{method: 'GET', isArray:false},
			query:{method: 'GET', isArray:false}
		});
		$scope.followUpResource = $resource(baseUrl + "followUp" ,{reportId:"@reportId"}, {
			save: { method: 'PUT'},
			newFollowUp:{method: 'POST'},
			getFollowUp:{method: 'GET', isArray:false},
			query:{method: 'GET', isArray:false}
		});
		$scope.reportReviewResource = $resource(baseUrl+"review" , { reportId:"@reportId"}, {
			save: { method: 'PUT' },
			create: { method: 'POST' },
		});	
		
		/*
		 * FIM Recursos
		 */
		
		
		
		/*
		 * initializers
		 */
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
		//retorna a url pra mostrar no modal
		$scope.formUrl = '/assets/report/form-report.html';

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
			
			$scope.formUrl = '/assets/report/'+formName+'.html';
			$("#modalBody").modal('show');
		}
		
		
		/*
		 * end Initializers
		 * 
		 */
		
		$scope.sectionTab = 0;
		$scope.setSectionTab = function(value) {
			$scope.sectionTab = value;
		};
		$scope.isSectionTabSet = function(value) {
			return $scope.sectionTab === value;
		};

		/*
		 * Ajax get's
		 */
		
		/**
		 * Qualifier = tipo de report
		 */
		$scope.qualifierValue = 0;
		$scope.listQualifiers = function() {
			$scope.qualifiers = $scope.qualifierResource.query();
			$scope.qualifiers.$promise.then(function(data) {
				console
				if ($scope.qualifierValue === 0 && data.length>0 && $scope.externalId==0) {
					$scope.setQualifier($scope.qualifiers[0]);
				}
			})
		};
		$scope.setQualifier = function(qualifierItem) {
			$scope.sectionTab = -1;
			$scope.qualifier = qualifierItem;
			$scope.qualifierValue = qualifierItem.qualifierValue;
			$scope.qualifierName = qualifierItem.qualifierName;
			$scope.reportFolders = [];
			$scope.reportList = [];
			$scope.listReportFolders(qualifierItem.qualifierValue);
		}
		$scope.listQualifiers();

		$scope.reportSection = -1;
		$scope.setReportSection = function(value){
			$scope.reportSection = value;
		}

		$scope.isReportSection = function(value){
			return $scope.reportSection === value;
		};
		
		/**
		 * Pastas.
		 */
		$scope.folderValue = 0;
		$scope.reportFolder= {};
		
		/**
		 * Exportação
		 */
		
		//abre o modal para exportação e lista entidades à exportar e já exportadas.
		$scope.exportFolder = function(){
			$scope.entityList = $scope.reportFolderExportResource.get({reportFolderId:$scope.reportFolder.id});
			$scope.entityListExported = $scope.reportFolderExportResource.get({reportFolderId:$scope.reportFolder.id, selected:true});
			$scope.openForm('form-folder-export');
		}
		
//		//verifica se o item é pertencente a outra unidade.
//		$scope.isExported = function(targetId){
//			return $scope.authorizedEntity.id != targetId;
//		}
		
		$scope.entitiesIds = [];
		/**
		 * Método usado para inserir ou retirar valores de um array.
		 * 
		 * Uso com checkBox: <input data-ng-click="toggleSelection(idToAdd)"  type="checkbox" id="item-" name="{{idToAdd}}" > 
		 * 
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
		//salva exportação
		$scope.saveExport = function(){
			$scope.save =  $scope.reportFolderExportResource.exportFolder({reportFolderId:$scope.reportFolder.id,entitiesIds:$scope.entitiesIds});
			$scope.entitiesIds = [];
			$("#modalBody").modal('hide');
		}
		
		//end export
		
		$scope.setSection= function(val){
			$scope.section = val;
			$scope.qualifierValue = val;
		}
		
		$scope.listReportFolders = function(reportCategory) {
			$scope.setSection(reportCategory);
			$scope.reportFolderList = $scope.reportFolderResource.get({qualifierValue:reportCategory});
			$scope.reportFolderList.$promise.then(function(data) {
				if (data.content.length>0) {
					$scope.setSectionTab(-1);
					$scope.reportFolders = data.content;
					if($scope.externalId==0){	
						$scope.folderValue = data.content[0].id;
						if($scope.folderValue>0 ){
							$scope.listReports($scope.folderValue);
						}
					}
				}else{
					$scope.reportFolder = null;
					$scope.reportFolders = [];
					$scope.reports = [];
					$scope.report = {"id":-1};
				}
			})
		};

		$scope.newReportFolder = function() {
			$scope.reportFolder = $scope.reportFolderResource.create({qualifierValue:$scope.qualifierValue});
			$scope.openForm('form-report-folder');
		};
		$scope.getReportFolder = function(id) {
			$scope.reportFolder = $scope.reportFolderResource.get({folderId: id});
			$scope.reportFolder.$promise.then(function(data) {
				 $scope.folderValue = data.id;
				 $scope.listReportPhases($scope.folderValue);
				 $scope.listStaffMembers($scope.folderValue);
			});
		};
		$scope.updateReportFolder = function() {
			console.log($scope.reportFolder);

			$scope.reportFolder = $scope.reportFolderResource.save($scope.reportFolder);
			$scope.reportFolder.$promise.then(
					function(data, getReponseHeaders) {
						$scope.listReportFolders($scope.qualifierValue);
						$scope.listReports(data.id);
						$("#modalBody").modal('hide');
					},
					function(data, getReponseHeaders) {
						console.log(data);
						if(data.status === 302) {
							$scope.message= data.data;
							$scope.message.exist = true;
						}
					}
			);
		};

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
			$scope.reportSearchList = $scope.searchResource.search(searchForm);
			$("#searchString").val("");
			$scope.reportSearchList.$promise.then(function(data) {
				//$scope.searchBool = true;
				$scope.page = page;
				$scope.nextAndPrevious = genericServices.getNextAndPreviousLinkByList(data);
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
		
		//list
		$scope.listReports = function(folderValue, page, isFilter) {
			$scope.folderValue = folderValue;
			//posiciona na aba pasta e zera os reports
			if($scope.externalId==0){
//				$scope.reportSection = 0 ;	
				$scope.report = {"id":-1};
			}
			
			if(!isFilter){
				$scope.getReportFolder(folderValue);
			}
			$scope.reportList = $scope.reportResource.get({folderId:folderValue, pageNumber: page, phases:$scope.phaseLiterals});
			$scope.reportList.$promise.then(function(data) {
				$scope.nextAndPrevious = genericServices.getNextAndPreviousLinkByList(data);
				if (data.content.length>1) {
					$scope.setSectionTab(0);
					$scope.reports = data.content;
				}else if(data.totalPages == 1 && data.totalElements == 1 && data.numberOfElements == 1){
					$scope.report = data.content[0];
				}
			})
		};

		//getOne
		$scope.getReport = function(idVal, sectionVal, retrieveCascade, openForm) {
			$scope.reportNotExists = false;
			$scope.showReportList = false;
			$scope.showReportFolderList = false;
			
			$scope.report = $scope.reportResource.get({id: idVal});
			if(sectionVal==null || sectionVal=='undefined'){
				sectionVal=0;
			}
			$scope.reportSection = sectionVal ;
			if(retrieveCascade==null || retrieveCascade=='undefined'){
				retrieveCascade=false;
			}
			$scope.report.$promise.then(function(data) {
				if(data.id>0 ){
					$scope.setSectionTab(sectionVal);
					//get reporter
					$scope.reportResource.get({reportId: data.id}).$promise.then(function(reporter) {
						$scope.report.identityId = reporter.reporterId;
					});
					console.log("report category resolved as "+data.categoryId);
					$scope.reportCategory = $scope.categoryResource.get({categoryId: data.categoryId});
					$scope.reportCategory.$promise.then(function(data) {
						if(data.id>0 ){
							//TODO verify
							//$scope.customProperties = JSON.parse(data.customProperties);
						}
					});
					if(openForm){
						$scope.openForm('form-report');	
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

		if($scope.externalId>0){
			$scope.getReport($scope.externalId,null, true);
		}

		$scope.setExternalId = function(val){
			$scope.externalId = val ;
		}

		//create
		$scope.newReport = function(folderValue) {
			$scope.report = $scope.reportResource.create({folderId:folderValue});
			$scope.openForm('form-report');
		};
		//Update
		$scope.updateReport = function() {
			//$scope.setChangeState(0);
				console.log($scope.report);
				$scope.report = $scope.reportResource.save($scope.report);
				$scope.report.$promise.then(
						function(data, getReponseHeaders) {
							console.log($scope.report);
							$scope.listReports($scope.folderValue);
							$scope.getReport(data.id, 1);
							$("#modalBody").modal('hide');	
						},
						function(data, getReponseHeaders) {
							console.log(data);
							if(data.status === 302) {
								$scope.message= data.data;
								$scope.message.exist= true;
							}
						}
				);
		}
		
		//phase
		
		
		//list
		$scope.listReportPhases = function(folderValue) {
			$scope.folderValue = folderValue;
			$scope.reportPhaseList = $scope.reportPhaseResource.query({folderId:folderValue});
			$scope.reportPhaseList.$promise.then(function(data) {
					$scope.reportPhases = data;
					$scope.phaseLiterals = [];
					$scope.reportPhases.forEach(function(entry) {
						if ($scope.phaseLiterals.indexOf(entry.literal) == -1) {
							$scope.phaseLiterals.push(entry.literal);
					    }
					});
			})
		};

		//getOne
		$scope.getReportPhase = function(idVal, sectionVal, retrieveCascade) {
			
			$scope.reportPhase = $scope.reportPhaseResource.get({id: idVal});
			if(sectionVal==null || sectionVal=='undefined'){
				sectionVal=0;
			}
			$scope.reportPhase.$promise.then(function(data) {
			});
		};

		//create
		$scope.newReportPhase = function(folderValue) {
			$scope.reportPhase = $scope.reportPhaseResource.create({folderId:folderValue});
			$scope.openForm('form-report-phase');
		};
		//Update
		$scope.updateReportPhase = function() {
				$scope.reportPhase = $scope.reportPhaseResource.save($scope.reportPhase);
				$scope.reportPhase.$promise.then(
						function(data, getReponseHeaders) {
							$scope.listReportPhases(data.reportFolderId);
							$("#modalBody").modal('hide');	
						},
						function(data, getReponseHeaders) {
							console.log(data);
							if(data.status === 302) {
								$scope.message= data.data;
								$scope.message.exist= true;
							}
						}
				);
		};

		$scope.openReportPhase = function(id){
			$scope.getReportPhase(id);
			$scope.openForm('form-report-phase');
		}
	
		// Membros da equipe
		$scope.staffMember={};
		
		$scope.folderId =0;
		$scope.listStaffMembers = function(folderId) {
			$scope.staffMembers = $scope.staffMemberResource.get({folderId: folderId});
			$scope.folderId = folderId;
			$scope.staffMembers.$promise.then(function(data) {
				$scope.staffMembers = data.content;
			})
		};

		$scope.newStaffMember = function() {
			$scope.staffMember = $scope.staffMemberResource.newStaffMember({folderId: $scope.folderValue});
			$scope.staffMember.$promise.then(function(data) {
			});
			return $scope.staffMember;
			//$scope.openForm('form-staff-member');
		};
		$scope.getStaffMember = function(id) {
			$scope.message= [];
			$scope.staffMember = $scope.staffMemberResource.get({staffMemberId: id});
		};
		$scope.memberToDelete = function(id) {	
			$scope.message=[];
			$scope.member = $scope.staffMemberResource.get({staffMemberId: id});
		};
		
		$scope.hideModal = function(){
			$("#myModal").modal('hide');
			$scope.message=[];
		};
		
		$scope.deleteMember = function(id) {
			$scope.staffMemberResource.remove({targetId: id}).$promise.then(
					function(data) {
						$scope.hideModal();
						console.log(data);
						$scope.listStaffMembers($scope.folderValue);
					},
					function(data, getReponseHeaders) {
						console.log(data);
						if(data.status === 404) {
							$scope.message= data.data;
							$scope.message.error= true;
						}
					}
			);
		};
		
		$scope.updateStaffMember = function() {

			$scope.staffMember = $scope.staffMemberResource.save($scope.staffMember);
			$scope.staffMember.$promise.then(
					function(data, getReponseHeaders) {
						$scope.listStaffMembers($scope.folderValue);
					//	$("#modalBody").modal('hide');
					}, 
					function(data, getReponseHeaders) {
						console.log(data);
						if(data.status === 302) {
							$scope.message= data.data;
							$scope.message.exist=true;
						}
					}
			);
		};
		
		$scope.users = function(){
			$scope.userList = $scope.staffMemberResource.query({users: true});
		}
		$scope.users();
		
		$scope.getUser = function(id){
			return $scope.staffMemberResource.get({users: true, userId: id});
		}
		$scope.identityMember = {"userId" : -1};
		
		$scope.onSelect = function ($item, $model, $label) {
			$scope.identityMember  = $item;
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
		 * Chamada de pesquisa de usuário para typeAhead
		 * 
		 */		
		$scope.getStaffMembers = function(val){
			return $scope.userList = $scope.staffMemberResource.query({users: true, search:val, searchFolderId: $scope.folderValue})
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
		
		
		
		
		
		// Monitoramentos
		$scope.review={'progress':0};
		
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
		
		$scope.reportId =0;
		$scope.listReviews = function(reportId) {
			$scope.reviews = $scope.reviewResource.query({reportId: reportId});
			$scope.reportId = reportId;
			$scope.reviews.$promise.then(function(data) {
				if (data.length===1) {
				}
			})
		};

		$scope.newReview = function() {
			$scope.review = $scope.reviewResource.newReview({reportId: $scope.reportId});
			$scope.openForm('form-report-review');
		};
		$scope.getReview = function(id) {
			$scope.message= [];
			$scope.review = $scope.reviewResource.getReview({reportReviewId: id});
			$scope.openForm('form-report-review');
		};
		$scope.updateReview = function() {

			$scope.review = $scope.reviewResource.save($scope.review);
			$scope.review.$promise.then(
					function(data, getReponseHeaders) {
						$scope.listReviews(data.reportId);
						$scope.reportResource.get({id: data.reportId}).$promise.then(function(data){
							$scope.listReports(data.reportFolderId);
							$scope.setSectionTab(1);
						});
						$("#modalBody").modal('hide');
					}, 
					function(data, getReponseHeaders) {
						console.log(data);
						if(data.status === 302) {
							$scope.message= data.data;
							$scope.message.exist=true;
						}
					}
			);
		};

		//Participante
		

		$scope.participant={};
		
		$scope.reportId =0;
		$scope.listParticipants = function(reportId) {
			$scope.participants = $scope.participantResource.query({reportId: reportId});
			$scope.reportId = reportId;
			$scope.participants.$promise.then(function(data) {
				if (data.length===1) {
				}
			})
		};

		$scope.newParticipant = function() {
			$scope.participant = $scope.participantResource.newParticipant({reportId: $scope.reportId});
		};
		$scope.getParticipant = function(id) {
			$scope.message= [];
			$scope.participant = $scope.participantResource.getParticipant({participantId: id});
		};
		$scope.updateParticipant = function() {

			$scope.participant = $scope.participantResource.save($scope.participant);
			$scope.participant.$promise.then(
					function(data, getReponseHeaders) {
					//	$("#modalBody").modal('hide');
					}, 
					function(data, getReponseHeaders) {
						console.log(data);
						if(data.status === 302) {
							$scope.message= data.data;
							$scope.message.exist=true;
						}
					}
			);
		};

		
		//Comentários
		

		$scope.followUp={};
		
		$scope.reportId =0;
		$scope.listFollowUps = function(reportId) {
			$scope.followUps = $scope.followUpResource.query({reportId: reportId});
			$scope.reportId = reportId;
			$scope.followUps.$promise.then(function(data) {
				if (data.length===1) {
				}
			})
		};

		$scope.newFollowUp = function() {
			$scope.followUp = $scope.followUpResource.newFollowUp({reportId: $scope.reportId});
		};
		$scope.getFollowUp = function(id) {
			$scope.message= [];
			$scope.followUp = $scope.followUpResource.getFollowUp({followUpId: id});
		};
		$scope.updateFollowUp = function() {

			$scope.followUp = $scope.followUpResource.save($scope.followUp);
			$scope.followUp.$promise.then(
					function(data, getReponseHeaders) {
						//$("#modalBody").modal('hide');
					}, 
					function(data, getReponseHeaders) {
						console.log(data);
						if(data.status === 302) {
							$scope.message= data.data;
							$scope.message.exist=true;
						}
					}
			);
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
		
			
	}])
	.controller('MemberController', ['$scope', function($scope) {
		var addMember=false;
		$scope.isAddMember=function() {
			return addMember;
		};
		$scope.setAddMember = function(value) {
			addMember = value;
		};
	}])
	.controller('ViewController', ['$scope', function($scope) {
	}])
	;

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

})();
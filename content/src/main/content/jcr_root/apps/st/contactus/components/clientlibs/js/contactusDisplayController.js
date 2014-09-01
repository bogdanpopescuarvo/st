'use strict';

var contactusDisplayControllers = angular.module('contactusDisplayControllers', []);

contactusDisplayControllers.controller('ContactusDisplayCtrl', ['$scope', 'ContactType', 'GetAllContacts', '$http', 
	 function($scope, ContactType, $http) {
	   $scope.contactTypeList = ContactType.query();
	   $scope.allContactsList = GetAllContacts.query();
	   $scope.searchResults = [];
	   
	   $scope.loadReportByContactType = function(contactType) {
		    var param = {};
			param['contactType'] = contactType;

			
			$http({method: 'GET', url: 'st/contactus/filterByContactType.htm', params: param}).
		    success(function(data, status, headers, config) {
		      $scope.searchResults = data;		      
		    }).
		    error(function(data, status, headers, config) {
		      //bloody hell		    	
		    });			
	   };
	   
	   $scope.loadReportByLocation = function(locationInfo) {
		    var param = {};
			param['locationInfo'] = locationInfo;

			
			$http({method: 'GET', url: 'st/contactus/filterByLocation.htm', params: param}).
		    success(function(data, status, headers, config) {
		      $scope.searchResults = data;		      
		    }).
		    error(function(data, status, headers, config) {
		      //bloody hell		    	
		    });			
	   };
	   
}]);


var App = angular.module('stContactUsApp',[]);

App.controller('contactUsController', function($scope,$http, $window) {
	$scope.form={};
	$scope.id=""; 
	$scope.companyName="";
	$scope.contactType="";
	$scope.contact="";
	$scope.city="";
	$scope.state="";
	$scope.address="";
	$scope.googleLatitude="";
	$scope.googleLongitude="";
	$scope.addressType="";
	$scope.phone="";
	$scope.fax="";
	$scope.email="";
	$scope.coverage="";
	$scope.contactName="";
	$scope.description="";
	$scope.imageUrl="";
	$scope.imageAlt="";

	$scope.getContact = function(id) {
		 var url = location.pathname.replace(".html", "/_jcr_content.edit.json") ;
		$http.post(url,
        		{'id': id},
        		{
        			headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'},
        			transformRequest: transform
        		}).success(function(data){
        			$scope.contact = JSON.parse(data.contact);
        			$scope.contactType= $scope.contact.contactType;
        			$scope.id=$scope.contact.id; 
        			$scope.companyName=$scope.contact.companyName;
        			$scope.city=$scope.contact.city;
        			$scope.state=$scope.contact.state;
        			$scope.address=$scope.contact.address;
        			$scope.googleLatitude=$scope.contact.googleLatitude;
        			$scope.googleLongitude=$scope.contact.googleLongitude;
        			$scope.addressType=$scope.contact.addressType;
        			$scope.phone=$scope.contact.phone;
        			$scope.fax=$scope.contact.fax;
        			$scope.email=$scope.contact.email;
        			$scope.coverage=$scope.contact.coverage;
        			$scope.contactName=$scope.contact.contactName;
        			$scope.description=$scope.contact.description;
        			$scope.imageUrl=$scope.contact.imageUrl;
        			$scope.imageAlt=$scope.contact.imageAlt;
        }).error(function(data,status){
        });
	}
	$scope.deleteContact = function(id) {
		 var url = location.pathname.replace(".html", "/_jcr_content.delete.json") ;
		$http.post(url,
       		{'id': id},
       		{
       			headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'},
       			transformRequest: transform
       		}).success(function(data){
       		 $scope.contactList = angular.fromJson(data.contacts);
       }).error(function(data,status){
       });
	}
	
	$scope.saveContact = function() {
		 var url = location.pathname.replace(".html", "/_jcr_content.persist.json") ;
			$http.post(url,
        		{'id': $scope.id, 
				'companyName': $scope.companyName,
				'contactType': $scope.contactType,
				'city': $scope.city,
				'state': $scope.state,
				'address': $scope.address,
				'googleLatitude': $scope.googleLatitude,
				'googleLongitude': $scope.googleLongitude,
				'addressType': $scope.addressType,
				'phone': $scope.phone,
				'fax': $scope.fax,
				'email': $scope.email,
				'coverage': $scope.coverage,
				'contactName': $scope.contactName,
				'description': $scope.description,
				'imageUrl': $scope.imageUrl,
				'imageAlt': $scope.imageAlt
        		

        		},
        		{
        			headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'},
        			transformRequest: transform
        		}).success(function(data){
           		 $scope.contactList = angular.fromJson(data.contacts);
        }).error(function(data,status){
        });

	}
	
});

var transform = function(data){
    return $.param(data);
}

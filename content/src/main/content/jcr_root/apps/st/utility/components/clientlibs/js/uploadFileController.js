var App = angular.module('stUploadFileApp',[]);

App.controller('stUploadFileController', function($scope,$http, $window) {
	$scope.form={};


	$scope.upload = function() {
		 var url = location.pathname.replace(".html", "/_jcr_content.upload.json") ;
         var fd = new FormData();
        fd.append('file', file);
			$http.post(url,fd,
        		{
        			headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'},
        			transformRequest: transform
        		}).success(function(data){
           		 $scope.contactList = angular.fromJson(data.filename);
        }).error(function(data,status){
        });

	}

});

var transform = function(data){
    return $.param(data);
}

var contactusDisplayServices = angular.module('contactusDisplayServices', ['ngResource']);

contactusDisplayServices.factory('GetAllContacts', 
 function($http, $q) {

    var getData = function() {
        var deferred = $q.defer();
		//var url = location.pathname.replace(".html", "/_jcr_content.persist.json") ;  
        var url = "/bin/servlets/contactus.json";       
        $http({method:"GET", url:url}).success(function(result){
            deferred.resolve(result);
        });

        return deferred.promise;
    };
    return { getData: getData };
});

contactusDisplayServices.factory('GetAllContactsFitered', 
 function($http, $q) {

    var getData = function(contactType) {       
        var deferred = $q.defer();
		//var url = location.pathname.replace(".html", "/_jcr_content.persist.json") ;  
		var url = '/bin/servlets/contactus.type='+contactType+'.json';
		$http.post(url,
        		{'contactType': contactType},
        		{
        			headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'},
        			transformRequest: transform
        		}).success(function(result){
           		 deferred.resolve(result);
        })


        return deferred.promise;
    };
     return { getData : getData };
});
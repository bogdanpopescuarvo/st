var contactusDisplayServices = angular.module('contactusDisplayServices', ['ngResource']);


contactusDisplayServices.factory('ContactType', ['$resource',
function($resource){
	return $resource('st/contactus/contactTypes.htm', {}, {
		query: {method:'GET', isArray:true}
	});
	
}]);

contactusDisplayServices.factory('GetAllContacts', ['$resource',
 function($resource){
 	return $resource('st/contactus/allContacts.htm', {}, {
 		query: {method:'GET', isArray:true}
 	});
 	
 }]);

var App = angular.module('contactusDisplayApp',[]);

App.factory('GetAllContacts', ['$resource',
	function($resource){
		return $resource('st/contactus/allContacts.htm', {}, {
			query: {method:'GET', isArray:true}
		});
	
}]);


App.controller('ContactusDisplayCtrl', function ($scope) {

	$scope.locationMarkers = [
        {
            name:  "Toronto Headquarters",
            address: "Address",               
            city : 'Toronto',
            desc : 'This is the best city in the world!',
            lat : 43.7000,
            long : -79.4000
        },
        {
            name:  "New York Headquarters",
            address: "Address", 
            city : 'New York',
            desc : 'This city is ok!',
            lat : 40.6700,
            long : -73.9400
        },
        {
			name:  "Chicago Headquarters",
            address: "Address",
            city : 'Chicago',
            desc : 'This is the second best city in the world!',
            lat : 41.8819,
            long : -87.6278
        },
        {
            name:  "Los Angeles Headquarters",
            address: "Address",   
            city : 'Los Angeles',
            desc : 'This city is live!',
            lat : 34.0500,
            long : -118.2500
        },
        {
            name:  "Las Vegas Headquarters",
			address: "Address",
            city : 'Las Vegas',
            desc : 'Sin City...\'nuff said!',
            lat : 36.0800,
            long : -115.1522
        }
    ];





    $scope.centerMap = function(lat,long) {           
 		$scope.map.setCenter(new google.maps.LatLng(lat, long));
        $scope.map.setZoom(8);
    }

	$scope.addressSets = []
	$scope.loadReport = function(filter) {
		$scope.addressSets = [];
		localaddressSets = [];
        addressSet = [];
        for(i = 0; i < $scope.locationMarkers.length; i++){
            var address = $scope.locationMarkers[i];
            if( i % 3 ==0 ){               
                localaddressSets.push(addressSet);
                addressSet = [];
            }
            addressSet.push(address);
        }
        
        localaddressSets.push(addressSet);
		$scope.addressSets = localaddressSets;
	};

    var mapOptions = {
        zoom: 4,
        center: new google.maps.LatLng(40.0000, -98.0000),
        mapTypeId: google.maps.MapTypeId.TERRAIN
    }

    $scope.map = new google.maps.Map(document.getElementById('map'), mapOptions);
    $scope.markers = [];

    var infoWindow = new google.maps.InfoWindow();
    
    var createMarker = function (info){
        
        var marker = new google.maps.Marker({
            map: $scope.map,
            position: new google.maps.LatLng(info.lat, info.long),
            title: info.city
        });
        marker.content = '<div class="infoWindowContent">' + info.desc + '</div>';
        
        google.maps.event.addListener(marker, 'click', function(){
            infoWindow.setContent('<h2>' + marker.title + '</h2>' + marker.content);
            infoWindow.open($scope.map, marker);
        });
        
        $scope.markers.push(marker);
        
    }  
    
    for (i = 0; i < $scope.locationMarkers.length; i++){
        createMarker($scope.locationMarkers[i]);
    }

    $scope.openInfoWindow = function(e, selectedMarker){
        e.preventDefault();
        google.maps.event.trigger(selectedMarker, 'click');
    }

});
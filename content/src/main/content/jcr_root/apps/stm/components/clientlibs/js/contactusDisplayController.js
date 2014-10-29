var contactusDisplayController = angular.module('contactusDisplayController', []);

contactusDisplayController.controller('ContactusDisplayCtrl', ['$scope', '$http', 'GetAllContacts', 'GetAllContactsFitered', 
	function ($scope, $http, GetAllContacts, GetAllContactsFitered) {

    $scope.contactType = '';
    $scope.location = '';
	$scope.filter = '';
	$scope.locationMarkers = [];
	var myStartingDataPromise = GetAllContacts.getData();
	myStartingDataPromise.then(function(result) {  //
       	$scope.locationMarkers = result;  
		$scope.processJsonPromise();
    });



    $scope.centerMap = function(lat,long) {        
 		$scope.map.setCenter(new google.maps.LatLng(lat, long));
        $scope.map.setZoom(8);
    };

	$scope.addressSets = [];

    $scope.processJsonPromise = function() {
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
    }


	$scope.loadReportByLocation = function() {
        $scope.filter = $scope.location;
        $scope.loadReport();
    }

	$scope.loadReportByType = function() {
        $scope.filter = $scope.contactType;
        $scope.loadReport();
    }

	$scope.loadReport = function() {
		var param = {};		
        var myDataPromise = GetAllContactsFitered.getData($scope.filter);
		myDataPromise.then(function(result) {  //
       		$scope.locationMarkers = result;  

            $scope.processJsonPromise();

    	});
	};

    var mapOptions = {
            zoom: 3,
            center: new google.maps.LatLng(37.509097, 15.077959),
            mapTypeId: google.maps.MapTypeId.TERRAIN
        }

    $scope.map = new google.maps.Map(document.getElementById('map'), mapOptions);
    $scope.markers = [];


	$scope.$watch('locationMarkers', function() {		
        var infoWindow = new google.maps.InfoWindow(); 		
        for (var i = 0; i < $scope.markers.length; i++) {
   			 $scope.markers[i].setMap(null);
  		}

        var createMarker = function (info){            
            var marker = new google.maps.Marker({
                map: $scope.map,
                position: new google.maps.LatLng(info.officeLocation.latitude, info.officeLocation.longitude),
                title: info.officeDetails.officeName
            });
            marker.content = '<div class="infoWindowContent">' + info.officeDetails.contacttype + '</div>';
            
            google.maps.event.addListener(marker, 'click', function(){
                infoWindow.setContent('<h2>' + marker.title + '</h2>' + marker.content);
                infoWindow.open($scope.map, marker);
            });
            
            $scope.markers.push(marker);

        }  

        for (i = 0; i < $scope.locationMarkers.length; i++){

            createMarker($scope.locationMarkers[i]);
        }
    });

    $scope.openInfoWindow = function(e, selectedMarker){
        e.preventDefault();
        google.maps.event.trigger(selectedMarker, 'click');
    };

}]);
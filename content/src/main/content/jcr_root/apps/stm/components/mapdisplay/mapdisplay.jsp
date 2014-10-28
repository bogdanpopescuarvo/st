<%@include file="/libs/foundation/global.jsp"%>
<cq:includeClientLib categories="angularJSClient" />
<cq:includeClientLib categories="stJSLibrary" />

<html>
<head>
 <script src="https://maps.googleapis.com/maps/api/js"></script>
    <style>
        #map {
            height:500px;
            width:100%;
        }
        .infoWindowContent {
            font-size:  14px !important;
            border-top: 1px solid #ccc;
            padding-top: 10px;
            height:40px;
            width:250px;
        }
    </style>	
	<style>
		.section-header {
			background-color: #002052;
			color: white;
			font-size: 16px;
			height: 30px;
			
			line-height: 30px;
		}
		.page-title {
			color: #002052;
			font-size: 22px;
			
		}
		.button {
		   border-top: 1px solid #96d1f8;
		   background: #65a9d7;
		   background: -webkit-gradient(linear, left top, left bottom, from(#3e779d), to(#65a9d7));
		   background: -webkit-linear-gradient(top, #3e779d, #65a9d7);
		   background: -moz-linear-gradient(top, #3e779d, #65a9d7);
		   background: -ms-linear-gradient(top, #3e779d, #65a9d7);
		   background: -o-linear-gradient(top, #3e779d, #65a9d7);
		   padding: 5px 10px;
		   -webkit-border-radius: 7px;
		   -moz-border-radius: 7px;
		   border-radius: 7px;
		   -webkit-box-shadow: rgba(0,0,0,1) 0 1px 0;
		   -moz-box-shadow: rgba(0,0,0,1) 0 1px 0;
		   box-shadow: rgba(0,0,0,1) 0 1px 0;
		   text-shadow: rgba(0,0,0,.4) 0 1px 0;
		   color: white;
		   font-size: 17px;
		   font-family: Helvetica, Arial, Sans-Serif;
		   text-decoration: none;
		   vertical-align: middle;
		   }
		.button:hover {
		   border-top-color: #28597a;
		   background: #28597a;
		    text-decoration: none;
		   color: #ccc;
		   }
		.button:active {
		   border-top-color: #1b435e;
		   background: #1b435e;
		    text-decoration: none;
		   }
	</style>
<meta charset="UTF-8">
<title>ST Contact Us</title>
</head>

<body ng-app="contactusDisplayApp" ng-controller="ContactusDisplayCtrl">
<div>
    <span class="page-title">Contact Us</span>
	</br></br>
 	<div id="map"></div>   
	</br>
	<div class="section-header">&nbsp;&nbsp; Refine your search</div>
	</br></br>
	<table cellpadding="10" cellspacing="0" width="70%">
		<tr>
			<td width = "40%">
				<table cellpadding="0" cellspacing="0">
					<tr>
						<td>By City, State or Zip</td>						
					</tr>
					<tr>
						<td><input type="text" ng-model="location"> &nbsp;&nbsp;&nbsp;&nbsp;
                            <a href = href="#" ng-click="loadReportByLocation()">
                            	<span class="button"  ng-click="loadReportByLocation()">Refine</span>
                            </a>
                        </td>						
					</tr>					
				</table>				
			</td>
			<td width = "60%">
				<table cellpadding="0" cellspacing="0">
					<tr>
						<td>By Contact Type</td>						
					</tr>
					<tr>
						<td>
							<select ng-model="contactType" ng-change="loadReportByType()">
	      						<option value="headquarter">Headquarter</option>
								<option value="designConsultants">Design Consultants</option>
								<option value="distribution">Distribution</option>
								<option value="manufacturingAndDesignCenters">Manufacturing and Design Centers</option>
								<option value="salesOfficesAndRepresentatives">Sales offices and Representatives</option>
								<option value="thirdParties">Third Parties</option>
								<option value="Warehouses">Warehouses</option>
	   						</select>
						</td>						
					</tr>					
				</table>				
			</td>
		</tr>
	</table>
	</br></br>
	<div class="section-header">&nbsp;&nbsp; Contact Search Results</div>

<table cellpadding="10" cellspacing="0" width="70%" ng-show="addressSets.length > 0">	

        <tr ng-repeat="group in addressSets">
        	<td ng-repeat="location in group" width="33%">
            	{{ location.officeDetails.officeName }}<br>
				{{ location.officeDetails.description }}<br>
				{{ location.officeDetails.phone }}<br>
				{{ location.officeDetails.fax }}<br>
                <a href="#" ng-click="centerMap(location.officeLocation.latitude, location.officeLocation.longitude)">View Map</a>
        	</td>
    	</tr>

	</table>	

</body>
</html>
<%@include file="/libs/foundation/global.jsp"%>
<cq:includeClientLib categories="angularJSClient" />
<cq:includeClientLib categories="stJSLibrary" />

<html>
<head>
 <script src="https://maps.googleapis.com/maps/api/js"></script>
    <style>
      #map_canvas {
        width: 100%;
        height: 500;
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

<body ng-app="contactusDisplayApp" >
<div ng-controller="contactusDisplayControllers">
	<span class="page-title">Contact Us</span>
	</br></br>
	 <app-map style="height:400px;margin:12px;box-shadow:0 3px 25px black;"
        center="loc"
        markers="locationMarkers"
    > 
    </app-map>
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
						<td><input type="text" ng-model="location"> &nbsp;&nbsp;&nbsp;&nbsp;<a href = ""><span class="button">Refine</span></a></td>						
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
							<select ng-model="contactType">
	      						<option value="0">Distributors</option>
	      						<option value="1">Headquarters</option>
	      						<option value="2">Manufacturing and Design Centers</option>
	      						<option value="3">Sales offices & Representatives</option>
	      						<option value="4">Warehouses</option>
	   						</select>
							<!-- select ng-model="contactType" ng-options="type.name for type in contactTypeList" ng-change="loadReportByContactType()">
	      						<option value="">-- Choose contact type --</option>
	   						</select -->
						</td>						
					</tr>					
				</table>				
			</td>
		</tr>
	</table>
	</br></br>
	<div class="section-header">&nbsp;&nbsp; Contact Search Results</div>
	<table cellpadding="10" cellspacing="0" width="70%" ng-show="locationMarkers">	
		<tr ng-repeat="location in locationMarkers">
			<td width = "33%">
				{{ location.name }}<br>
				{{ location.address }}<br>
				{{ location.zip }}<br>
				{{ location.city }}<br>
				{{ location.phone }}<br>
				{{ location.fax }}<br>
				
			</td>
		</tr>
	</table>	
</body>
</html>
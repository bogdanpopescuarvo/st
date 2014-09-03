<%@include file="/libs/foundation/global.jsp"%>
<cq:includeClientLib categories="angularJSClient" />
<cq:includeClientLib categories="stJSLibrary" />

<html ng-app="stContactUsApp">
<head>
<meta charset="UTF-8">
<title>ST Contact Us Page Configuration</title>
</head>

<body  >
<div ng-controller="contactUsController">

	<h1>ST Contact Save</h1>

	<form method="#">
		<input type="hidden" id="id" name="id"/>
		<table border="1" align="left">
			<tr>
				<td><label for="contactType">Contact Type </label></td>
				<td><select id="contactType" name="contactType" ng-model="contactType">
						<option value="headquarter">Headquarter</option>
						<option value="designConsultants">Design Consultants</option>
						<option value="distribution">Distribution</option>
						<option value="manufacturingAndDesignCenters">Manufacturing
							and Design Centers</option>
						<option value="salesOfficesAndRepresentatives">Sales
							offices and Representatives</option>
						<option value="thirdParties">Third Parties</option>
						<option value="Warehouses">Warehouses</option>
				</select></td>
			</tr>
			<tr>
				<td><label for="companyName">Company name</label></td>
				<td><input id="companyName" name="companyName" type="text" value="" ng-model="companyName"></td>
			</tr>
			<tr>
				<td><label for="city">City</label></td>
				<td><input id="city" name="city" type="text" value="" ng-model="city">
				</td>
			</tr>

			<tr>
				<td><label for="state">State</label></td>
				<td><input id="state" name="state" type="text" value="" ng-model="state">
				</td>
			</tr>

			<tr>
				<td><label for="address">Address</label></td>
				<td><textarea id="address" name="address" rows="4" cols="50" ng-model="address">
</textarea></td>
			</tr>
			<tr>
				<td><label for="googleLatitude">Latitude</label></td>
				<td><input id="googleLatitude" name="googleLatitude" type="text" value="" ng-model="googleLatitude">
				</td>
			</tr>

			<tr>
				<td><label for="googleLongitude">Longitude</label></td>
				<td><input id="googleLongitude" name="googleLongitude" type="text" value="" ng-model="googleLongitude">
				</td>
			</tr>
			<tr>
				<td><label for="contactType">Contact Type </label></td>
				<td><select id="addressType" name="addressType" ng-model="addressType">
						<option value="headquarter">Headquarter</option>
						<option value="distribution">Distribution</option>
						<option value="manufacturingAndDesignCenters">Manufacturing
							and Design</option>
						<option value="salesOfficesAndRepresentatives">Sales
							offices and Representatives</option>
						<option value="Warehouses">Warehouses</option>
				</select></td>
			</tr>
			<tr>
				<td><label for="phone">Phone</label></td>
				<td><input id="phone" name="phone" type="text" value="" ng-model="phone">
				</td>
			</tr>

			<tr>
				<td><label for="fax">Fax</label></td>
				<td><input id="fax" name="fax" type="text" value="" ng-model="fax"></td>
			</tr>

			<tr>
				<td><label for="email">Email</label></td>
				<td><input id="email" name="email" type="text" value="" ng-model="email"></td>
			</tr>

			<tr>
				<td><label for="website">Website</label></td>
				<td><input id="website" name="website" type="text" value="" ng-model="website"></td>
			</tr>

			<tr>
				<td><label for="coverage">Coverage</label></td>
				<td><input id="coverage" name="coverage" type="text" value="" ng-model="coverage"></td>
			</tr>
			
			<tr>
				<td><label for="contactName">Contact Name</label></td>
				<td><input id="contactName" name="contactName" type="text" value="" ng-model="contactName"></td>
			</tr>
			
			<tr>
				<td><label for="description">Description</label></td>
				<td><textarea id="description" name="description" rows="4" cols="50" ng-model="description"></textarea></td>
			</tr>
			<tr>
				<td><label for="image">Image</label></td>
				<td><input id="image" name="image" type="text" value="" ng-model="image"></td>
			</tr>
			<tr>
				<td><label for="imageAlt">Image Alternate Text</label></td>
				<td><input id="imageAlt" name="imageAlt" type="text" value="" ng-model="imageAlt"></td>
			</tr>
			

			<tr>
				<td></td>
				<td><input type="button" value="Save Contact" name="submit" id="submit" value="Submit" ng-click = "saveContact($event);"></td>

			</tr>

		</table>
	</form>
    <br/>
	<div id="results">

<table ng-show="contactList.length > 0">
    <thead>
        <tr>
            <th style="text-align: center;">Contact Type</th>
            <th style="text-align: center;">Company Name</th>
            <th style="text-align: center;">City</th>
            <th></th>
        </tr>
    </thead>
    <tbody>
        <tr ng-repeat="contact in contactList track by $index" >
            <td style="text-align: center;">Type:{{contact.contactType }}&nbsp;</td>
            <td>Company:&nbsp;{{contact.companyName}}</td>
            <td>City:&nbsp;{{contact.city}}</td>
            <td><a href="#" ng-click="getContact()" >Edit</a></td>

        </tr>
    </tbody>
</table>
</div>
 </div>
</body>


</html>
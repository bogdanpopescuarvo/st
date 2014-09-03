<%@include file="/libs/foundation/global.jsp"%>
<cq:includeClientLib categories="angularJSClient" />
<cq:includeClientLib categories="stJSLibrary" />

<html ng-app="stContactUsApp">
<head>
<meta charset="UTF-8">
<title>ST Contact Us Page Configuration</title>
<style type="text/css">

/*
This was made by João Sardinha
Visit me at http://johnsardine.com/

The table style doesnt contain images, it contains gradients for browsers who support them as well as round corners and drop shadows.

It has been tested in all major browsers.

This table style is based on Simple Little Table By Orman Clark,
you can download a PSD version of this at his website, PremiumPixels.
http://www.premiumpixels.com/simple-little-table-psd/

PLEASE CONTINUE READING AS THIS CONTAINS IMPORTANT NOTES

*/

/*
Im reseting this style for optimal view using Eric Meyer's CSS Reset - http://meyerweb.com/eric/tools/css/reset/
------------------------------------------------------------------ */
body, html  { height: 100%; }
html, body, div, span, applet, object, iframe,
/*h1, h2, h3, h4, h5, h6,*/ p, blockquote, pre,
a, abbr, acronym, address, big, cite, code,
del, dfn, em, font, img, ins, kbd, q, s, samp,
small, strike, strong, sub, sup, tt, var,
b, u, i, center,
dl, dt, dd, ol, ul, li,
fieldset, form, label, legend,
table, caption, tbody, tfoot, thead, tr, th, td {
	margin: 0;
	padding: 0;
	border: 0;
	outline: 0;
	font-size: 100%;
	vertical-align: baseline;
	background: transparent;
}
body { line-height: 1; }
ol, ul { list-style: none; }
blockquote, q { quotes: none; }
blockquote:before, blockquote:after, q:before, q:after { content: ''; content: none; }
:focus { outline: 0; }
del { text-decoration: line-through; }
table {border-spacing: 0; } /* IMPORTANT, I REMOVED border-collapse: collapse; FROM THIS LINE IN ORDER TO MAKE THE OUTER BORDER RADIUS WORK */

/*------------------------------------------------------------------ */

/*This is not important*/
body{
	font-family:Arial, Helvetica, sans-serif;
	background: url(background.jpg);
	margin:0 auto;
	width:520px;
}
a:link {
	color: #666;
	font-weight: bold;
	text-decoration:none;
}
a:visited {
	color: #666;
	font-weight:bold;
	text-decoration:none;
}
a:active,
a:hover {
	color: #bd5a35;
	text-decoration:underline;
}


/*
Table Style - This is what you want
------------------------------------------------------------------ */
table a:link {
	color: #666;
	font-weight: bold;
	text-decoration:none;
}
table a:visited {
	color: #999999;
	font-weight:bold;
	text-decoration:none;
}
table a:active,
table a:hover {
	color: #bd5a35;
	text-decoration:underline;
}
table {
	font-family:Arial, Helvetica, sans-serif;
	color:#666;
	font-size:12px;
	text-shadow: 1px 1px 0px #fff;
	background:#eaebec;
	margin:20px;
	border:#ccc 1px solid;

	-moz-border-radius:3px;
	-webkit-border-radius:3px;
	border-radius:3px;

	-moz-box-shadow: 0 1px 2px #d1d1d1;
	-webkit-box-shadow: 0 1px 2px #d1d1d1;
	box-shadow: 0 1px 2px #d1d1d1;
}
table th {
	padding:21px 25px 22px 25px;
	border-top:1px solid #fafafa;
	border-bottom:1px solid #e0e0e0;

	background: #ededed;
	background: -webkit-gradient(linear, left top, left bottom, from(#ededed), to(#ebebeb));
	background: -moz-linear-gradient(top,  #ededed,  #ebebeb);
}
table th:first-child{
	text-align: left;
	padding-left:20px;
}
table tr:first-child th:first-child{
	-moz-border-radius-topleft:3px;
	-webkit-border-top-left-radius:3px;
	border-top-left-radius:3px;
}
table tr:first-child th:last-child{
	-moz-border-radius-topright:3px;
	-webkit-border-top-right-radius:3px;
	border-top-right-radius:3px;
}
table tr{
	text-align: center;
	padding-left:20px;
}
table tr td:first-child{
	text-align: left;
	padding-left:20px;
	border-left: 0;
}
table tr td {
	padding:18px;
	border-top: 1px solid #ffffff;
	border-bottom:1px solid #e0e0e0;
	border-left: 1px solid #e0e0e0;
	
	background: #fafafa;
	background: -webkit-gradient(linear, left top, left bottom, from(#fbfbfb), to(#fafafa));
	background: -moz-linear-gradient(top,  #fbfbfb,  #fafafa);
}
table tr.even td{
	background: #f6f6f6;
	background: -webkit-gradient(linear, left top, left bottom, from(#f8f8f8), to(#f6f6f6));
	background: -moz-linear-gradient(top,  #f8f8f8,  #f6f6f6);
}
table tr:last-child td{
	border-bottom:0;
}
table tr:last-child td:first-child{
	-moz-border-radius-bottomleft:3px;
	-webkit-border-bottom-left-radius:3px;
	border-bottom-left-radius:3px;
}
table tr:last-child td:last-child{
	-moz-border-radius-bottomright:3px;
	-webkit-border-bottom-right-radius:3px;
	border-bottom-right-radius:3px;
}
table tr:hover td{
	background: #f2f2f2;
	background: -webkit-gradient(linear, left top, left bottom, from(#f2f2f2), to(#f0f0f0));
	background: -moz-linear-gradient(top,  #f2f2f2,  #f0f0f0);	
}

</style>
</head>

<body  >
<div ng-controller="contactUsController">

	<h1>ST Contact Save</h1>

	<form method="#">
		<input type="hidden" id="id" name="id" ng-model="id" />
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
            <td><a href="#" ng-click="getContact(contact.id)" >Edit</a></td>

        </tr>
    </tbody>
</table>
</div>
 </div>
</body>


</html>
<%@include file="/libs/foundation/global.jsp"%>
<cq:includeClientLib categories="angularJSClient" />
<cq:includeClientLib categories="stJSLibrary" />

<html ng-app="stUploadFileApp">
<head>
<meta charset="UTF-8">
<title>ST Contact Us Page Configuration</title>
</head>

<body>
	<div ng-controller="stUploadFileController">

		<h1>ST Contact Save</h1>

		<form method="#">
			<table border="1" align="left">
				<tr>
					<td><label for="contactType">Contact Type </label></td>
					<td><select id="contactType" name="contactType"
						ng-model="contactType">
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
					<td><label for="file">File</label></td>
					<td><input id="file-id" type="file" name="our-file" /></td>
				</tr>
                <tr>
					<td></td>
                    <td><input type="button" ng-click="upload" value="Save"/></td>
					<td></td>
					<td></td>
				</tr>
            </table>
            <form>
            </div>
</body>
</html>

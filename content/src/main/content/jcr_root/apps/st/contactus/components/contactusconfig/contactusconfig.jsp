<%@include file="/libs/foundation/global.jsp"%>
<cq:includeClientLib categories="jquerysamples" />
<html>
<head>
<meta charset="UTF-8">
<title>Adobe CQ Dynamic Web Service Weather Page</title>
<style>
#signup .indent label.error {
	margin-left: 0;
}

#signup label.error {
	font-size: 0.8em;
	color: #F00;
	font-weight: bold;
	display: block;
	margin-left: 215px;
}

#signup  input.error,#signup select.error {
	background: #FFA9B8;
	border: 1px solid red;
}
</style>
<script>
	//Creates a GUID value using JavaScript - used for the unique value for the generated claim    
	function createUUID() {

		var s = [];
		var hexDigits = "0123456789abcdef";
		for (var i = 0; i < 36; i++) {
			s[i] = hexDigits.substr(Math.floor(Math.random() * 0x10), 1);
		}
		s[14] = "4"; // bits 12-15 of the time_hi_and_version field to 0010
		s[19] = hexDigits.substr((s[19] & 0x3) | 0x8, 1); // bits 6-7 of the clock_seq_hi_and_reserved to 01
		s[8] = s[13] = s[18] = s[23] = "-";

		var uuid = s.join("");
		return uuid;
	}

	$(document).ready(
			function() {

				$('body').hide().fadeIn(5000);

				$('#submit').click(
						function() {
							var failure = function(err) {
								alert("Unable to retrive data " + err);
							};

							//Get the user-defined values that represent claim data to persist in the Adobe CQ JCR
                            var url = location.pathname.replace(".html", "/_jcr_content.persist.json") ;
							var id =$('#id').val();
							if(id =="")
								id = createUUID();
							var companyName = $('#companyName').val();
							var contactType = $('#contactType').val();
							var city = $('#city').val();
							var state = $('#state').val();
							var address = $('#address').val();
							var googleLatitude = $('#googleLatitude').val();
							var googleLongitude = $('#googleLongitude').val();
							var addressType = $('#addressType').val();
							var phone = $('#phone').val();
							var fax = $('#fax').val();
							var email = $('#email').val();
							var coverage = $('#coverage').val();
							var contactName = $('#contactName').val();
							var description = $('#description').val();
							var imageUrl = $('#imageUrl').val();
							var imageAlt = $('#imageAlt').val();
							var data = {'id':id, 
									'companyName':companyName,
									'contactType':contactType,
									'city':city,
									'state':state,
									'address':address,
									'googleLatitude':googleLatitude,
									'googleLongitude':googleLongitude,
									'addressType':addressType,
									'phone':phone,
									'fax':fax,
									'coverage':coverage,
									'contactName':contactName,
									'description':description,
									'imageUrl':imageUrl,
									'imageAlt':imageAlt}
							

							//Use JQuery AJAX request to post data to a Sling Servlet
							$.ajax({
								type : 'POST',
                                url :url,
								data : data,
								success: function(rawData, status, xhr) {
                                    var data;
                                    try {
                                            alert(rawData);
                                    } catch(err) {
                                        failure(err);
                                    }
        						},
                                error: function(xhr, status, err) {
                                    failure(err);
                                }
							});
						});

			}); // end ready
</script>
</head>

<title>ST Contact Us Page Configuration</title>

<body>


	<h1>ST Contact Save</h1>

	</div>

	<form method="#">
		<input type="hidden" id="id" name="id"/>
		<table border="1" align="left">
			<tr>
				<td><label for="contactType">Contact Type </label></td>
				<td><select id="contactType" name="contactType">
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
				<td><input id="companyName" name="companyName" type="text"
					value=""></td>
			</tr>
			<tr>
				<td><label for="city">City</label></td>
				<td><input id="city" name="city" type="text" value="">
				</td>
			</tr>

			<tr>
				<td><label for="state">State</label></td>
				<td><input id="state" name="state" type="text" value="">
				</td>
			</tr>

			<tr>
				<td><label for="address">Address</label></td>
				<td><textarea id="address" name="address" rows="4" cols="50">
</textarea></td>
			</tr>
			<tr>
				<td><label for="googleLatitude">Latitude</label></td>
				<td><input id="googleLatitude" name="googleLatitude" type="text" value="">
				</td>
			</tr>

			<tr>
				<td><label for="googleLongitude">Longitude</label></td>
				<td><input id="googleLongitude" name="googleLongitude" type="text" value="">
				</td>
			</tr>
			<tr>
				<td><label for="contactType">Contact Type </label></td>
				<td><select id="addressType" name="addressType">
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
				<td><input id="phone" name="phone" type="text" value="">
				</td>
			</tr>

			<tr>
				<td><label for="fax">Fax</label></td>
				<td><input id="fax" name="fax" type="text" value=""></td>
			</tr>

			<tr>
				<td><label for="email">Email</label></td>
				<td><input id="email" name="email" type="text" value=""></td>
			</tr>

			<tr>
				<td><label for="website">Website</label></td>
				<td><input id="website" name="website" type="text" value=""></td>
			</tr>

			<tr>
				<td><label for="coverage">Coverage</label></td>
				<td><input id="coverage" name="coverage" type="text" value=""></td>
			</tr>
			
			<tr>
				<td><label for="contactName">Contact Name</label></td>
				<td><input id="contactName" name="contactName" type="text" value=""></td>
			</tr>
			
			<tr>
				<td><label for="description">Description</label></td>
				<td><textarea id="description" name="description" rows="4" cols="50"></textarea></td>
			</tr>
			<tr>
				<td><label for="image">Image</label></td>
				<td><input id="image" name="image" type="text" value=""></td>
			</tr>
			<tr>
				<td><label for="imageAlt">Image Alternate Text</label></td>
				<td><input id="imageAlt" name="imageAlt" type="text" value=""></td>
			</tr>
			

			<tr>
				<td></td>
				<td><input type="button" value="Submit" name="submit"
					id="submit" value="Submit"></td>

			</tr>

		</table>
		<div id="message"/>

	</form>

</body>

</html>
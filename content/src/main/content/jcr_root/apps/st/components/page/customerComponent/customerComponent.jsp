<%@include file="/libs/foundation/global.jsp"%>
<cq:includeClientLib categories="jquerysamples" />
<html>
<head>
<meta charset="UTF-8">
<title>Adobe CQ Persist Page</title>
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
#signup  input.error, #signup select.error  {
  background: #FFA9B8;
  border: 1px solid red;
}
</style>
<script>
$(document).ready(function() {
      
   
      
$('#submit').click(function() {
    var failure = function(err) {
      //  $(".main").unmask();
        alert("Unable to retrive data "+err);
          
    };
      
      
    //Get the user-defined values to persist in the database
    var myFirst= $('#first').val() ;
    var myLast= $('#last').val() ;
    var myDescription= $('#description').val() ;
    var myAddress= $('#address').val() ;
      
    var url = location.pathname.replace(".html", "/_jcr_content.persist.json") + "?first="+ myFirst +"&last="+myLast +"&desc="+myDescription +"&phone="+myAddress;
      
    //$(".main").mask("Saving Data...");
  
    $.ajax(url, {
        dataType: "text",
        success: function(rawData, status, xhr) {
            var data;
            try {
                data = $.parseJSON(rawData);
                  
                          
                //Set the fields in the forum
                $('#custId').val(data.pk);
             
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
<body>
<div class="wrapper">
    <div class="header">
        <p class="logo">Adobe CQ JCR Customer Persist/Query Application</p>
    </div>
    <div class="content">
    <div class="main">
    <h1>CQ Data Persist Example</h1>
      
    <form name="signup" id="signup">
     <table>
    <tr>
    <td>
    <label for="first">First Name:</label>
    </td>
     <td>
    <input type="first" id="first" name="first" value="" />
    </td>
    </tr>
    <tr>
    <td>
    <label for="last">Last Name:</label>
    </td>
     <td>
    <input type="last" id="last" name="last" value="" />
    </td>
    </tr>
     <tr>
    <td>
    <label for="address">Address:</label>
    </td>
     <td>
    <input type="address" id="address" name="address" value="" />
    </td>
    </tr>
     <tr>
    <td>
   <label for="description">Description:</label>
    </td>
    <td>
    <select id="description"  >
            <option>Active Customer</option>
            <option>Past Customer</option> 
        </select>
    </td>
    </tr>
     <tr>
    <td>
    <label for="custId">Customer Id:</label>
    </td>
     <td>
    <input type="custId" id="custId" name="custId" value="" readonly="readonly"/>
    </td>
    </tr>
     
</table>
            <div>
                <input type="button" value="Add Customer!"  name="submit" id="submit" value="Submit">
            </div>
        </form>
        </div>
    </div>
     
    <div id="container">
     <form name="custdata" id="custdata">
    
    <h1>Query Customer Data from the AEM JCR</h1>
   <div>
     <select id="custQuery"  >
            <option>All Customers</option>
            <option>Active Customer</option>
            <option>Past Customer</option>   
        </select>
    </div>
    <div id="dynamic"></div>
    <div class="spacer"></div>
 
   <div>
      <input type="button" value="Get Customers!"  name="submitget" id="submitget" value="Submit">
    </div>
   </form>
      
</div>
</body>
</html>
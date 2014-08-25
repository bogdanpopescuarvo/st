<%@include file="/libs/foundation/global.jsp"%>
<%@ page import="org.apache.sling.commons.json.io.*,com.adobe.cq.*,com.st.olm.cq.api.contactus.*,org.w3c.dom.*" %><%
String filter = request.getParameter("filter");

STContact cs = sling.getService(STContact.class);
  
String XML = cs.getCustomerData(filter) ;
   
//Send the data back to the client
JSONWriter writer = new JSONWriter(response.getWriter());
writer.object();
writer.key("xml");
writer.value(XML);

writer.endObject();
%>
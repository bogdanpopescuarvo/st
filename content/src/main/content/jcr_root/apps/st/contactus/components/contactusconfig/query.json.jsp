<%@include file="/libs/foundation/global.jsp"%>
<%@ page import="org.apache.sling.commons.json.io.*,com.adobe.cq.*,com.st.olm.cq.api.contactus.*,org.w3c.dom.*" %><%
String filter = request.getParameter("id");

STContact cs = sling.getService(STContact.class);

com.google.gson.JsonElement contact = cs.getContact(filter) ;
   
//Send the data back to the client
JSONWriter writer = new JSONWriter(response.getWriter());
writer.object();
writer.key("contact");
writer.value(contact);

writer.endObject();
%>
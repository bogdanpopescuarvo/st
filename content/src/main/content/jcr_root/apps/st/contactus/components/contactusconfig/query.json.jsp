<%@include file="/libs/foundation/global.jsp"%>
<%@ page import="org.apache.sling.commons.json.io.*,com.st.olm.cq.api.contactus.*,com.google.gson.*" %><%
String filter = request.getParameter("id");

STContactService cs = sling.getService(STContactService.class);
out.println("Aici este"+filter);
JsonElement contact = cs.getContact(filter) ;
   
//Send the data back to the client
JSONWriter writer = new JSONWriter(response.getWriter());
writer.object();
writer.key("contact");
writer.value(contact);

writer.endObject();
%>
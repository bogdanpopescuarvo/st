<%@include file="/libs/foundation/global.jsp"%>
<%@ page import="org.apache.sling.commons.json.io.*,com.st.olm.cq.api.contactus.*" %><%
String id = request.getParameter("id");

com.st.olm.cq.api.contactus.STContactService cs = sling.getService(com.st.olm.cq.api.contactus.STContactService.class);
com.google.gson.JsonElement contactRes = cs.getContact(id);

//Send the data back to the client
JSONWriter writer = new JSONWriter(response.getWriter());
writer.object();
writer.key("contact");
writer.value(contactRes);

writer.endObject();
%>
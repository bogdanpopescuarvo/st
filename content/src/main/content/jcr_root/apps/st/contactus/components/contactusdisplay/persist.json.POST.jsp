<%@include file="/libs/foundation/global.jsp"%>
<%@ page import="org.apache.sling.commons.json.io.*,com.st.olm.cq.api.contactus.*,com.google.gson.*" %>
<%
STContactService cs = sling.getService(STContactService.class);
String contactRes = cs.getContactDataForDisplay(request.getParameter("contactType"));

response.getWriter().write(contactRes);

//Send the data back to the client
//JSONWriter writer = new JSONWriter(response.getWriter());
//writer.object();
//writer.key("displaycontacts");
//writer.value(contactRes);

//writer.endObject();
%>
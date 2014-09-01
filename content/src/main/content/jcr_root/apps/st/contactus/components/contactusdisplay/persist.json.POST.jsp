<%@include file="/libs/foundation/global.jsp"%>
<%@ page import="org.apache.sling.commons.json.io.*,com.st.olm.cq.api.contactus.*" %><%
    com.st.olm.cq.api.contactus.STContact contact = new com.st.olm.cq.api.contactus.STContact();

			contact.setCompanyName(request.getParameter("companyName"));
			contact.setCity(request.getParameter("city"));
			contact.setState(request.getParameter("state"));
			contact.setAddress(request.getParameter("address"));
			contact.setGoogleLatitude(request.getParameter("googleLatitude"));
			contact.setGoogleLongitude(request.getParameter("googleLongitude"));
			contact.setAddressType(request.getParameter("addressType"));
			contact.setPhone(request.getParameter("phone"));
			contact.setFax(request.getParameter("fax"));
			contact.setEmail(request.getParameter("email"));
			contact.setWebsite(request.getParameter("website"));
			contact.setCoverage(request.getParameter("coverage"));
			contact.setContactName(request.getParameter("contactName"));
			contact.setDescription(request.getParameter("description"));
			contact.setImageUrl(request.getParameter("imageUrl"));
			contact.setImageAlt(request.getParameter("imageAlt"));
			contact.setContactType(request.getParameter("contactType"));


com.st.olm.cq.api.contactus.STContactService cs = sling.getService(com.st.olm.cq.api.contactus.STContactService.class);
com.google.gson.JsonElement contactRes = cs.injestContactData(contact);

//Send the data back to the client
JSONWriter writer = new JSONWriter(response.getWriter());
writer.object();
writer.key("contacts");
writer.value(contactRes);

writer.endObject();
%>
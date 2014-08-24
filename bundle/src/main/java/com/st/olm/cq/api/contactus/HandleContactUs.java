package com.st.olm.cq.api.contactus;

import java.io.IOException;
import java.rmi.ServerException;

import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.sling.SlingServlet;
import org.apache.sling.api.SlingHttpServletRequest;
import org.apache.sling.api.SlingHttpServletResponse;
import org.apache.sling.jcr.api.SlingRepository;



@SlingServlet(paths = "/st/contactus",methods = {"GET", "POST"})
@Properties({
    @Property(name="service.pid", value="com.adobe.unicom.v1.servlets.OmnnitureLoggingServlet",propertyPrivate=false),
    @Property(name="service.description",value="Omniture service call logging servlet", propertyPrivate=false),
    @Property(name="service.vendor",value="Adobe Systems Incorporated - Adobe@Adobe Team", propertyPrivate=false)
})
public class HandleContactUs extends
		org.apache.sling.api.servlets.SlingAllMethodsServlet {
	private static final long serialVersionUID = 2598426539166789515L;

	@Reference
	private SlingRepository repository;

	@Reference
	private STContactService contactService;

	public void bindRepository(SlingRepository repository) {
		this.repository = repository;
	}

	public void bindContactService(STContactService contactService) {
		this.contactService = contactService;
	}

	@Override
	protected void doPost(SlingHttpServletRequest request,
			SlingHttpServletResponse response) throws ServerException,
			IOException {

		try {
			STContact contact = new STContact();

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
			contactService.injestContactData(contact);
			// Encode the submitted form data to JSON

			// Return the JSON formatted data
			response.getWriter().write("asdfas");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
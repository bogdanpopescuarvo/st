package com.st.olm.cq.api.contactus;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.jcr.Node;
import javax.jcr.Session;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.Service;
import org.apache.jackrabbit.commons.JcrUtils;
import org.apache.sling.api.resource.ResourceResolver;
//Sling Imports
import org.apache.sling.api.resource.ResourceResolverFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.day.cq.search.PredicateGroup;
import com.day.cq.search.Query;
import com.day.cq.search.QueryBuilder;
import com.day.cq.search.result.Hit;
import com.day.cq.search.result.SearchResult;
import com.google.gson.Gson;
import com.google.gson.JsonElement;

//This is a component so it can provide or consume services
@Component
@Service
public class STContactServiceImpl implements STContactService {

	/** Default log. */
	protected final Logger log = LoggerFactory.getLogger(this.getClass());

	private Session session;

	// Inject a Sling ResourceResolverFactory
	@Reference
	private ResourceResolverFactory resolverFactory;

	@Reference
	private QueryBuilder builder;

	@Override
	public JsonElement injestContactData(STContact contact) {

		int num = 0;
		try {

			// Invoke the adaptTo method to create a Session used to create a123
			// QueryManager
			ResourceResolver resourceResolver = resolverFactory.getAdministrativeResourceResolver(null);
			session = resourceResolver.adaptTo(Session.class);

			// Create a node that represents the root node
			Node root = session.getRootNode();

			// Get the content node in the JCR
			Node content = root.getNode("content");

			// Determine if the content/contact node exists
			Node contactRoot = null;
			int contactRec = doesContactExist(content);
			int contactId = 0;
			STContact existingContact = null;
			// -1 means that content/contact does not exist
			if (contact.getId() == null) {

				if (contactRec == -1) {
					// content/contact does not exist -- create it
					contactRoot = content.addNode("contact", "nt:unstructured");
				} else {
					// content/contact does exist -- retrieve it
					contactRoot = content.getNode("contact");
				}
				contactId = contactRec + 1; // assign a new id to the contact
			} else {
				contactId = contact.getId().intValue();
				// content/contact does exist -- retrieve it
				contactRoot = content.getNode("contact");
				existingContact = getContactById("" + contactId, session);
			}

			// node

			// Store content from the client JSP in the JCR
			Node contactNode = null;
			if (existingContact != null) {
				contactNode = contactRoot.getNode("contact" + contactId);
			} else {
				contactNode = contactRoot.addNode("contact" + contactId, "nt:unstructured");
			}

			// make sure name of node is unique
			contactNode.setProperty("id", contactId);
			contactNode.setProperty("companyName", contact.getCompanyName());
			contactNode.setProperty("city", contact.getCity());
			contactNode.setProperty("state", contact.getState());
			contactNode.setProperty("address", contact.getAddress());
			contactNode.setProperty("googleLatitude", contact.getGoogleLatitude());
			contactNode.setProperty("googleLongitude", contact.getGoogleLongitude());
			contactNode.setProperty("addressType", contact.getAddressType());
			contactNode.setProperty("phone", contact.getPhone());
			contactNode.setProperty("fax", contact.getFax());
			contactNode.setProperty("email", contact.getEmail());
			contactNode.setProperty("website", contact.getWebsite());
			contactNode.setProperty("coverage", contact.getCoverage());
			contactNode.setProperty("contactName", contact.getContactName());
			contactNode.setProperty("description", contact.getDescription());
			contactNode.setProperty("imageUrl", contact.getImageUrl());
			contactNode.setProperty("imageAlt", contact.getImageAlt());
			contactNode.setProperty("contactType", contact.getContactType());

			// Save the session changes and log out
			session.save();
			session.logout();
			return new Gson().toJsonTree(getContactData(null));
		}

		catch (Exception e) {
			log.error("RepositoryException: " + e);
			return new Gson().toJsonTree("error");
		}
	}

	@Override
	public List<STContact> getContactData(String filter) {
		List<STContact> contactList = new ArrayList<STContact>();
		STContact contact = null;

		List<STContact> contacttList = new ArrayList<STContact>();
		try {

			// Invoke the adaptTo method to create a Session
			ResourceResolver resourceResolver = resolverFactory.getAdministrativeResourceResolver(null);
			session = resourceResolver.adaptTo(Session.class);

			String fulltextSearchTerm = "Geometrixx";

			// create query description as hash map (simplest way, same as form
			// post)
			Map<String, String> map = new HashMap<String, String>();

			// create query description as hash map (simplest way, same as form
			// post)

			map.put("path", "/content/contact");
			map.put("type", "nt:unstructured");
			// can be done in map or with Query methods
			map.put("p.offset", "0"); // same as query.setStart(0) below
			map.put("p.limit", "20"); // same as query.setHitsPerPage(20) below

			
			if (filter != null && !filter.equals("")) {				
				String[] params = filter.split(":");
				if (params.length > 0) {
					map.put("property",params[0]);
					map.put("property.value",params[1]);
				}
			}	
			
			Query query = builder.createQuery(PredicateGroup.create(map), session);

			query.setStart(0);
			query.setHitsPerPage(20);

			SearchResult result = query.getResult();

			// paging metadata
			int hitsPerPage = result.getHits().size(); // 20 (set above) or
														// lower
			long totalMatches = result.getTotalMatches();
			long offset = result.getStartIndex();
			long numberOfPages = totalMatches / 20;

			// Iterate over the nodes in the results ...

			for (Hit hit : result.getHits()) {

				// For each node-- create a contacts instance
				contact = new STContact();

				javax.jcr.Node node = hit.getNode();

				contact.setCompanyName(node.getProperty("companyName").getString());
				contact.setId(node.getProperty("id").getLong());
				contact.setCity(node.getProperty("city").getString());
				contact.setState(node.getProperty("state").getString());
				contact.setAddress(node.getProperty("address").getString());
				contact.setGoogleLatitude(node.getProperty("googleLatitude").getString());
				contact.setGoogleLongitude(node.getProperty("googleLongitude").getString());
				contact.setAddressType(node.getProperty("addressType").getString());
				contact.setPhone(node.getProperty("phone").getString());
				contact.setFax(node.getProperty("fax").getString());
				if (node.hasProperty("email"))
					contact.setEmail(node.getProperty("email").getString());
				if (node.hasProperty("website"))
					contact.setWebsite(node.getProperty("website").getString());
				if (node.hasProperty("coverage"))
					contact.setCoverage(node.getProperty("coverage").getString());
				if (node.hasProperty("contactName"))
					contact.setContactName(node.getProperty("contactName").getString());

				if (node.hasProperty("description"))
					contact.setDescription(node.getProperty("description").getString());

				if (node.hasProperty("imageUrl"))
					contact.setImageUrl(node.getProperty("imageUrl").getString());
				if (node.hasProperty("imageAlt"))
					contact.setImageAlt(node.getProperty("imageAlt").getString());
				if (node.hasProperty("contactType"))
					contact.setContactType(node.getProperty("contactType").getString());

				// Push contact to the list
				contactList.add(contact);
			}

			// Log out
			session.logout();
			return contactList;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public String getContactDataForDisplay(String filter) {
		List<STContactDisplay> displayableContacts = new ArrayList<STContactDisplay>();
		STContactDisplay contact = null;
		List<STContact> jcrContacts = getContactData(filter);
		for (STContact stContact : jcrContacts) {
			contact = new STContactDisplay();
			contact.setName(stContact.getCompanyName());
			contact.setAddress(stContact.getAddress());
			contact.setCity(stContact.getCity());
			contact.setFax(stContact.getFax());
			contact.setLat(stContact.getGoogleLatitude());
			contact.setLon(stContact.getGoogleLongitude());
			contact.setPhone(stContact.getPhone());
			contact.setFax(stContact.getFax());
			contact.setZip(stContact.getState());			
			displayableContacts.add(contact);
		}
		return new Gson().toJson(displayableContacts);
	}

	/*
	 * Determines if the content/contact node exists This method returns these
	 * values: -1 - if contact does not exist 0 - if content/contact node
	 * exists; however, contains no children number - the number of children
	 * that the content/contact node contains
	 */
	private int doesContactExist(Node content) {
		try {
			int index = 0;
			int childRecs = 0;

			java.lang.Iterable<Node> contactNode = JcrUtils.getChildNodes(content, "contact");
			Iterator it = contactNode.iterator();

			// only going to be 1 content/contact node if it exists
			if (it.hasNext()) {
				// Count the number of child nodes to contact
				Node contactRoot = content.getNode("contact");
				Iterable itcontact = JcrUtils.getChildNodes(contactRoot);
				Iterator childNodeIt = itcontact.iterator();

				// Count the number of contact child nodes
				while (childNodeIt.hasNext()) {
					childRecs++;
					childNodeIt.next();
				}
				return childRecs;
			} else
				return -1; // content/contact does not exist
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	@Override
	public JsonElement getContact(String id) {
		try {
			// Invoke the adaptTo method to create a Session
			ResourceResolver resourceResolver = resolverFactory.getAdministrativeResourceResolver(null);
			session = resourceResolver.adaptTo(Session.class);
			return new Gson().toJsonTree(getContactById(id, session));

		} catch (Exception e) {
			log.error("RepositoryException: " + e);
			return new Gson().toJsonTree("error");
		} finally {
			// Log out
			session.logout();
		}
	}

	@Override
	public STContact getContactById(String id, Session session) {
		try {

			// Invoke the adaptTo method to create a Session
			ResourceResolver resourceResolver = resolverFactory.getAdministrativeResourceResolver(null);
			session = resourceResolver.adaptTo(Session.class);

			// create query description as hash map (simplest way, same as form
			// post)
			Map<String, Object> map = new HashMap<String, Object>();

			// create query description as hash map (simplest way, same as form
			// post)

			map.put("path", "/content/contact");
			map.put("type", "nt:unstructured");
			map.put("property", "id");
			map.put("property.value", id);
			// can be done in map or with Query methods
			map.put("p.offset", "0"); // same as query.setStart(0) below
			map.put("p.limit", "20"); // same as query.setHitsPerPage(20) below

			Query query = builder.createQuery(PredicateGroup.create(map), session);

			SearchResult result = query.getResult();

			// Iterate over the nodes in the results ...
			STContact contact = new STContact();
			for (Hit hit : result.getHits()) {

				// For each node-- create a contacts instance

				javax.jcr.Node node = hit.getNode();

				contact.setCompanyName(node.getProperty("companyName").getString());
				contact.setId(node.getProperty("id").getLong());
				contact.setCity(node.getProperty("city").getString());
				contact.setState(node.getProperty("state").getString());
				contact.setAddress(node.getProperty("address").getString());
				contact.setGoogleLatitude(node.getProperty("googleLatitude").getString());
				contact.setGoogleLongitude(node.getProperty("googleLongitude").getString());
				contact.setAddressType(node.getProperty("addressType").getString());
				contact.setPhone(node.getProperty("phone").getString());
				contact.setFax(node.getProperty("fax").getString());
				if (node.hasProperty("email"))
					contact.setEmail(node.getProperty("email").getString());
				if (node.hasProperty("website"))
					contact.setWebsite(node.getProperty("website").getString());
				if (node.hasProperty("coverage"))
					contact.setCoverage(node.getProperty("coverage").getString());
				if (node.hasProperty("contactName"))
					contact.setContactName(node.getProperty("contactName").getString());

				if (node.hasProperty("description"))
					contact.setDescription(node.getProperty("description").getString());

				if (node.hasProperty("imageUrl"))
					contact.setImageUrl(node.getProperty("imageUrl").getString());
				if (node.hasProperty("imageAlt"))
					contact.setImageAlt(node.getProperty("imageAlt").getString());
				if (node.hasProperty("contactType"))
					contact.setContactType(node.getProperty("contactType").getString());

				break;
			}

			return contact;

		} catch (Exception e) {
			log.error("RepositoryException: " + e);
			return null;
		}
	}

}

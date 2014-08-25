package com.st.olm.cq.api.contactus;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

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

import com.google.gson.Gson;

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

	@Override
	public String injestContactData(STContact contact) {
		
		int num = 0;
		try {

			// Invoke the adaptTo method to create a Session used to create a
			// QueryManager
			ResourceResolver resourceResolver = resolverFactory
					.getAdministrativeResourceResolver(null);
			session = resourceResolver.adaptTo(Session.class);

			// Create a node that represents the root node
			Node root = session.getRootNode();

			// Get the content node in the JCR
			Node content = root.getNode("content");

			// Determine if the content/contact node exists
			Node contactRoot = null;
			int contactRec = doesContactExist(content);

			// -1 means that content/contact does not exist
			if (contactRec == -1)
				// content/contact does not exist -- create it
				contactRoot = content.addNode("contact", "nt:unstructured");
			else
				// content/contact does exist -- retrieve it
				contactRoot = content.getNode("contact");

			int contactId = contactRec + 1; // assign a new id to the contact
											// node

			// Store content from the client JSP in the JCR
			Node contactNode = contactRoot.addNode(
					"contact" + contact.getContactName() + contactId,
					"nt:unstructured");

			// make sure name of node is unique
			contactNode.setProperty("id", contactId);
			contactNode.setProperty("companyName", contact.getCompanyName());
			contactNode.setProperty("city", contact.getCity());
			contactNode.setProperty("state", contact.getState());
			contactNode.setProperty("address", contact.getAddress());
			contactNode.setProperty("googleLatitude",
					contact.getGoogleLatitude());
			contactNode.setProperty("googleLongitude",
					contact.getGoogleLongitude());
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
			return new Gson().toJson(contact);
		}

		catch (Exception e) {
			log.error("RepositoryException: " + e);
			return "error";
		}
	}

	@Override
	public List<STContact> getContactData(String filter) {
		List<STContact> contactList = new ArrayList<STContact>();
		STContact contact = null;

		List<STContact> contacttList = new ArrayList<STContact>();
		try {

			// Invoke the adaptTo method to create a Session used to create a
			// QueryManager
			ResourceResolver resourceResolver = resolverFactory
					.getAdministrativeResourceResolver(null);
			session = resourceResolver.adaptTo(Session.class);

			// Obtain the query manager for the session ...
			javax.jcr.query.QueryManager queryManager = session.getWorkspace()
					.getQueryManager();

			// Setup the quesry based on user input
			String sqlStatement = "";

			// Setup the query to get all STContact records
			if (filter.equals("All STContacts"))
				sqlStatement = "SELECT * FROM [nt:unstructured] WHERE CONTAINS(desc, 'STContact')";
			else if (filter.equals("Active STContact"))
				sqlStatement = "SELECT * FROM [nt:unstructured] WHERE CONTAINS(desc, 'Active')";
			else if (filter.equals("Past STContact"))
				sqlStatement = "SELECT * FROM [nt:unstructured] WHERE CONTAINS(desc, 'Past')";

			javax.jcr.query.Query query = queryManager.createQuery(
					sqlStatement, "JCR-SQL2");

			// Execute the query and get the results ...
			javax.jcr.query.QueryResult result = query.execute();

			// Iterate over the nodes in the results ...
			javax.jcr.NodeIterator nodeIter = result.getNodes();

			while (nodeIter.hasNext()) {

				// For each node-- create a contacts instance
				contact = new STContact();

				javax.jcr.Node node = nodeIter.nextNode();

				contact.setCompanyName(node.getProperty("companyName")
						.getString());
				contact.setCity(node.getProperty("city").getString());
				contact.setState(node.getProperty("state").getString());
				contact.setAddress(node.getProperty("address").getString());
				contact.setGoogleLatitude(node.getProperty("googleLatitude")
						.getString());
				contact.setGoogleLongitude(node.getProperty("googleLongitude")
						.getString());
				contact.setAddressType(node.getProperty("addressType")
						.getString());
				contact.setPhone(node.getProperty("phone").getString());
				contact.setFax(node.getProperty("fax").getString());
				contact.setEmail(node.getProperty("email").getString());
				contact.setWebsite(node.getProperty("website").getString());
				contact.setCoverage(node.getProperty("coverage").getString());
				contact.setContactName(node.getProperty("contactName")
						.getString());
				contact.setDescription(node.getProperty("description")
						.getString());
				contact.setImageUrl(node.getProperty("imageUrl").getString());
				contact.setImageAlt(node.getProperty("imageAlt").getString());
				contact.setContactType(node.getProperty("contactType")
						.getString());

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

			java.lang.Iterable<Node> contactNode = JcrUtils.getChildNodes(
					content, "contact");
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

}

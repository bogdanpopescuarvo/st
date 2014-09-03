package com.st.olm.cq.api.contactus;

import java.util.List;

import javax.jcr.Session;

import com.google.gson.JsonElement;

public interface STContactService {
	// Stores contact data in the Adobe CQ JCR
	public JsonElement injestContactData(STContact contact);

	/*
	 * Retrieves contact data from the AEM JCR and returns all contact data
	 * within an XML schemaThe filter argument specifies one of the following
	 * values:
	 * 
	 * Contact - retrieves all contact dataActive Contact- retrieves current
	 * contacts from the JCRPast Contact - retrieves old contacts no longer
	 * current contacts
	 */

	public List<STContact> getContactData(String filter);

	/*
	 * Retrieves contact data from the AEM JCR and returns all contact data
	 * within an XML schemaThe filter argument specifies one of the following
	 * values:
	 * 
	 * Contact - retrieves all contact dataActive Contact- retrieves current
	 * contacts from the JCRPast Contact - retrieves old contacts no longer
	 * current contacts
	 */
	public JsonElement getContact(String id);
	
	public STContact getContactById(String id,Session session);

	public String getContactDataForDisplay(String filter);

}

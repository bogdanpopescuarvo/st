package com.st.olm.cq.api.contactus;

import java.util.List;

import com.google.gson.JsonElement;

public interface STContactService {
	//Stores contact data in the Adobe CQ JCR
    public JsonElement injestContactData(STContact contact);
     
    /*
     * Retrieves contact data from the AEM JCR and returns all contact
     * data within an XML schema
     *The filter argument specifies one of the following values:
     *    
     *Contact - retrieves all contact data
     *Active Contact- retrieves current contacts from the JCR
     *Past Contact - retrieves old contacts no longer current contacts
     */
<<<<<<< HEAD
    public List<STContact> getContactData(String filter);
    
    
    /*
     * Retrieves contact data from the AEM JCR and returns all contact
     * data within an XML schema
     *The filter argument specifies one of the following values:
     *    
     *Contact - retrieves all contact data
     *Active Contact- retrieves current contacts from the JCR
     *Past Contact - retrieves old contacts no longer current contacts
     */
    public JsonElement getContact(String id); 
=======
    public List<STContact> getContactData(String filter); 
    
    public List<STContactDisplay> getContactDataForDisplay(String filter);
>>>>>>> d52bf37afe517ed28cd3645857596613a9fffa1d
}

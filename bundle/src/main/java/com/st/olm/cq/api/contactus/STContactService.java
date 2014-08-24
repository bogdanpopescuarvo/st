package com.st.olm.cq.api.contactus;

import java.util.List;

public interface STContactService {
	//Stores contact data in the Adobe CQ JCR
    public int injestContactData(STContact contact);
     
    /*
     * Retrieves contact data from the AEM JCR and returns all contact
     * data within an XML schema
     *The filter argument specifies one of the following values:
     *    
     *Contact - retrieves all contact data
     *Active Contact- retrieves current contacts from the JCR
     *Past Contact - retrieves old contacts no longer current contacts
     */
    public List<STContact> getContactData(String filter); 
}

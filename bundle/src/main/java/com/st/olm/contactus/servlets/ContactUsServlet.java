package com.st.olm.contactus.servlets;

import java.io.IOException;
import java.rmi.ServerException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.jcr.Node;
import javax.jcr.NodeIterator;
import javax.jcr.Session;

import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.sling.SlingServlet;
import org.apache.sling.api.SlingHttpServletRequest;
import org.apache.sling.api.SlingHttpServletResponse;
import org.apache.sling.api.resource.ResourceMetadata;
import org.apache.sling.api.resource.ResourceResolver;
import org.apache.sling.api.resource.ValueMap;
import org.apache.sling.api.servlets.SlingAllMethodsServlet;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.day.cq.search.PredicateGroup;
import com.day.cq.search.Query;
import com.day.cq.search.QueryBuilder;
import com.day.cq.search.result.Hit;
import com.day.cq.search.result.SearchResult;
import com.day.cq.wcm.api.Page;
import com.google.gson.Gson;

import org.apache.sling.api.resource.Resource;

/**
 * 
 * @scr.component metatype="no"
 * 
 * @scr.service interface="javax.servlet.Servlet"
 * 
 * @scr.property name="sling.servlet.paths"
 * 
 *               values.0="<my path>"
 * 
 * @scr.property name="sling.servlet.methods" values.0="GET" values.1="POST"
 * 
 * @scr.property name="sling.servlet.extensions" values.0="json"
 */

@SlingServlet(paths = "/bin/mySearchServlet", methods = "POST", metatype = true)
public class ContactUsServlet extends SlingAllMethodsServlet {
	public final static String CONTENT_URL = "/content/stm/en/contactusAuthor";

	/** Default log. */
	protected final Logger log = LoggerFactory.getLogger(this.getClass());

	private Session session;

	@Reference
	private QueryBuilder builder;

	@Override
	protected void doPost(SlingHttpServletRequest request,
			SlingHttpServletResponse response) throws ServerException,
			IOException {
		Map<String, String> map = new HashMap<String, String>();
		try {

			final String fulltextSearch = request.getRequestPathInfo()
					.getSelectorString();
			ResourceResolver resourceResolver = request.getResourceResolver();

			// create query description as hash map (simplest way, same as form
			// post)

			map.put("path", CONTENT_URL);
			map.put("type", "cq:Page");
			map.put("fulltext", fulltextSearch);
			// can be done in map or with Query methods
			map.put("p.offset", "0"); // same as query.setStart(0) below
			map.put("p.limit", "20"); // same as query.setHitsPerPage(20) below
			map.put("p.hits","full");
			map.put("p.nodedepth", "3"); // same as query.setHitsPerPage(20) below

			Query query = builder.createQuery(PredicateGroup.create(map),
					resourceResolver.adaptTo(Session.class));

			SearchResult result = query.getResult();
			List<HashMap<String, Object>> items = new ArrayList<HashMap<String, Object>>();
			HashMap<String, Object> obj =  new HashMap<String, Object>();
			for (Hit hit : result.getHits()) {
				Page pageNode = hit.getResource().adaptTo(Page.class);
				
				items.add(obj);

			}
			response.getOutputStream().write(
					new Gson().toJson(items).getBytes());

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session!=null)
			session.logout();
		}
	}

	protected void doGet(SlingHttpServletRequest request,
			SlingHttpServletResponse response) throws ServerException,
			IOException {
		doPost(request, response);
	}

}

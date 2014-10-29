package com.st.olm.contactus.servlets;

import java.io.IOException;
import java.rmi.ServerException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.jcr.Session;

import org.apache.commons.lang.StringUtils;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.sling.SlingServlet;
import org.apache.sling.api.SlingHttpServletRequest;
import org.apache.sling.api.SlingHttpServletResponse;
import org.apache.sling.api.resource.Resource;
import org.apache.sling.api.resource.ResourceResolver;
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

@SlingServlet(paths = "/bin/servlets/contactus", methods = "POST", metatype = true)
public class ContactUsServlet extends SlingAllMethodsServlet {
	public final static String CONTENT_URL = "/content/stm/en/contactusAuthor";
//"/bin/servlets/contactus".json
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
			if (StringUtils.isNotEmpty(fulltextSearch))
				map.put("fulltext", fulltextSearch);
			// can be done in map or with Query methods
			map.put("p.offset", "0"); // same as query.setStart(0) below
			map.put("p.limit", "20"); // same as query.setHitsPerPage(20) below

			Query query = builder.createQuery(PredicateGroup.create(map),
					resourceResolver.adaptTo(Session.class));

			SearchResult result = query.getResult();
			List<HashMap<String, Object>> items = new ArrayList<HashMap<String, Object>>();
			for (Hit hit : result.getHits()) {
				Page page = hit.getResource().adaptTo(Page.class);

				Resource resDetails = page
						.getContentResource("content/officedetails");
				Resource resLocation = page
						.getContentResource("content/officelocation");
				HashMap<String, Object> obj = new HashMap<String, Object>();
				obj.put("officeDetails", resDetails.getValueMap());
				obj.put("officeLocation", resLocation.getValueMap());
				items.add(obj);

			}
			response.getOutputStream().write(
					new Gson().toJson(items).getBytes());

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.logout();
		}
	}

	protected void doGet(SlingHttpServletRequest request,
			SlingHttpServletResponse response) throws ServerException,
			IOException {
		doPost(request, response);
	}

}

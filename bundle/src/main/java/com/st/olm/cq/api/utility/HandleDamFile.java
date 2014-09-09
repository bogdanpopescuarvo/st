package com.st.olm.cq.api.utility;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.rmi.ServerException;

import javax.jcr.Session;

import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.sling.SlingServlet;
import org.apache.sling.api.SlingHttpServletRequest;
import org.apache.sling.api.SlingHttpServletResponse;
import org.apache.sling.api.resource.ResourceResolver;
//Sling Imports
import org.apache.sling.api.resource.ResourceResolverFactory;
//AssetManager

//This is a component so it can provide or consume services
@SlingServlet(paths = "/st/updamfile", methods = "POST", metatype = true)
public class HandleDamFile extends org.apache.sling.api.servlets.SlingAllMethodsServlet {
	private static final long serialVersionUID = 2598426539166789515L;

	private Session session;

	// Inject a Sling ResourceResolverFactory
	@Reference
	private ResourceResolverFactory resolverFactory;

	@Override
	protected void doGet(SlingHttpServletRequest request,
			SlingHttpServletResponse response) throws ServerException,
			IOException {

	}

	@Override
	protected void doPost(SlingHttpServletRequest request,
			SlingHttpServletResponse response) throws ServerException,
			IOException {

		try {
			final boolean isMultipart = org.apache.commons.fileupload.servlet.ServletFileUpload
					.isMultipartContent(request);
			PrintWriter out = null;

			out = response.getWriter();
			if (isMultipart) {
				final java.util.Map<String, org.apache.sling.api.request.RequestParameter[]> params = request
						.getRequestParameterMap();
				for (final java.util.Map.Entry<String, org.apache.sling.api.request.RequestParameter[]> pairs : params
						.entrySet()) {
					final String k = pairs.getKey();
					final org.apache.sling.api.request.RequestParameter[] pArr = pairs
							.getValue();
					final org.apache.sling.api.request.RequestParameter param = pArr[0];
					final InputStream stream = param.getInputStream();

					// Save the uploaded file into the Adobe CQ DAM
					out.println("The Sling Servlet placed the uploaded file here: "
							+ writeToDam(stream, param.getFileName(), param.getContentType()));

				}
			}
		}

		catch (Exception e) {
			e.printStackTrace();
		}

	}

	// Save the uploaded file into the AEM DAM using AssetManager APIs
	private String writeToDam(InputStream is, String fileName, String contentType) {
		try {
			// Inject a ResourceResolver
			ResourceResolver resourceResolver = resolverFactory
					.getAdministrativeResourceResolver(null);

			// Use AssetManager to place the file into the AEM DAM
			com.day.cq.dam.api.AssetManager assetMgr = resourceResolver
					.adaptTo(com.day.cq.dam.api.AssetManager.class);
			String newFile = "/content/dam/st/" + fileName;
			assetMgr.createAsset(newFile, is, contentType, true);

			// Return the path to the file was stored
			return newFile;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

}
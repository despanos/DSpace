package gr.heal.rdfSearch.json;

import gr.heal.rdfSearch.domain.SKOSConcept;
import gr.heal.rdfSearch.domain.SKOSConceptScheme;
import gr.heal.rdfSearch.service.IRdfSearchService;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.dspace.app.webui.json.JSONRequest;
import org.dspace.authorize.AuthorizeException;
import org.dspace.core.Context;
import org.dspace.submit.step.ProcessMetadataStep;
import org.dspace.utils.DSpace;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

/**
 * 
 * @author dspanos
 *
 */
public class RdfKeywordSearchJSONRequest extends JSONRequest{

	private static Logger log = Logger.getLogger(RdfKeywordSearchJSONRequest.class);
	
	protected IRdfSearchService getSearchService() {
		DSpace dspace = new DSpace();

		org.dspace.kernel.ServiceManager manager = dspace.getServiceManager();

		return manager.getServiceByName(IRdfSearchService.class.getName(), IRdfSearchService.class);
	}
	
	@Override
	public void doJSONRequest(Context context, HttpServletRequest req, HttpServletResponse resp) 
			throws AuthorizeException, IOException {
		String term = req.getParameter("term");
		String scheme = req.getParameter("vocab");
		String getSchemes = req.getParameter("getSchemes");
		try{
			// convert to JSON
			JsonArray array = new JsonArray();
			if(!"1".equals(getSchemes)){
				List<SKOSConcept> concepts = getSearchService().search(term, "".equals(scheme) ? null : scheme);
				// log.info(resultSet.getResultRows());
				for (SKOSConcept concept : concepts) {
					log.info(concept.getPrefLabel());
					JsonObject object = new JsonObject();
					object.addProperty("label", concept.getPrefLabel());
					object.addProperty("value", concept.getPrefLabel() + ProcessMetadataStep.SOURCE_PREFIX
							+ concept.getUri() + ProcessMetadataStep.SOURCE_SUFFIX);
					object.addProperty("scheme", concept.getInScheme().getPrefLabel());
					array.add(object);
				}
			} else {
				log.info("Fetching schemes");
				List<SKOSConceptScheme> schemes = getSearchService().fetchSchemes();
				for (SKOSConceptScheme conceptScheme : schemes) {
					JsonObject object = new JsonObject();
					object.addProperty("label", conceptScheme.getPrefLabel());
					object.addProperty("value", conceptScheme.getUri());
					array.add(object);
				}
			}
			resp.getWriter().write(array.toString());
		} catch (Exception e) {
			log.error("Error while retrieving JSON string for RDF auto complete", e);
		}
	}

}

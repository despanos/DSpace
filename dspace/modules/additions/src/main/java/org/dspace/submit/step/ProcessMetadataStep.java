package org.dspace.submit.step;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.dspace.app.util.SubmissionInfo;
import org.dspace.authorize.AuthorizeException;
import org.dspace.content.Item;
import org.dspace.content.MetadataValue;
import org.dspace.core.Context;
import org.dspace.submit.AbstractProcessingStep;

/**
 * 
 * @author dspanos
 *
 */
public class ProcessMetadataStep extends AbstractProcessingStep {
	
	public static final String HEAL_SCHEMA = "heal";
	
	public static final String SOURCE_PREFIX = " (URL: ";
	
	public static final String SOURCE_SUFFIX = ")";

	@Override
	public int doProcessing(Context context, HttpServletRequest request, HttpServletResponse response, SubmissionInfo subInfo)
			throws ServletException, IOException, SQLException, AuthorizeException {
		//get the item under submission
		Item item = subInfo.getSubmissionItem().getItem();
		
		//transform duration values to xsd:duration
		List<MetadataValue> mvDurations = itemService.getMetadata(item, HEAL_SCHEMA, "duration", null, Item.ANY);
		for (MetadataValue mv : mvDurations){
			if (mv.getValue().contains(":")){
				itemService.removeMetadataValues(context, item, Arrays.asList(mv));
				itemService.addMetadata(context, item, HEAL_SCHEMA, "duration", null, null, createXSDDurationString(mv.getValue()));
			}	
		}
		List<MetadataValue> mvLearningTimes = itemService.getMetadata(item, HEAL_SCHEMA, "typicalLearningTime", null, Item.ANY);
		for (MetadataValue mv : mvLearningTimes){
			if (mv.getValue().contains(":")){
				itemService.removeMetadataValues(context, item, Arrays.asList(mv));
				itemService.addMetadata(context, item, HEAL_SCHEMA, "typicalLearningTime", null, null, createXSDDurationString(mv.getValue()));
			}	
		}
		
		//heal.classification and dc.subject: split autocompleted values to two fields
		List<MetadataValue> mvClassifications = itemService.getMetadata(item, HEAL_SCHEMA, "classification", null, Item.ANY);
		for (MetadataValue mv : mvClassifications){
			String value = mv.getValue();
			String uri = null;
			if (value.contains(SOURCE_PREFIX)) {
				try {
					itemService.removeMetadataValues(context, item, Arrays.asList(mv));
					value = value.substring(0, value.lastIndexOf(SOURCE_PREFIX));
					uri = mv.getValue().substring(mv.getValue().lastIndexOf(SOURCE_PREFIX) + SOURCE_PREFIX.length()-1, mv.getValue().lastIndexOf(SOURCE_SUFFIX));
					itemService.addMetadata(context, item, HEAL_SCHEMA, "classification", null, mv.getLanguage(), value);
					itemService.addMetadata(context, item, HEAL_SCHEMA, "classificationURI", null, null, uri);
				}catch(Exception e) { //handle any bad user input
				}
			}
		}
		List<MetadataValue> mvKeywords = itemService.getMetadata(item, "dc", "subject", null, Item.ANY);
		for (MetadataValue mv : mvKeywords){
			String value = mv.getValue();
			String uri = null;
			if (value.contains(SOURCE_PREFIX)) {
				try {
					itemService.removeMetadataValues(context, item, Arrays.asList(mv));
					value = value.substring(0, value.lastIndexOf(SOURCE_PREFIX));
					uri = mv.getValue().substring(mv.getValue().lastIndexOf(SOURCE_PREFIX) + SOURCE_PREFIX.length()-1, mv.getValue().lastIndexOf(SOURCE_SUFFIX));
					itemService.addMetadata(context, item, "dc", "subject", null, mv.getLanguage(), value);
					itemService.addMetadata(context, item, HEAL_SCHEMA, "keywordURI", null, null, uri);
				}catch(Exception e) { //handle any bad user input
				}
			}
		}
		return 0;
	}
	
	public String createXSDDurationString(String inputTimeString){
		String[] parts = inputTimeString.split(":");
		if (parts.length == 3)
			return "PT" + Integer.parseInt(parts[0]) + "H" + Integer.parseInt(parts[1]) + "M" + Integer.parseInt(parts[2]) + "S";
		return inputTimeString;
	}

	@Override
	public int getNumberOfPages(HttpServletRequest request, SubmissionInfo subInfo) throws ServletException {
		return 1;
	}

}

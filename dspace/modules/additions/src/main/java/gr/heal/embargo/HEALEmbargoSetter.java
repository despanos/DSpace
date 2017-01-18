/**
 * 
 */
package gr.heal.embargo;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.Date;

import org.apache.commons.lang.time.DateUtils;
import org.dspace.authorize.AuthorizeException;
import org.dspace.content.Bitstream;
import org.dspace.content.Bundle;
import org.dspace.content.DCDate;
import org.dspace.content.Item;
import org.dspace.content.MetadataSchema;
import org.dspace.core.ConfigurationManager;
import org.dspace.core.Constants;
import org.dspace.core.Context;
import org.dspace.embargo.DefaultEmbargoSetter;
import org.dspace.eperson.Group;

/**
 * @author aanagnostopoulos
 * @author dspanos
 * 
 */
public class HEALEmbargoSetter extends DefaultEmbargoSetter {
	
	public HEALEmbargoSetter() {
		super();
	}
	
	@Override
	public DCDate parseTerms(Context context, Item item, String terms) throws SQLException, AuthorizeException {
		if (terms != null && terms.length() > 0) {
			if(terms.equals("free"))
				return null;
			else if (terms.equals("account")) {
				return null;
			}
			else if(terms.equals("campus")) {
				return null;
			}
			//terms contains embargo lift date
			else {
				Date liftDate = null;
				try {
					liftDate = DateUtils.parseDate(terms, new String[]{"yyyy-MM-dd", "yyyy-MM", "yyyy"});
				} catch (Exception e) {
					throw new IllegalArgumentException("Embargo lift date is uninterpretable:  "+ terms);
				}
				//add 12 hours just to make sure that DCDate contains the correct date
				return new DCDate(DateUtils.addHours(liftDate,12));
			}
		}
		return null;
	}

}

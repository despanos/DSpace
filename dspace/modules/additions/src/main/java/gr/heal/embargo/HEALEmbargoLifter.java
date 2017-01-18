/**
 * 
 */
package gr.heal.embargo;


import java.io.IOException;
import java.sql.SQLException;

import org.dspace.authorize.AuthorizeException;
import org.dspace.content.DCDate;
import org.dspace.content.Item;
import org.dspace.content.service.ItemService;
import org.dspace.core.Context;
import org.dspace.embargo.DefaultEmbargoLifter;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * @author aanagnostopoulos
 * @author dspanos
 *
 */
public class HEALEmbargoLifter extends DefaultEmbargoLifter {

	@Autowired(required = true)
    protected ItemService itemService;
	
	@Override
	public void liftEmbargo(Context context, Item item) throws SQLException, AuthorizeException, IOException {

		super.liftEmbargo(context, item);
		try{
			context.turnOffAuthorisationSystem();
			//set 'heal.access' field value to 'free', since default polices are enforced by the lifter
			itemService.clearMetadata(context, item, "heal", "access", null, Item.ANY);
			itemService.addMetadata(context, item, "heal", "access", null, null, "free");

			itemService.clearMetadata(context, item, "dc", "date", "available", Item.ANY);
			itemService.addMetadata(context, item, "dc", "date", "available", null, DCDate.getCurrent().toString());

			// Save changes to database
			itemService.update(context, item);
		}
		finally{
			context.restoreAuthSystemState();
		}

	}
	
}

<%--

    The contents of this file are subject to the license and copyright
    detailed in the LICENSE and NOTICE files at the root of the source
    tree and available online at

    http://www.dspace.org/license/

--%>
<%--
  - Initial questions for keeping UI as simple as possible.
  -
  - Attributes to pass in:
  -    submission.info    - the SubmissionInfo object
  --%>

<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"
    prefix="fmt" %>

<%@ page import="java.util.List" %>
<%@ page import="javax.servlet.jsp.jstl.fmt.LocaleSupport" %>

<%@ page import="org.dspace.app.util.SubmissionInfo" %>
<%@ page import="org.dspace.app.webui.servlet.SubmissionController" %>
<%@ page import="org.dspace.app.webui.util.UIUtil" %>
<%@ page import="org.dspace.authorize.AuthorizeServiceImpl" %>
<%@ page import="org.dspace.authorize.ResourcePolicy" %>
<%@ page import="org.dspace.content.Item" %>
<%@ page import="org.dspace.core.ConfigurationManager" %>
<%@ page import="org.dspace.core.Context" %>
<%@ page import="org.dspace.submit.AbstractProcessingStep" %>
<%@ page import="org.dspace.authorize.service.AuthorizeService" %>
<%@ page import="org.dspace.authorize.factory.AuthorizeServiceFactory" %>
<%-- modified by dspanos --%>
<%@ page import="java.sql.SQLException" %>
<%@ page import="org.dspace.eperson.Group" %>
<%@ page import="org.dspace.eperson.service.GroupService" %>
<%@ page import="org.dspace.eperson.factory.EPersonServiceFactory" %>
<%@ page import="org.dspace.content.factory.ContentServiceFactory" %>
<%@ page import="org.dspace.content.MetadataValue" %>
<%-- end dspanos --%>

<%@ taglib uri="http://www.dspace.org/dspace-tags.tld" prefix="dspace" %>

<%
	// Obtain DSpace context
    Context context = UIUtil.obtainContext(request);

	//get submission information object
    SubmissionInfo subInfo = SubmissionController.getSubmissionInfo(context, request);

    // Policies List
    List<ResourcePolicy> policies = AuthorizeServiceFactory.getInstance().getAuthorizeService().findPoliciesByDSOAndType(context, subInfo.getSubmissionItem().getItem(), ResourcePolicy.TYPE_CUSTOM);

    boolean advanced = ConfigurationManager.getBooleanProperty("webui.submission.restrictstep.enableAdvancedForm", false);

    int error_id = request.getAttribute("error_id") == null ? 0 : ((Integer)request.getAttribute("error_id")).intValue();

    Item item = subInfo.getSubmissionItem().getItem();
    String discoverableChecked = item.isDiscoverable() ? "" : " checked=\"checked\"";
    
  	//modified by dspanos
    List<Group> groups = getGroups(context, subInfo);
  	String accessValue = null;
  	boolean isAccessEmbargo = false;
  	String accessTextValue = null;
    List<MetadataValue> accessValues = ContentServiceFactory.getInstance().getItemService().getMetadata(item, "heal", "access", null, Item.ANY);
    //List<MetadataValue> accessTextValues = ContentServiceFactory.getInstance().getItemService().getMetadata(item, "heal", "accessText", null, Item.ANY);
    if (accessValues.size() > 0){
    	accessValue = accessValues.get(0).getValue();
    	isAccessEmbargo = accessValue.matches("\\d{4}-\\d{2}-\\d{2}") || accessValue.matches("\\d{4}-\\d{2}") || accessValue.matches("\\d{4}");
    }
    //if (accessTextValues.size() > 0)
    //	accessTextValue = accessTextValues.get(0).getValue();
%>
<%!    
    List<Group> getGroups(Context context, SubmissionInfo subInfo) throws SQLException{
        List<Group> groups = null;
        GroupService groupService = EPersonServiceFactory.getInstance().getGroupService();
        // retrieve all groups

        if (groups == null || groups.size() == 0)
            groups = groupService.findAll(context, null);

        return groups;
    }
    //end dspanos

%>
<dspace:layout style="submission" locbar="off" navbar="off" titlekey="jsp.submit.access.title" nocache="true">

    <form action="<%= request.getContextPath() %>/submit" method="post" onkeydown="return disableEnterKey(event);">

        <jsp:include page="/submit/progressbar.jsp" />
<h2><fmt:message key="jsp.submit.access.title" /></h2>
<%
    if (error_id > 0)
    {
        String key = "jsp.submit.access.error_" + error_id;
%>      
        <div class="alert alert-warning submitFormWarn"><fmt:message key="<%= key %>"/></div>
<%
    }
%>


		<div class="panel panel-primary"><div class="panel-heading"><fmt:message key="jsp.submit.access.access_setting.heading"/></div>
		<div class="panel-body">
        <h3 class="access-setting"><fmt:message key="jsp.submit.access.private_setting.heading"/></h3>

		<div class="row">
            	<label class="col-md-2" for="private_option"><fmt:message key="jsp.submit.access.private_setting.label"/></label>
				<div class="col-md-10">
				<div class="input-group">
					<span class="input-group-addon">
					<input id="private_option" name="private_option" type="checkbox" value="1" <%= discoverableChecked %>/>
					</span>
					<span class="form-control"><fmt:message key="jsp.submit.access.private_setting.help"/></span>
				</div>
				</div>
		</div>

		<%-- modified by dspanos --%>
		<%-- <h3><fmt:message key="jsp.submit.access.access_scheme.heading"/></h3>
		<div class="form-group">
			<p class="help-block"><fmt:message key="jsp.submit.access.access_dropdown.heading"/></p>
			<select class="form-control" name="heal_access">
				<option <%= "free".equals(accessValue) ? "selected " : "" %> value="free"><fmt:message key="jsp.submit.access.access_dropdown.free"/></option>
				<option <%= isAccessEmbargo ? "selected " : "" %>value="embargo"><fmt:message key="jsp.submit.access.access_dropdown.embargo"/></option>
				<option <%= "campus".equals(accessValue) ? "selected " : "" %>value="campus"><fmt:message key="jsp.submit.access.access_dropdown.campus"/></option>
				<option <%= "account".equals(accessValue) ? "selected " : "" %>value="account"><fmt:message key="jsp.submit.access.access_dropdown.account"/></option>
				<option <%= "other".equals(accessValue) ? "selected " : "" %>value="other"><fmt:message key="jsp.submit.access.access_dropdown.other"/></option>
			</select>
			<p class="help-block"><fmt:message key="jsp.submit.access.accessText.heading"/></p>
			<textarea class="form-control" name="heal_accessText" cols="30" rows="5"><%= accessTextValue!=null ? accessTextValue : "" %></textarea>
		</div>  --%>
		<% if ("account".equals(accessValue)){ %>
		<h3><fmt:message key="jsp.submit.access.group_access.heading"/></h3>
		<div class="form-group">
			<p class="help-block"><fmt:message key="jsp.submit.access.group_dropdown.heading"/></p>
			<select class="form-control" name="heal_access_groups">
				<%
				if (groups != null){
                    for (Group group : groups){
                %>
                        <option value="<%= group.getID() %>"><%= group.getName() %></option>
                <%
                    }
                }
				else{
				%>
					<option value="0">Anonymous</option>
				<%
				}
				%>
			</select>
		</div>
		<% }
		else if ("embargo".equals(accessValue) || isAccessEmbargo){
		%>
		

        <h3 class="access-setting"><fmt:message key="jsp.submit.access.embargo_setting.heading"/></h3>

        <dspace:access-setting subInfo="<%= subInfo %>" dso="<%= subInfo.getSubmissionItem().getItem() %>" embargo="<%= advanced ? true : false %>" addpolicy="<%= advanced ? true : false %>" />
		<%} %>
		<%-- end dspanos --%>
		</div>
		</div>
		
<%
    if (advanced)
    {
%>
		<div class="panel panel-info"><div class="panel-heading"><fmt:message key="jsp.submit.access.plist.heading"/></div>
		<div id="policies-help" class="container help-block"><fmt:message key="jsp.submit.access.policy_setting.help"/></div>
        <dspace:policieslist policies="<%= policies %>" />
        </div>
<%
    }
%>		
		
		<%-- Hidden fields needed for SubmissionController servlet to know which step is next--%>
        <div class="row">
        <%= SubmissionController.getSubmissionParameters(context, request) %>
			<div class="col-md-6 pull-right btn-group">
				<input class="btn btn-default col-md-4" type="submit" name="<%=AbstractProcessingStep.PREVIOUS_BUTTON%>" value="<fmt:message key="jsp.submit.general.previous"/>" />                
                <input class="btn btn-default col-md-4" type="submit" name="<%=AbstractProcessingStep.CANCEL_BUTTON%>" value="<fmt:message key="jsp.submit.general.cancel-or-save.button"/>" />
                <input class="btn btn-primary col-md-4" type="submit" name="<%=AbstractProcessingStep.NEXT_BUTTON%>" value="<fmt:message key="jsp.submit.general.next"/>" />
			</div>
		</div>	
    </form>

    <script type="text/javascript" src="<%= request.getContextPath() %>/submit/access-step.js"></script>
</dspace:layout>

<%@ include file="/init.jsp" %>

<%
ResultRow row = (ResultRow)request.getAttribute(WebKeys.SEARCH_CONTAINER_RESULT_ROW);
User user2 = null;
if (row != null) {
	user2 = (User)row.getObject();
}
else {
	user2 = (User)request.getAttribute("edit_foo.jsp-foo");
}
%>

<liferay-ui:icon-menu icon="<%= StringPool.BLANK %>" message="<%= StringPool.BLANK %>" showExpanded="<%= row == null %>" showWhenSingleIcon="<%= row == null %>">
	<portlet:renderURL var="editURL">
		<portlet:param name="mvcPath" value="/edit_foo.jsp" />
		<portlet:param name="redirect" value="<%= currentURL %>" />
		<portlet:param name="userId" value="<%= String.valueOf(user.getUserId()) %>" />
	</portlet:renderURL>

	<liferay-ui:icon
		iconCssClass="icon-edit"
		message="edit"
		url="<%= editURL %>"
	/>

	<portlet:renderURL var="redirectURL">
		<portlet:param name="mvcPath" value="/view.jsp" />
	</portlet:renderURL>

	<portlet:actionURL var="deleteURL">
		<portlet:param name="<%= Constants.CMD %>" value="<%= Constants.DELETE %>" />
		<portlet:param name="redirect" value="<%= (row == null) ? redirectURL : currentURL %>" />
		<portlet:param name="userId" value="<%= String.valueOf(user.getUserId()) %>" />
	</portlet:actionURL>

	<liferay-ui:icon-delete url="<%= deleteURL %>" />
</liferay-ui:icon-menu>
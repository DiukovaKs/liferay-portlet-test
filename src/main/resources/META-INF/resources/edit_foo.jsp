<%@ include file="/init.jsp" %>

<%
String redirect = ParamUtil.getString(request, "redirect");
long userId = ParamUtil.getLong(request, "userId");
User user1 = null;
if (userId > 0) {
	user1 = userLocalService.getUser(userId);
}
%>

<aui:form action="<%= (javax.portlet.ActionURL)renderResponse.createActionURL() %>" method="post" name="fm">
	<aui:input name="<%= Constants.CMD %>" type="hidden" value="<%= (user == null) ? Constants.ADD : Constants.UPDATE %>" />
	<aui:input name="redirect" type="hidden" value="<%= currentURL %>" />
	<aui:input name="userId" type="hidden" value="<%= userId %>" />

	<liferay-ui:header
		backURL="<%= redirect %>"
		title='<%= (user != null) ? user.getLastName() : "new-user" %>'
	/>

	<liferay-asset:asset-categories-error />

	<liferay-asset:asset-tags-error />

	<aui:model-context bean="<%= user %>" model="<%= User.class %>" />

	<aui:fieldset>
		<aui:input name="firstName" />

		<aui:input name="emailAddress" />

		<aui:input name="jobTitle" />

		<aui:input name="createDate" />


		<liferay-expando:custom-attributes-available className="<%= User.class.getName() %>">
			<liferay-expando:custom-attribute-list
				className="<%= User.class.getName() %>"
				classPK="<%= (user != null) ? user.getUserId() : 0 %>"
				editable="<%= true %>"
				label="<%= true %>"
			/>
		</liferay-expando:custom-attributes-available>

		<aui:input name="categories" type="assetCategories" />

		<aui:input name="tags" type="assetTags" />
	</aui:fieldset>

	<aui:button-row>
		<aui:button type="submit" />

		<aui:button href="<%= redirect %>" type="cancel" />
	</aui:button-row>
</aui:form>
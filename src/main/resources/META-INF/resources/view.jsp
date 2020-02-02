
<%@ include file="/init.jsp" %>

<aui:button-row>
	<portlet:renderURL var="editFooURL">
		<portlet:param name="mvcPath" value="/edit_foo.jsp" />
		<%--<portlet:param name="redirect" value="<%= currentURL %>" />--%>
	</portlet:renderURL>

	<aui:button href="<%= editFooURL %>" value="add-foo" />
</aui:button-row>

<liferay-ui:search-container
	total="<%= userLocalService.getUsersCount() %>"
>
	<liferay-ui:search-container-results
		results="<%= userLocalService.getUsers(searchContainer.getStart(), searchContainer.getEnd()) %>"
	/>

	<liferay-ui:search-container-row
		className="com.liferay.portal.kernel.model.User"
		escapedModel="true"
		modelVar="user"
	>
		<liferay-ui:search-container-column-text
			name="id"
			property="userId"
			valign="top"
		/>

		<liferay-ui:search-container-column-text
			name="fullName"
			valign="top"
		>
			<strong><%= user.getFullName() %></strong>

			<br />

			<div class="lfr-asset-categories">
				<liferay-ui:asset-categories-summary
					className="<%= User.class.getName() %>"
					classPK="<%= user.getUserId() %>"
				/>
			</div>

			<div class="lfr-asset-tags">
				<liferay-ui:asset-tags-summary
					className="<%= User.class.getName() %>"
					classPK="<%= user.getUserId() %>"
					message="tags"
				/>
			</div>
		</liferay-ui:search-container-column-text>

		<liferay-ui:search-container-column-text
			property="emailAddress"
			valign="top"
			value="<%= user.getEmailAddress() %>"
		/>

		<liferay-ui:search-container-column-text
			property="jobTitle"
			valign="top"
			value="<%=user.getJobTitle() %>"
		/>


		<liferay-ui:search-container-column-date
			name="birthday"
			valign="top"
			value="<%=user.getBirthday() %>"
        />


		<liferay-ui:search-container-column-text
			property="phones"
			valign="top"
			value= "<%= String.valueOf(user.getPhones()) %>"
		/>

		<%--<liferay-ui:search-container-column-jsp
			cssClass="entry-action"
			path="/foo_action.jsp"
			valign="top"
		/>--%>
	</liferay-ui:search-container-row>

	<liferay-ui:search-iterator />
</liferay-ui:search-container>



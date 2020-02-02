package com.liferay.docs.mvcportlet.portlet;

/*import com.liferay.blade.basic.model.Foo;
import com.liferay.blade.basic.service.FooLocalService;*/
//import com.liferay.docs.mvcportlet.portlet.UsersRestService;
import com.liferay.portal.kernel.exception.PortalException;
import com.liferay.portal.kernel.model.User;
import com.liferay.portal.kernel.portlet.bridges.mvc.MVCPortlet;
import com.liferay.portal.kernel.service.UserLocalService;

import java.io.IOException;
import java.util.Calendar;
import java.util.Date;

import javax.portlet.*;

import com.liferay.portal.kernel.servlet.SessionErrors;
import com.liferay.portal.kernel.servlet.SessionMessages;
import com.liferay.portal.kernel.util.Constants;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.PortalUtil;
import com.liferay.portal.kernel.util.Validator;
import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;

/**
 * @author Kseniia
 */
@Component(
        immediate = true,
        property = {
                "com.liferay.portlet.display-category=category.sample",
                "com.liferay.portlet.instanceable=true",
                "javax.portlet.display-name=Test",
                "javax.portlet.init-param.template-path=/",
                "javax.portlet.init-param.view-template=/view.jsp",
                "javax.portlet.name=com_liferay_docs_mvcportlet_portlet_Portlet",
                "javax.portlet.resource-bundle=content.Language",
                "javax.portlet.security-role-ref=power-user,user"
        },
        service = javax.portlet.Portlet.class
)
public class Portlet extends MVCPortlet {

   public UserLocalService getUserLocalService() { //FooLocalService
        return _userLocalService;
    }

   @Override
    public void processAction(
            ActionRequest actionRequest, ActionResponse actionResponse)
            throws IOException, PortletException {

        try {
            String cmd = ParamUtil.getString(actionRequest, Constants.CMD);

            if (cmd.equals(Constants.ADD) || cmd.equals(Constants.UPDATE)) {
               updateUser(actionRequest);
            }
            else if (cmd.equals(Constants.DELETE)) {
               deleteUser(actionRequest);
            }

            if (Validator.isNotNull(cmd)) {
                if (SessionErrors.isEmpty(actionRequest)) {
                    SessionMessages.add(actionRequest, "requestProcessed");
                }

                String redirect = ParamUtil.getString(
                        actionRequest, "redirect");

                actionResponse.sendRedirect(redirect);
            }
        }
        catch (Exception e) {
            throw new PortletException(e);
        }
    }

    @Override
    public void render(RenderRequest request, RenderResponse response)
            throws IOException, PortletException {

        //set service bean
        request.setAttribute("userLocalService", getUserLocalService());

        super.render(request, response);
    }

    protected void deleteUser(ActionRequest actionRequest) throws Exception {
        long userId = ParamUtil.getLong(actionRequest, "userId");

        getUserLocalService().deleteUser(userId);
    }

   protected void updateUser(ActionRequest actionRequest) throws Exception {
        long userId = ParamUtil.getLong(actionRequest, "userId");

        String field1 = ParamUtil.getString(actionRequest, "field1");
        String field2 = ParamUtil.getString(actionRequest, "field2");
       String field3 = ParamUtil.getString(actionRequest, "field3");
        String field5 = ParamUtil.getString(actionRequest, "field5");

        int dateMonth = ParamUtil.getInteger(actionRequest, "field4Month");
        int dateDay = ParamUtil.getInteger(actionRequest, "field4Day");
        int dateYear = ParamUtil.getInteger(actionRequest, "field4Year");
        int dateHour = ParamUtil.getInteger(actionRequest, "field4Hour");
        int dateMinute = ParamUtil.getInteger(actionRequest, "field4Minute");
        int dateAmPm = ParamUtil.getInteger(actionRequest, "field4AmPm");

        if (dateAmPm == Calendar.PM) {
            dateHour += 12;
        }

        Date field4 = PortalUtil.getDate(
                dateMonth, dateDay, dateYear, dateHour, dateMinute,
                PortalException.class);

        if (userId <= 0) {
            User user = getUserLocalService().createUser(0);

            user.setFirstName(field1);
            user.setEmailAddress(field2);
            user.setJobTitle(field3);
            user.setCreateDate(field4);

            user.isNew();


            getUserLocalService().addUser(user);
        }
        else {
            User user = getUserLocalService().fetchUser(userId);

            user.setUserId(userId);
            user.setFirstName(field1);
            user.setEmailAddress(field2);
            user.setJobTitle(field3);
            user.setCreateDate(field4);

            getUserLocalService().updateUser(user);

        }
    }

    @Reference
    private volatile UserLocalService _userLocalService;

}

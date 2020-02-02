package com.liferay.docs.mvcportlet.portlet;

import com.liferay.portal.kernel.portlet.bridges.mvc.MVCRenderCommand;

import javax.portlet.PortletException;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;

import org.osgi.service.component.annotations.Component;

/**
 * @author
 */
@Component(
        immediate = true,
        property = {
                "javax.portlet.name=com_liferay_docs_mvcportlet_portlet_Portlet",
                "mvc.command.name=mvcPath"
        },
        service = MVCRenderCommand.class
)
public class RenderCommand implements MVCRenderCommand {

    @Override
    public String render(
            RenderRequest renderRequest, RenderResponse renderResponse)
            throws PortletException {

        return "/edit_foo.jsp";
    }
}

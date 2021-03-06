/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.52
 * Generated at: 2015-02-27 15:37:41 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.action.page;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.sql.*;
import javax.naming.*;
import com.Trustwin.Admin.Project.Access.*;
import com.Trustwin.Admin.Project.Device.*;
import com.Trustwin.Admin.Project.Timezone.*;
import com.Trustwin.Admin.Project.Language.*;

public final class AccessDevice_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
  }

  public void _jspDestroy() {
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
        throws java.io.IOException, javax.servlet.ServletException {

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html; charset=euc-kr");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");

	AccessFunc Accfunc = new AccessFunc();
	DeviceFunc Devfunc = new DeviceFunc();
	TimeZoneFunc Timezonefunc = new TimeZoneFunc();
	LanguageFunc lanfunc = new LanguageFunc();
	
	int idxs = 0;
	if(request.getParameter("num") == null || request.getParameter("num").equals("")){
		AccessGroup[] group =  Accfunc.AccessGroupMenu();
		idxs = group[0].getIdx();
	}else{
		idxs = Integer.parseInt(request.getParameter("num"));
	}

	//DeviceInfo
	DeviceGroup[] device = null;
	device = Devfunc.GroupDefind();
	TimeZone[] time = null;
	time = Timezonefunc.TimeMenu();
	String lan = (String)session.getAttribute("nation");

      out.write("\r\n");
      out.write("<script type=\"text/javascript\">\r\n");
      out.write("\t\r\n");
      out.write("\tvar change = 0;\r\n");
      out.write("\r\n");
      out.write("\tfunction accessDeviceList(v){\r\n");
      out.write("\t\tif(v!=0){\r\n");
      out.write("\t\t\t$.ajax({      \r\n");
      out.write("\t\t\t    type:\"post\",  \r\n");
      out.write("\t\t\t    url:\"/TrustWinPro/action/ajax/AccessDeviceList.jsp\",   \r\n");
      out.write("\t\t\t    data: \"group=\" + v,\r\n");
      out.write("\t\t\t    success:function(args){   \r\n");
      out.write("\t\t\t        $(\"#devicelist\").html(args);      \r\n");
      out.write("\t\t\t    },   \r\n");
      out.write("\t\t\t    error:function(e){  \r\n");
      out.write("\t\t\t        alert(e.responseText);  \r\n");
      out.write("\t\t\t    }  \r\n");
      out.write("\t\t\t}); \r\n");
      out.write("\t\t}else{\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t}\r\n");
      out.write("\t}\r\n");
      out.write("\t\r\n");
      out.write("\tfunction allDeviceCheck(){\r\n");
      out.write("\t\tvar check = document.getElementsByName(\"checkD\");\r\n");
      out.write("\t\tif(change == 0){\r\n");
      out.write("\t\t\tfor(var i = 0 ; i < check.length;i++ ){\r\n");
      out.write("\t\t\t\tcheck[i].checked = true;\t\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\tchange = 1;\r\n");
      out.write("\t\t}else{\r\n");
      out.write("\t\t\tfor(var i = 0 ; i < check.length;i++ ){\r\n");
      out.write("\t\t\t\tcheck[i].checked = false;\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t\tchange = 0;\r\n");
      out.write("\t\t}\r\n");
      out.write("\t\t\r\n");
      out.write("\t}\r\n");
      out.write("\t\r\n");
      out.write("\tfunction accessDevice(){\r\n");
      out.write("\t\tdocument.getElementById(\"AccessDevice\").submit();\r\n");
      out.write("\t}\r\n");
      out.write("\t\r\n");
      out.write("\tfunction accessDeviceClose(){\r\n");
      out.write("\t\tdocument.getElementById(\"postitDevice\").style.display = \"none\";\r\n");
      out.write("\t}\r\n");
      out.write("\r\n");
      out.write("</script>\r\n");
      out.write("<div class=\"accessDevice\">\r\n");
      out.write("\t<form name=\"AccessDevice\" id=\"AccessDevice\" method=\"post\" action=\"/TrustWinPro/action/page/AccessDeviceAdd.jsp\">\r\n");
      out.write("\t<input type=\"hidden\" name=\"idx\" id=\"idx\" value=\"");
      out.print(idxs );
      out.write("\" >\r\n");
      out.write("\t\t<table>\r\n");
      out.write("\t\t\t<colgroup>\r\n");
      out.write("\t\t\t\t<col width=\"20%\" align=\"center\" >\r\n");
      out.write("\t\t\t\t<col width=\"80%\">\r\n");
      out.write("\t\t\t</colgroup>\r\n");
      out.write("\t\t\t<tr class=\"block\">\r\n");
      out.write("\t\t\t\t<td class=\"header\">");
      out.print(lanfunc.language(lan, 64) );
      out.write(" </td>\r\n");
      out.write("\t\t\t\t<td class=\"main\">\r\n");
      out.write("\t\t\t\t\t<select name=\"Device\" onchange=\"accessDeviceList(this.value);\" onload=\"accessDeviceList(this.value);\">\r\n");
      out.write("\t\t\t\t\t\t<option value = \"0\" >-- ");
      out.print(lanfunc.language(lan, 65));
      out.write(" --</option>\r\n");

	DeviceGroup[] deviceGroup = null;
	deviceGroup = Devfunc.GroupDefind();
	
	int lengthD = deviceGroup.length;
	DeviceGroup[] dev = new DeviceGroup[lengthD];	
	dev = Devfunc.SortGroupOne(deviceGroup);
	for(int i=0;i < dev.length;i++){

      out.write("\r\n");
      out.write("\t\t\t\t\t\t<option value = \"");
      out.print(dev[i].getIdx());
      out.write('"');
      out.write('>');
      out.print(dev[i].getGroupname() );
      out.write("</option>\r\n");

	}

      out.write("\r\n");
      out.write("\t\t\t\t\t</select>\r\n");
      out.write("\t\t\t\t</td>\r\n");
      out.write("\t\t\t</tr>\r\n");
      out.write("\t\t\t<tr>\r\n");
      out.write("\t\t\t\t<td colspan=\"2\">\r\n");
      out.write("\t\t\t\t\t<div id=\"devicelist\">\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t</td>\r\n");
      out.write("\t\t\t</tr>\r\n");
      out.write("\t\t</table>\r\n");
      out.write("\t\t<div class=\"timeZone\">\r\n");
      out.write("\t\t\t<span class=\"title\">");
      out.print(lanfunc.language(lan, 111));
      out.write("</span>\r\n");
      out.write("\t\t\t<select name=\"timeSelect\">\r\n");
      out.write("\t\t\t\t<option value = \"0\" >-- ");
      out.print(lanfunc.language(lan, 65));
      out.write(" --</option>\r\n");

	for(int i=0;i<time.length;i++){

      out.write("\r\n");
      out.write("\t\t\t\t<option value = \"");
      out.print(time[i].getTimeZoneName());
      out.write('"');
      out.write('>');
      out.print(time[i].getTimeZoneName() );
      out.write("</option>\r\n");

	}

      out.write("\r\n");
      out.write("\t\t\t</select>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t\t<div class=\"buttom\">\r\n");
      out.write("\t\t\t<a href=\"#DeviceInfo\" onclick=\"accessDevice();\"><img src=\"/TrustWinPro/action/image/interface/submit.png\"></a>\r\n");
      out.write("\t\t\t<a href=\"#DeviceInfo\" onclick=\"accessDeviceClose();\"><img src=\"/TrustWinPro/action/image/interface/delete.png\"></a>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t</form>\r\n");
      out.write("</div>");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try { out.clearBuffer(); } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}

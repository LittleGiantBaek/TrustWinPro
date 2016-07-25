<%@ page language="java" contentType="text/html; charset=euc-kr"
    pageEncoding="euc-kr"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="com.Trustwin.Admin.Project.Language.*" %>
<%@ page import="com.Trustwin.Admin.Project.Event.*" %>
<%
	LanguageFunc Lanfunc = new LanguageFunc();
	EventFunc Evtfunc = new EventFunc();
	
	int num[] = {0,0};	
	num = Evtfunc.EventYear();
	String year = request.getParameter("year");
	if(year==null||year==""){
		year = "0";
	}
	String lan = (String)session.getAttribute("nation");
%>
<div class="Event">
	<ul>
		<li><img src="/TrustWinPro/action/image/interface/reallog.png"><a href="#content" onclick="submit('realLog');" onkeypress="submit('realLog');" ><%=Lanfunc.language(lan, 120) %></a></li>
		<li><img src="/TrustWinPro/action/image/interface/searchlog.png"><a href="#content" onclick="submit('searchLog');" onkeypress="submit('searchLog');" ><%=Lanfunc.language(lan, 121) %></a>
			<ul>
<%
		for(int i = num[1];i<=num[0];i++){
%>
				<li style="padding-left:30px;"><img src="/TrustWinPro/action/image/interface/nieun Icon.png"><img src="/TrustWinPro/action/image/interface/searchlog-2.png"><a href="#in" onclick="changeYear(<%=i%>,<%=num[0]%>,<%=num[1]%>)"><%=i %> <%=Lanfunc.language(lan, 122) %>
				<img src="/TrustWinPro/action/image/interface/close.png" class="close<%=i %>" id="close<%=i %>" style="display:none;" />
				<img src="/TrustWinPro/action/image/interface/open.png" class="open<%=i %>" id="open<%=i %>"  />
				</a>
					<ul id="<%=i%>" class="Year" style="display:<%= Integer.parseInt(year)==i ? "block" : "none"%>">
<%
			for(int j=1;j<13;j++){
%>
						<li><img src="/TrustWinPro/action/image/interface/deviceIcon.png"><a href="#in" onclick="submitEvent(<%=i%>,<%=j%>)"><%=j %> <%=Lanfunc.language(lan, 123) %></a></li>
<%
			}
				
%>
					</ul>
				</li>
<%
		}
%>
			</ul>
		</li>
	</ul>
</div>
<form action="/TrustWinPro/action/index.jsp" name="Event" id="Event" method="post">
	<input type="hidden" value="Event" name="left" />
	<input type="hidden" value="" name="year" />
	<input type="hidden" value="" name="month" />
	<input type="hidden" value="Log" name="content" />
	<input type="hidden" value="searchLog" name="logtype" />
</form>
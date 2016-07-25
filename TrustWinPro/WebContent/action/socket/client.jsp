<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="com.Trustwin.Admin.Project.socket.*" %>
<%

	TCPClient client = new TCPClient("127.0.0.1", 3279);
	client.run();
	String send = "aa";
	client.output(send);
%>
<script type="text/javascript">
	function submit(){
<%
		client.output(send);	
%>
	}
</script>
<a href="#" onclick="submit();">Àü¼Û</a>

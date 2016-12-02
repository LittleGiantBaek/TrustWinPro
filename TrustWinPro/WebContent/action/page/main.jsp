<%@ page contentType="text/html;charset=utf-8" errorPage="/common/error/error.jsp"%>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
 

<script type="text/javascript" src="/TrustWinPro/action/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="/TrustWinPro/action/js/canvasjs.min.js"></script>
<script type="text/javascript" src="/TrustWinPro/action/js/jquery.canvasjs.min.js"></script>
 
<div class="main_chart" id="mainContent" >

		<div class="block_b" style="width:96%">
			<%-- 		<jsp:include page="/action/page/barChart.jsp" flush="false"></jsp:include> --%>
			<%-- <jsp:include page="/action/page/barChart3.jsp" flush="false"></jsp:include> --%>
			<jsp:include page="/action/page/barChart5.jsp" flush="false"></jsp:include>
		</div>
		
		<div class="new_block">
			<div class="new_block_b">
			<%--<jsp:include page="/action/page/pieChart.jsp" flush="false"></jsp:include> --%>
				<jsp:include page="/action/page/pieChart2.jsp" flush="false"></jsp:include>
			</div>
			<div class="new_block_b">
				<jsp:include page="/action/page/Geolocation.html" flush="false"></jsp:include>
			</div>	
		</div>
 	
	<div style="width:100%;" >
		<jsp:include page="/action/page/MainLog.jsp" flush="false"></jsp:include>
	</div>	
</div>


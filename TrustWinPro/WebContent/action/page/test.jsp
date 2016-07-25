<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<HTML>
<HEAD>
<TITLE>Print Sample</TITLE>
</HEAD>


<!-- MeadCo ScriptX -->

<object id=factory style="display:none"

classid="clsid:1663ed61-23eb-11d2-b92f-008048fdd814"

codebase="http://www.meadroid.com/scriptx/ScriptX.cab#Version=6,1,429,14">

</object> 
<script language="javascript">
function printWindow() {
factory.printing.header = "여기는 머릿글입니다."
factory.printing.footer = "여기는 바닥글입니다."
factory.printing.portrait = true
factory.printing.leftMargin = 30.0
factory.printing.topMargin = 30.0
factory.printing.rightMargin = 30.0
factory.printing.bottomMargin = 30.0
factory.printing.Print(false, window)
}
</script>

<BODY>
<object id=factory style="display:none" classid="clsid:1663ed61-23eb-11d2-b92f-008048fdd814" codebase="http://www.meadroid.com/scriptx/ScriptX.cab#Version=6,1,429,14">
</object>
<p>
This is Test Page...
</p>
<p>
안녕하십니까?<br>
korea.internet.com 입니다.
</p>
<input type="button" name="print" value="Print This Page..." onClick="printWindow();">
</BODY>
</HTML>


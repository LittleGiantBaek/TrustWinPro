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
factory.printing.header = "����� �Ӹ����Դϴ�."
factory.printing.footer = "����� �ٴڱ��Դϴ�."
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
�ȳ��Ͻʴϱ�?<br>
korea.internet.com �Դϴ�.
</p>
<input type="button" name="print" value="Print This Page..." onClick="printWindow();">
</BODY>
</HTML>


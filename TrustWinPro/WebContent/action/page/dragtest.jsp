<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
    <head>
        <title></title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <style type="text/css">
            #console { width: 30px; height: 2px; border: 1px solid #ccc; }
            table.ex1 {width:90%; margin:0 auto; text-align:right; border-collapse:collapse;padding:1px;height:2px;font-size:8px;}
        </style>
        <script type="text/javascript">
            function selectText() {
                var selectionText = "";
                if (document.getSelection) {
                    selectionText = document.getSelection();
                } else if (document.selection) {
                    selectionText = document.selection.createRange().text;
                }
                return selectionText;
            }
            
            document.onmouseup = function() {
                document.getElementById("test").value = selectText();
            }
        </script>
    </head>
    
    <body>
        <p>abcdefghijklmnopqrstuvwxyz</p>
        <p>마우스로 드래그해서 선택한 글 나오기</p>
        <div id="console"></div>
        <div><input type="text" value="" name="test" id="test" /></div>
        <div>
        	<table border=1 class="ex1" cellspacing="0">
        		<tr>
        			<td colspan="6">1</td>
        			<td colspan="6">2</td>
        			<td colspan="6">3</td>
        			<td colspan="6">4</td>
        			<td colspan="6">5</td>
        			<td colspan="6">6</td>
        			<td colspan="6">7</td>
        			<td colspan="6">8</td>
        			<td colspan="6">9</td>
        			<td colspan="6">10</td>
        			<td colspan="6">11</td>
        			<td colspan="6">12</td>
        			<td colspan="6">13</td>
        			<td colspan="6">14</td>
        			<td colspan="6">15</td>
        			<td colspan="6">16</td>
        			<td colspan="6">17</td>
        			<td colspan="6">18</td>
        			<td colspan="6">19</td>
        			<td colspan="6">20</td>
        			<td colspan="6">21</td>
        			<td colspan="6">22</td>
        			<td colspan="6">23</td>
        			<td colspan="6">24</td>
        		</tr>
        		<tr>
        			<td>1</td>
        			<td>2</td>
        			<td>3</td>
        			<td>4</td>
        			<td>5</td>
        			<td>6</td>
        			<td>1</td>
        			<td>2</td>
        			<td>3</td>
        			<td>4</td>
        			<td>5</td>
        			<td>6</td>
        			<td>1</td>
        			<td>2</td>
        			<td>3</td>
        			<td>4</td>
        			<td>5</td>
        			<td>6</td>
        			<td>1</td>
        			<td>2</td>
        			<td>3</td>
        			<td>4</td>
        			<td>5</td>
        			<td>6</td>
        			<td>1</td>
        			<td>2</td>
        			<td>3</td>
        			<td>4</td>
        			<td>5</td>
        			<td>6</td>
        			<td>1</td>
        			<td>2</td>
        			<td>3</td>
        			<td>4</td>
        			<td>5</td>
        			<td>6</td>
        			<td>1</td>
        			<td>2</td>
        			<td>3</td>
        			<td>4</td>
        			<td>5</td>
        			<td>6</td>
        			<td>1</td>
        			<td>2</td>
        			<td>3</td>
        			<td>4</td>
        			<td>5</td>
        			<td>6</td>
        			<td>1</td>
        			<td>2</td>
        			<td>3</td>
        			<td>4</td>
        			<td>5</td>
        			<td>6</td>
        			<td>1</td>
        			<td>2</td>
        			<td>3</td>
        			<td>4</td>
        			<td>5</td>
        			<td>6</td>
        			<td>1</td>
        			<td>2</td>
        			<td>3</td>
        			<td>4</td>
        			<td>5</td>
        			<td>6</td>
        			<td>1</td>
        			<td>2</td>
        			<td>3</td>
        			<td>4</td>
        			<td>5</td>
        			<td>6</td>
        			<td>1</td>
        			<td>2</td>
        			<td>3</td>
        			<td>4</td>
        			<td>5</td>
        			<td>6</td>
        			<td>1</td>
        			<td>2</td>
        			<td>3</td>
        			<td>4</td>
        			<td>5</td>
        			<td>6</td>
        			<td>1</td>
        			<td>2</td>
        			<td>3</td>
        			<td>4</td>
        			<td>5</td>
        			<td>6</td>
        			<td>1</td>
        			<td>2</td>
        			<td>3</td>
        			<td>4</td>
        			<td>5</td>
        			<td>6</td>
        			<td>1</td>
        			<td>2</td>
        			<td>3</td>
        			<td>4</td>
        			<td>5</td>
        			<td>6</td>
        			<td>1</td>
        			<td>2</td>
        			<td>3</td>
        			<td>4</td>
        			<td>5</td>
        			<td>6</td>
        			<td>1</td>
        			<td>2</td>
        			<td>3</td>
        			<td>4</td>
        			<td>5</td>
        			<td>6</td>
        			<td>1</td>
        			<td>2</td>
        			<td>3</td>
        			<td>4</td>
        			<td>5</td>
        			<td>6</td>
        			<td>1</td>
        			<td>2</td>
        			<td>3</td>
        			<td>4</td>
        			<td>5</td>
        			<td>6</td>
        			<td>1</td>
        			<td>2</td>
        			<td>3</td>
        			<td>4</td>
        			<td>5</td>
        			<td>6</td>
        			<td>1</td>
        			<td>2</td>
        			<td>3</td>
        			<td>4</td>
        			<td>5</td>
        			<td>6</td>
        			<td>1</td>
        			<td>2</td>
        			<td>3</td>
        			<td>4</td>
        			<td>5</td>
        			<td>6</td>
        		</tr>
        	</table>
        </div>
    </body>
</html>
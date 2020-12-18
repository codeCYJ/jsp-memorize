<%@page import="model.MemorizeDTO"%>
<%@page import="model.MemorizeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<link rel="stylesheet" href="css/viewForm.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@500&display=swap"
	rel="stylesheet">
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");

		String id = (String) session.getAttribute("id");
	%>
	<div id="wrap" align="center">
		<%
			MemorizeDAO dao = new MemorizeDAO();

			String result = (String) request.getAttribute("result");
			MemorizeDTO dto = (MemorizeDTO) request.getAttribute("dto");

			if (result == null) {
				result = "0";
			}
			if (result == "0") {
				dto = dao.selectOne(id);
				result = "Solve the question";
				if (dto == null) {
					dto = new MemorizeDTO();

					dto.setNo(0);
					dto.setContent("Answer the question"); // dto값이 없으면 script 실행이 안되서 임의의 변수를 넣어준다.
		%>
		<script>
			alert("데이터가 없습니다. 암기할 내용을 입력해 주세요.");
			location.href = "inputForm.jsp";
		</script>
		<%
			}
			} else if (result == "1") {
				result = "You are correct!";
			} else if (result == "2") {
				dto = dao.selectOne(id);
				result = "Invalid answer. Please try again.";
			}
		%>
		<div class="topiddiv" align="right">
			<span class="topid"> ID : <%=id%> <input class="logoutBtn"
				type="button" value="Logout"
				onclick="location.href='logoutProc.jsp'">
		</div>
		<form action="viewProc.jsp" method="post">
			<table>
					<p class="title">Test</p>
					<p class="subtitle">Memorize and test sentences that repeat the specified number of times.</p>
			</table>
			<table class="boxDiv">
				<tr class="sentenceNoTr">
					<%-- <td class="sentenceNo"><%=dto.getNo() %>번째 문장</td> --%>
					<td class="sentenceNo">Memorize sentences</td>
					<td id="timerBg" rowspan="2"></td>
					<td id="timeoutBg" class="timeout2" rowspan="2"></td>
				</tr>
				<tr>
					<td class="content" id="content"
						style="
	    				opacity: 0;
	    				animation: blink 3s <%=dto.getRepeat()%>;
	    	"><%=dto.getContent()%></td>
				</tr>
				<tr>
					<td><input class="testInp" placeholder="Write your answer here"
						type="text" name="answer"></td>
				</tr>
				<tr style="height: 10px"></tr>
				<tr>
					<td><input type="hidden" value="<%=dto.getNo()%>" name="no"></td>
					<td><input type="hidden" value="<%=dto.getContent()%>"
						name="content"></td>
				</tr>
				<tr></tr>
				<tr></tr>
				<tr align="center">
					<td class="subBtn"><input class="subInp" type="submit"
						value="Answer"></td>
					<td class="listBtn"><input class="listInp" type="button"
						value="List" onclick="location.href='listView.jsp'"></td>
					<td class="listBtn"><input class="listInp" type="button"
						value="Input" onclick="location.href='inputForm.jsp'"></td>
					<%
						if (result == "You are correct!") {
					%>
					<td class="nextBtn"><input class="nextInp" type="button"
						value="Next" onclick="location.href='viewForm.jsp'"></td>
					<%
						}
					%>
				</tr>
				<tr style="height: 10px"></tr>
				<tr>
					<td class="result" id="result"><%=result%></td>
				</tr>
			</table>
		</form>
		<script type="text/javascript">
			let count =
		<%=dto.getRepeat()%>
			;

			timer();

			let counter = setInterval(timer, 3000);

			function timer() {

				if (count == 0) {
					document.getElementById("timerBg").innerHTML = "&nbsp;";
					document.getElementById("timerBg").className = "Arrow";
					document.getElementById("timeoutBg").className = "timeout";
					clearInteval(counter);

					return;
				}
				document.getElementById("timerBg").innerHTML = count;

				count--;
			}
		</script>
		<!-- 
    <script type="text/javascript">
    
	    function compare() {
	  	    	  //alert(document.getElementById("content").innerText);
	  	    	  let content = document.getElementById("content").innerText;
	  	    	  let answer = document.getElementById("answer").value;
	  	    	  //alert(document.getElementById("answer").value);
	  	    	  if(content == answer){
	  	    		document.getElementById("result").innerText = "정답입니다!!!";	 // result 안의 내용을 정답입니다로 표시.
	  	    		location.href='viewProc.jsp';
	  	    	  }else{
	  	    		document.getElementById("result").innerText = "틀렸네요... 다시해보세요";	 // 그외의 경우는 틀렸다로 표시.
	  	    	  }
	  	    	  
	    }
  	</script>
     -->
	</div>
</body>
</html>
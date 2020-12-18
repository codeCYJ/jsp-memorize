<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<link rel="stylesheet" href="css/inputForm.css">
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
		<div class="topiddiv" align="right">
			<span class="topid"> ID : <%=id%>
			</span> <input class="logoutBtn" type="button" value="Logout"
				onclick="location.href='logoutProc.jsp'">
		</div>
		<form action="inputProc.jsp" method="post">
			<!-- action을 취했을 때(submit) inputProc.jsp로 정보를 넣는다. -->
			<table>
				<p class="title">Input</p>
				<p class="subtitle">외울 문장을 입력하세요.</p>
			</table>
			<div class="contentDiv">
				<table>
					<tr align="center">
						<td class="tdTxt">User</td>
						<td class="tdTxt-id"><%=id%></td>
					</tr>
					<tr align="center">
						<td class="tdTxt">Contents&nbsp;&nbsp;</td>
						<td><textarea class="tdTxtarea" rows="2" name="content"></textarea>
						</td>
					</tr>
					<tr align="center">
						<td class="tdTxt">Repeat&nbsp;&nbsp;</td>
						<td><input class="tdInput" type="number" value="3"
							width="100px" name="repeat"></td>
					</tr>
				</table>
				<table>
					<tr>
						<td><input class="inputSub" type="submit" value="Submit">
							<input class="inputRes" type="reset" value="Reset">
							</form> <input class="testBtn" type="button"
							onclick="location.href='viewForm.jsp'" value="Test"/> <input
							class="testBtn" type="button"
							onclick="location.href='listView.jsp'" value="List"/></td>
					</tr>
				</table>
			</div>
	</div>

</body>
</html>
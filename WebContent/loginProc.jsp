<%@page import="model.MbDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
	<%
    	request.setCharacterEncoding("UTF-8");
	
    	String id = request.getParameter("id");
    	String pw = request.getParameter("pw");
    	
    	MbDAO dao = new MbDAO();
    	boolean checkPw = dao.comparePw(id, pw);
    	if(checkPw){
    		session.setAttribute("id", id);
    		response.sendRedirect("inputForm.jsp");
    	}else{
    %>
    	<script>
    		alert("아이디 혹은 비밀번호가 일치하지 않습니다.");
    		history.go(-1);
    	</script>
    <%
    	}
    %>
</body>
</html>
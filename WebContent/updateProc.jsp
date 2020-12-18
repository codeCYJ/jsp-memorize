<%@page import="model.MemorizeDAO"%>
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
	    
		String id = (String)session.getAttribute("id");
    	String checkId = request.getParameter("id");
    	int no = Integer.parseInt(request.getParameter("no"));
    	String content = request.getParameter("content");
    	MemorizeDAO dao = new MemorizeDAO();
    	
    	if(checkId.equals(id)){
    		dao.update(no, content);
    		response.sendRedirect("listView.jsp");
    	}else{
    %>
    	<script>
    		alert("다른 사람의 글을 수정 할 수 없습니다.");
    		history.go(-1);
    	</script>
    <%	
    	}
    %>
    
</body>
</html>
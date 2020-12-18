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
    	int no = Integer.parseInt(request.getParameter("no"));   //no 는 primary key 라서 no만 삭제하면 해당 항목 list 삭제 됨.
    	String checkId = request.getParameter("id");
    	MemorizeDAO dao = new MemorizeDAO();
    	
    	if(checkId.equals(id)){
    		dao.delete(no);
    		response.sendRedirect("listView.jsp");
    	}else{
    %>
    	<script>
    		alert("다른 사람의 글을 삭제 할 수 없습니다.");
    		history.go(-1);
    	</script>
    <%	
    	}
    %>
    %>
</body>
</html>
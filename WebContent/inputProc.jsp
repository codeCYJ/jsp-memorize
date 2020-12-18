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
    %>
    
    <jsp:useBean id="dto" class="model.MemorizeDTO">
    	<jsp:setProperty name="dto" property="*" />
    </jsp:useBean>		<!-- DTO에서 항목들을 불러와서 dto변수에 모든 항목을 추가. -->
    
    <%
    	dto.setId((String)session.getAttribute("id"));
    
    	MemorizeDAO dao = new MemorizeDAO();
    	dao.insert(dto);		  // dto에서 불러온 항목에 dao 의 insert 를 사용한다.
    		
    	response.sendRedirect("inputForm.jsp");		 // inputForm.jsp로 돌아간다.
    %>
</body>
</html>
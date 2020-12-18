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
</head>
<body>
    <%	
    	request.setCharacterEncoding("UTF-8");	// 내용을 불러올 때만 UTF-8을 사용.
    	String id = (String)session.getAttribute("id");
    
    	String result = "0";
    	int no = Integer.parseInt(request.getParameter("no"));	//viewForm 에서 보낸 no를 불러온다.
    	String content = request.getParameter("content");		//viewForm 에서 보낸 content를 불러온다.
    	String answer = request.getParameter("answer");			//viewForm 에서 보낸 answer를 불러온다.
    	if(content.equals(answer)){
	   		MemorizeDAO dao = new MemorizeDAO();
    		dao.updateCompleted(no);							//결과값이 같다면 no의 항목을 dao의 update query사용.
    		MemorizeDTO dto = dao.selectPrev(no);
    		request.setAttribute("dto", dto);
    		result = "1";					//result 값을 1로 변경하여 viewForm으로 다시 돌려보냄.
    	} else{
    		result = "2";					//result 값을 2으로 변경하여 viewForm으로 다시 돌려보냄.
    	}
    	request.setAttribute("result", result);
		RequestDispatcher rd = request.getRequestDispatcher("viewForm.jsp"); // viewForm 에서 요청한 결과값을 처리하고 결과내용을 viewForm의 결과에 포함시킨다.
		rd.forward(request, response);
    %>
</body>
</html>
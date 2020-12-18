<%@page import="model.MemorizeDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.MemorizeDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/listView.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@500&display=swap" rel="stylesheet">
    <title>Document</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
	    
		String id = (String)session.getAttribute("id");
	%>
    	<!-- 게시글 보기 countering 설정에 필요한 변수 선언하기 -->
    <%
        		// 한 화면에 보여질 게시글의 개수 지정하기
            	int pageSize = 10;
            	
         		// 현재 counter를 클릭한 번호값 가져오기
            	String pageNum = request.getParameter("pageNum");
            	
            	// 처음 listView.jsp를 클릭하거나 수정, 삭제하는 등 다른 페이지에서 이 페이지로 넘어오는 경우,
        		// pageNum 값이 없으므로 null로 처리해 줌  ex) response.sendRedirect("listView.jsp") 한 경우
        		// pageNum 값은 넘어오지 않음  <-- counter를 눌러서 넘어오지 않고 direct로 넘어옴
        		// 새로 작성한 글이 페이지 최상단에 위치하는 경우
         		
            	if(pageNum == null){
            		pageNum = "1";
            	}
            	// 전체 글의 개수를 저장하는 변수
            	int count = 0;
            	// 게시글 번호를 저장하는 변수
            	int number = 0;
            	
            	// 현재 보고자 하는 페이지 숫자를 저장함
            	int currentPage = Integer.parseInt(pageNum);
            	
            	// 게시글 전체 내용을 jsp로 가져옴
            	MemorizeDAO dao = new MemorizeDAO();
            	
            	// 전체 게시글의 개수를 읽어들이는 메소드 호출하기
            	count = dao.getAllCount();
            	
            	// 현재 page에 보여줄 시작 번호 설정  <-- DB에서 불러올 시작 번호
            	int startRow = (currentPage-1)*pageSize+1;
            	int endRow = currentPage * pageSize;
            	
            	String mode = request.getParameter("mode");
            	
            	if(mode == null){
            		mode = "all";
            	}
            	ArrayList<MemorizeDTO> list = null;
            	
            	if(mode.equals("all")){
	            	// 게시글 전체 내용을 가져오는 메소드 호출하기 - 최신 글 10개를 기준으로 게시글을 return 함
	            	list = dao.selectAll(startRow, endRow);
            	}else if(mode.equals("mine")){
            		list = dao.selectMine(startRow, endRow, id);
            	}
            	
            	// table 에 표시할 게시글 번호 지정하기
            	number = count - (currentPage-1) * pageSize;
        %>
    
    <div class="wrap" align="center">
    	<div class="topiddiv" align="right">
	    	<span class="topid"> ID : <%=id %> </span>
	    	<input class="logoutBtn" type="button" value="Logout" onclick="location.href='logoutProc.jsp'">
	    </div>
    		<p class="title">List</p>
    	<br><br><br>
    	<table class="wrap-table" border="1px">
    		<tr>
    			<th>No</th>
    			<th class="content">Contents</th>
    			<th>Repeat</th>
    			<th>User</th>
    			<th>Complete</th>
    			<th>Modify</th>
    			<th>Delete</th>    			
    		</tr>
    <%
    	for(int i=0; i < list.size(); i++){
    		MemorizeDTO dto = list.get(i);
    %>
    		<form action="updateProc.jsp" method="post">
    		<tr class="table-items">
    			<td><%=dto.getNo() %></td>
    			<td><input class="contentInp" type="text" value="<%=dto.getContent() %>" name='content'></td>
    			<td><%=dto.getRepeat() %></td>
    			<td><%=dto.getId() %></td>
    <%
    			if(dto.getCompleted() == 1){
    %>
    			<td>Complete</td>
    <%
    			} else{
    %>
    			<td>Incomplete</td>
    <%
    			}
    %>
    			<td>
    				<input type="hidden" name="id" value="<%=dto.getId() %>" >
    				<input type="hidden" name="no" value="<%=dto.getNo() %>" >
    				<input class="btn" type="submit" value="Modify"></form>
    			</td>
    			<td>
    				<input class="btn" type="button" value="Delete" onclick="location.href='deleteProc.jsp?no=<%=dto.getNo() %>&id=<%=dto.getId() %>'">
    			</td>		    			
    		</tr>
    <%
    	}
    %>
    		<tr style="height: 60px;">
    			<td colspan="7" align="center">
    				<input class="btn2" type="button" value="Input" onclick="location.href='inputForm.jsp'"> &nbsp;
    				<input class="btn2" type="button" value="Test" onclick="location.href='viewForm.jsp'"> &nbsp;
    				<input class="listBtn" type="button" value="My posts" onclick="location.href='listView.jsp?mode=mine'"> &nbsp;
    				<input class="listBtn" type="button" value="All posts" onclick="location.href='listView.jsp?mode=all'">
    			</td>
    		</tr>
    	</table>
    	<p class="page">
    				<!-- page countering -->
    		<%
    			if(count > 0){
    				// countering 숫자를 얼마까지 보여줄지 설정함
    				int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
    				
    				// 시작 페이지 숫자 설정함
    				int startPage = 1;
    				
    				if(currentPage % 10 != 0){
    					startPage = (int)(currentPage / 10) * 10 + 1;
    				}else{
    					startPage = ((int)(currentPage / 10)-1) * 10 + 1;
    				}
    				// countering 숫자
    				int pageBlock = 10;
    				// 화면에 보여질 page의 마지막 숫자
    				int endPage = startPage + pageBlock - 1;
    				
    				if(endPage > pageCount){
    					endPage = pageCount;
    				}
    				// [이전] 링크
    				if(startPage > 10){
    				%>
    					<a href="listView.jsp?pageNum=<%=startPage - 10 %>">[이전]</a>
    				<%
    				}
    				// paging 처리하기
    				for(int i = startPage; i <= endPage; i++){
    				%>
    					<a href="listView.jsp?pageNum=<%=i %>">[<%=i %>]</a>
    				<%
    				}
    				// [다음] 링크
    				if(endPage < pageCount){
    				%>
    					<a href="listView.jsp?pageNum=<%=startPage + 10 %>">[다음]</a>    				
    				<%
    				}
    			}
    		%>
    	</p>
    </div>
</body>
</html>
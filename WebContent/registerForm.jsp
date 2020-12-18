<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/registerForm.css">
	<link rel="preconnect" href="https://fonts.gstatic.com">
	<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@500&display=swap" rel="stylesheet">
    
    <title>Document</title>
</head>
<body>
    <div id="wrap" align="center">
    	<form action="registerProc.jsp" method="post">
    		<h2 class="title">Sign Up</h2>
    		<div class="regDiv">
	    		<table>
	    			<tr>
	    				<td class="tdTxt">I D</td>
	    				<td>
	    					<input class="tdInput" type="text" name="id">
	    				</td>
	    			</tr>
	    			<tr>
	    				<td class="tdTxt">PW</td>
	    				<td>
	    					<input class="tdInput" type="password" name="pw">
	    				</td>
	    			</tr>
	    			<tr>
	    				<td colspan="2" align="center">
	    					<input class="testBtn" type="submit" value="Sign up">
	    					<input class="testBtn" type="reset" value="Reset">
	    				</td>
	    			</tr>
	    		</table>
    		</div>
    	</form>
    </div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="css/intro.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@500&display=swap" rel="stylesheet">

<title>Document</title>
</head>
<body>
  <p class="typing-txt"> Project : Memento</p> 
  <div class="typingdiv"><p class="typing"></p></div> 
	<div class="wrap" align="center">
		<form action="loginProc.jsp" method="post">
			<div class="loginDiv">
				<table>
					<br>
					<br>
					<tr>
						<td class="tdTxt">I D</td>
						<td><input class="tdInput" type="text" name="id"></td>
					</tr>
					<tr></tr>
					<tr>
						<td class="tdTxt">PW</td>
						<td><input class="tdInput" type="password" name="pw"></td>
					</tr>
				</table>
				<div class="btndiv">
					<input class="btn" type="submit" value="Sign in"> <input
						class="btn" type="button" value="Sign up"
						onclick="location.href='registerForm.jsp'">
				</div>
			</div>
		</form>
	</div>
</body>
<script
      src="https://code.jquery.com/jquery-3.5.1.js"
      integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
      crossorigin="anonymous"
    ></script>
<script type="text/javascript">
	var typingBool = false; 
    var typingIdx=0; 
    var typingTxt = $(".typing-txt").text(); // 타이핑될 텍스트를 가져온다 
    typingTxt=typingTxt.split(""); // 한글자씩 자른다. 
    if(typingBool==false){ // 타이핑이 진행되지 않았다면 
       typingBool=true; 
       
       var tyInt = setInterval(typing,100); // 반복동작 
     } 
     
     function typing(){ 
       if(typingIdx<typingTxt.length){ // 타이핑될 텍스트 길이만큼 반복 
         $(".typing").append(typingTxt[typingIdx]); // 한글자씩 이어준다. 
         typingIdx++; 
       } else{ 
         clearInterval(tyInt); //끝나면 반복종료 
       } 
     }
</script>
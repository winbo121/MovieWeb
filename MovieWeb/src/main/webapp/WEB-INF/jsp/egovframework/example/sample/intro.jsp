<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="theme-color" content="#000000" />
<meta name="viewport"
	content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />
<meta HTTP-EQUIV="Refresh" CONTENT="6;URL=./home.do">
<title>무비누림</title>
<script
	src='https://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js'></script>
<script>
		$(document).ready(function() {

			setTimeout(function() {

				$("#loadingimg").fadeIn(3000);

			});

		});
	</script>
<style type="text/css">
body {
	background: #1C1C1C;
}

img {
	position: absolute; 
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
}
</style>
</head>

<body>

	<img id="loadingimg" style="display: none;" src="css/egovframework/img/intro.gif"
		alt="" width="100%">


</body>

</html>


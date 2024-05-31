<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.net.URL"%>
<%@ page import="java.net.HttpURLConnection"%>
<%@ page import="java.io.BufferedReader"%>
<%@ page import="java.io.InputStreamReader"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="theme-color" content="#000000" />
<meta name="viewport"
	content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />
<meta property="og:type" content="website"/>
<meta property="og:url"  content="https://86d7ed83.ngrok.io/Movie_web/intro.jsp"/>
<meta property="og:description" content="드루와 드루와 영화 찾으러"/>
<meta property="og:image" content="https://cdn.pixabay.com/photo/2017/11/24/10/43/admission-2974645_1280.jpg"/>
<link rel="stylesheet" type="text/css" href="css/egovframework/Home.css" />
<link rel="stylesheet" type="text/css" href="css/egovframework/Location.css" />
<link rel="stylesheet" type="text/css" href="css/egovframework/Movie.css" />
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<title>무비누림</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
	
		String pagefile = request.getParameter("pagefile");
		if (pagefile == null) {
			pagefile = "content.jsp";
        }
		%>
	<% 
		if(pagefile.contains("movie")){
	%>
	<jsp:include page="header.jsp" />
	<%
		} else {
	%>
		<h1 id="movie_title">가장 인기 있는 영화</h1>
	<%
		}
	%>
	<!--  content 시작  -->
	<div id="root">
	<jsp:include page="<%=pagefile%>" flush="true"/>
	</div>
	<!--  content 끝  -->

	<!--  footer 시작   -->
	<%@include file="floatingButton.jsp"%>
	<!--  footer 끝  -->
</body>
</html>
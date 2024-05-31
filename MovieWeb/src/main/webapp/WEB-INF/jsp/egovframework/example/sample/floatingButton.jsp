<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="css/egovframework/floating.css"/>

<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type='text/javascript'>
	//<![CDATA[
	// 사용할 앱의 JavaScript 키를 설정해 주세요.
	Kakao.init("f3e1b7156e65df896b6e836e9252e216");

	function sendLink() {
		Kakao.Link
				.sendDefault({
					objectType : 'location',
					address : '서울특별시 종로구 종로12길 15 5층 (관철동 13-13)',
					addressTitle : '솔데스크',
					content : {
						title : '무비누림',
						description : '#영화 #욜로 #요즘 영화 뭐하지? #취미',
						imageUrl : 'https://cdn.pixabay.com/photo/2017/11/24/10/43/admission-2974645_1280.jpg',
						link : {
							mobileWebUrl : 'http://localhost:8080/MovieWeb/intro.do'

						}
					},
					buttons : [ {
						title : '모바일 웹으로 보기',
						link : {
							mobileWebUrl : 'http://localhost:8080/MovieWeb/intro.do'
						}
					} ]
				});
	}
	//]]>

	function shareFB()
	{
		window
				.open('https://www.facebook.com/sharer/sharer.php?u=http://localhost:8080/MovieWeb/intro.do');
	}
</script>


<div class="flBtn flBtn-position-br flBtn-size-medium">
	<input type="checkbox">
	<a href="" data-role="main">
		<i class="fas fa-plus"></i>		
	</a>
	<ul class="flBtn-first">
		<li><a href="?pagefile=map.jsp" tooltip="map"><i class="fas fa-map-signs"></i></a></li>
		<li><a href="?pagefile=movie_search.jsp" tooltip="search"><i class="fas fa-search"></i></a></li>
		<li><a href="?pagefile=movie.jsp" tooltip="movie"><i class="fas fa-film"></i></a></li>
		<li><a href="/MovieWeb/home.do" tooltip="홈"><i class="fas fa-home"></i></a></li>
		
	</ul>
	<ul class="flBtn-second">
	<li><a id="kakao-link-btn" href="javascript:sendLink()" tooltip="kakao"> <img
		src="css/egovframework/img/kakao-talk.svg" style="width: 20px; height: 40px;"></a></li>
		<li><a href="javascript:shareFB();" tooltip="Facebook"><i class="fab fa-facebook-f"></i></a></li>

		<script type="text/javascript">
		
			// 모바일 공유
			function share_band(content, url){
			    content = content + " " + url;
			    var param = 'create/post?text=' + encodeURIComponent(content);
			    if (navigator.userAgent.match(/android/i)) {
			        setTimeout(function(){
			            location.href = 'intent://' + param + '#Intent;package=com.nhn.android.band;end';
			        }, 100);
			    } else if (navigator.userAgent.match(/(iphone)|(ipod)|(ipad)/i)) {
			        location.href = 'bandapp://' + param;
			    }
			 
			 /*웹 공유
			    content = content + " " + url;
			    var shareUrl = "https://www.band.us/plugin/share?body="+encodeURIComponent(content);
			    window.open(shareUrl, "share_band", "width=410, height=540, resizable=no");
			 */   
			}
			</script>

		<li><a href="javascript:void(0);" onclick="share_band('무비누림', 'http://localhost:8080/MovieWeb/intro.do');return false;" tooltip="Band"><img
		src="css/egovframework/img/naverband_icon.JPG" style="width: 25px; height: 25px; margin-top: 7px;"></a></li>
	</ul>
</div>

<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>

<script type="text/javascript">

$.ajax({
 
 type:"get",
 url:"https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=9ad6e90979035c5eda25f7a40305c3dd&language=ko-KR&page=1",
 dataType:"json",
 data:JSON.stringify({
  
  
 }),
 success:function(result){
 
  $(result).each(function () {
  
  $(this.results).each(function () {
  
   var img = (JSON.stringify(this.poster_path)).replace(/"/g, "");
   var title = JSON.stringify(this.title).replace(/"/g, "");
   
   // 출력을 위한 동적 요소의 생성
     
   var div = $("<div>");
   
   var movie = $("<span>").attr("class", "movie__Column").html("<img src='https://image.tmdb.org/t/p/w500"+img+"'alt="+title+" title="
          +title+" class='movie__Poster'>");
   
   // 조립과 출력
   div.append(movie);
   $("#Home").append(div);
   
   });
  });
 }
})
</script>

<div id="Home"></div> 
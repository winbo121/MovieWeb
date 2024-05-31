<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script type="text/javascript">
function search(){
	var title=$("#title").val()
	$(".App").html("");
	
	$.ajax({
		
		type:"get",
		url:"https://api.themoviedb.org/3/search/movie?api_key=9ad6e90979035c5eda25f7a40305c3dd&language=ko-KR&query="+title,
		dataType:"json",
		data:JSON.stringify({
			
			
		}),
		success:function(result){
			
			$(result).each(function () {
			
			$(this.results).each(function () {
				
				
				var img = (JSON.stringify(this.poster_path)).replace(/"/g, "");
				var title = JSON.stringify(this.title).replace(/"/g, "");
				var original_title = JSON.stringify(this.original_title).replace(/"/g, "");
				var time = JSON.stringify(this.release_date);
				var content = JSON.stringify(this.overview).replace(/"/g, "");
				var userRating =JSON.stringify(this.vote_average);
				
				var id = JSON.stringify(this.id);
				var div = $("<div>");
			
				$.ajax({
					
					type:"get",
					url:"https://api.themoviedb.org/3/movie/"+id+"/videos?api_key=9ad6e90979035c5eda25f7a40305c3dd",
					dataType:"json",
					data:JSON.stringify({
						
						
					}),
					success:function(result){
					
											
						$(result).each(function () {
						
						
						$(this.results[0]).each(function () {
						
							
							
							var key = (JSON.stringify(this.key)).replace(/"/g, "");
							var trailer = $("<div>").html("<iframe src='https://www.youtube.com/embed/"+key+"'></iframe>").addClass("movie__Trailer");
							div.append(trailer);
							
							});
						
						});
					}
				
				})
				
				// 출력을 위한 동적 요소의 생성
				var div = $("<div>").attr("id", "movie1");
			    var movie = $("<div>").attr("class", "movie__Column").html("<img src='https://image.tmdb.org/t/p/w500"+img+"'alt="+title+" title="+title+" class='movie__Poster'>");
			    var movie1 = $("<div>").attr("class", "movie__vote").html(userRating);
			    var movie2 = $("<div>").html("<h1>"+title+"</h1>"+"<div class='movie__Time'>"+time+"</div>"+"<div class='movie__Entitle'>"+
								original_title+"</div>"+"<div class='movie__Synopsis'>"+content+"</div>").addClass("movie__Column");
				
				// 조립과 출력
				div.append(movie).append(movie1).append(movie2);
				$(".App").append(div);
				
				});
			});
		}
	})



	var page = 2;

	$(window).scroll(function() {
		
	    if ($(window).scrollTop() == $(document).height() - $(window).height()) {
	    	$.ajax({
	    		
	    		type:"get",
				url:"https://api.themoviedb.org/3/search/movie?api_key=9ad6e90979035c5eda25f7a40305c3dd&language=ko-KR&query="+title+"&page="+page++,
				dataType:"json",
				data:JSON.stringify({
					
					
				}),
				success:function(result){	
					
					$(result).each(function () {
						
					$(this.results).each(function () {
						
						var img = (JSON.stringify(this.poster_path)).replace(/"/g, "");
						var title = JSON.stringify(this.title).replace(/"/g, "");
						var original_title = JSON.stringify(this.original_title).replace(/"/g, "");
						var time = JSON.stringify(this.release_date);
						var content = JSON.stringify(this.overview).replace(/"/g, "");
						var userRating =JSON.stringify(this.vote_average);
						
						var id = JSON.stringify(this.id);
	   				    var div = $("<div>");
	   			
	   				$.ajax({
	   					
	   					type:"get",
	   					url:"https://api.themoviedb.org/3/movie/"+id+"/videos?api_key=9ad6e90979035c5eda25f7a40305c3dd",
	   					dataType:"json",
	   					data:JSON.stringify({
	   						
	   						
	   					}),
	   					success:function(result){
	   					
	   											
	   						$(result).each(function () {
	   						
	   						
	   						$(this.results[0]).each(function () {
	   						
	   							
	   							
	   							var key = (JSON.stringify(this.key)).replace(/"/g, "");
	   							var trailer = $("<div>").html("<iframe src='https://www.youtube.com/embed/"+key+"'></iframe>").addClass("movie__Trailer");
	   							div.append(trailer);
	   							
	   							});
	   						
	   						});
	   					}
	   				
	   				})
						// 출력을 위한 동적 요소의 생성
						var div = $("<div>").attr("id", "movie1");
	   			 		var movie = $("<div>").attr("class", "movie__Column").html("<img src='https://image.tmdb.org/t/p/w500"+img+"'alt="+title+" title="+title+" class='movie__Poster'>");
				    	var movie1 = $("<div>").attr("class", "movie__vote").html(userRating);
				    	var movie2 = $("<div>").html("<h1>"+title+"</h1>"+"<div class='movie__Time'>"+time+"</div>"+"<div class='movie__Entitle'>"+
									original_title+"</div>"+"<div class='movie__Synopsis'>"+content+"</div>").addClass("movie__Column");
						
						// 조립과 출력
						div.append(movie).append(movie1).append(movie2);
						$(".App").append(div);
									
						});	
					});
				}
			})
	    }
	});

}
</script>
 <div class="search-container">
<input type="text" id="title" placeholder="Search">
<img class="search-icon" src="http://www.endlessicons.com/wp-content/uploads/2012/12/search-icon.png" onclick="search()">
</div>
<div class="App"></div>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript">

var now1=new Date();

var now2=new Date();

var day11 = new Date(now1.setDate(now1.getDate() - 7));	// 7일전

var day22 = new Date(now2.setDate(now2.getDate() - 1));	// 어제

/**
 *  yyyyMMdd 포맷으로 반환
 */
function getFormatDate(date){
    var year = date.getFullYear();              //yyyy
    var month = (1 + date.getMonth());          //M
    month = month >= 10 ? month : '0' + month;  //month 두자리로 저장
    var day = date.getDate();                   //d
    day = day >= 10 ? day : '0' + day;          //day 두자리로 저장
    return  year + '-' + month + '-' + day;       //'-' 추가하여 yyyy-mm-dd 형태 생성 가능
}

var day1=getFormatDate(day11);

var day2=getFormatDate(day22);


console.log(day1);

console.log(day2);

$.ajax({
	
	type:"get",
	url:"https://api.themoviedb.org/3/discover/movie?api_key=9ad6e90979035c5eda25f7a40305c3dd&primary_release_date.gte="+day1+"&primary_release_date.lte="+day2+"&language=ko-KR&page=1",
	dataType:"json",
	data:JSON.stringify({
		
		
	}),
	success:function(result){
	
		$(result).each(function () {
		
		$(this.results).each(function () {
		
			var img = (JSON.stringify(this.poster_path)).replace(/"/g, "");
			var title = JSON.stringify(this.title).replace(/"/g, "");
			var original_title = JSON.stringify(this.original_title).replace(/"/g, "");
			var time = JSON.stringify(this.release_date).replace(/"/g, "");
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
			var div = $("<div>").attr("id", "movie");
      
			var movie = $("<div>").attr("class", "movie__Column").html("<img src='https://image.tmdb.org/t/p/w500"+img+"'alt="+title+" title="
					     +title+" class='movie__Poster'>");
			
			var movie1 = $("<div>").html("<h1>"+title+"</h1>"+"<div class='movie__Time'>"+time+"</div>"+"<div class='movie__Entitle'>"+
								original_title+"</div>"+"<div class='movie__Entitle'>"
								+userRating+"</div>"+"<div class='movie__Synopsis'>"+content+"</div>").addClass("movie__Column");
			
			// 조립과 출력
			div.append(movie).append(movie1);
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
			url:"https://api.themoviedb.org/3/discover/movie?api_key=9ad6e90979035c5eda25f7a40305c3dd&primary_release_date.gte="+day1+"&primary_release_date.lte="+day2+"&language=ko-KR&page="+(page++),
			dataType:"json",
			data:JSON.stringify({
				
				
			}),
			success:function(result){	
				
				$(result).each(function () {
					
				$(this.results).each(function () {
				
					var img = (JSON.stringify(this.poster_path)).replace(/"/g, "");
					var title = JSON.stringify(this.title).replace(/"/g, "");
					var original_title = JSON.stringify(this.original_title).replace(/"/g, "");
					var time = JSON.stringify(this.release_date).replace(/"/g, "");
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
					var div = $("<div>").attr("id", "movie");
			        var movie = $("<div>").attr("class", "movie__Column").html("<img src='https://image.tmdb.org/t/p/w500"+img+"'alt="+title+" title="+title+" class='movie__Poster'>");
			        var movie1 = $("<div>").html("<h1>"+title+"</h1>"+"<div class='movie__Time'>"+time+"</div>"+"<div class='movie__Entitle'>"+
								original_title+"</div>"+"<div class='movie__Entitle'>"
								+userRating+"</div>"+"<div class='movie__Synopsis'>"+content+"</div>").addClass("movie__Column");
					
					// 조립과 출력
					div.append(movie).append(movie1);
					$(".App").append(div);
								
					});	
				});
			}
		})
    }
});


</script>
<body>
	<div class="App"></div>
</body>
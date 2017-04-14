function copyToClipboard(elementId) {
  var aux = document.createElement("input");
  aux.setAttribute("value", document.getElementById(elementId).innerHTML);
  document.body.appendChild(aux);
  aux.select();
  document.execCommand("copy");
  document.body.removeChild(aux);
}

$(document).ready(function(){
	$(".header > a").mouseenter(function(){
		$(this).css("border-top","1px solid white");
	})
	$(".header > a").mouseleave(function(){
		$(this).css("border-top","0px solid white");
	})

	$(".header > button").mouseenter(function(){
		$(this).css("background","rgba(0,0,50,0.1)")
	})
	$(".header > button").mouseleave(function(){
		$(this).css("background","")
	})

	$(".url_list").on("mouseleave","button",function(){
		$(this).css("background-color","white")
		$(this).css("color","orangered")
		$(this).css("border-color","orangered")
	})

	$(".url_list").on("mouseenter","button",function(){
		$(this).css("background-color","orangered");
		$(this).css("color","white");
		$(this).css("border-color","white");
	})


// this ID here refers to the form where the usesr types in a URL, you may have a different name for the ID. Edit the code accordingly.
  $('form').submit(function(e){ 
    e.preventDefault();         
    $.ajax({
      url: '/urls', //this refers to the route post '/url'
      method: 'post',
      data: $(this).serialize(),
      dataType: 'json', 

      success: function(data){
      	$("#flash").html("")

	      // write some code here to display the shortened URL
	      // $("#table").html(data);
	      $(".url_list tr:first-child").before("<tr><td> <a href=\""+data.original_url+"\" id=\"title\">"+
						data.title+
						"</a><br><a href=\""+data.original_url+"\" id=\"long_url\">"+
						data.original_url+
						"</a><br>"+
						"<div id=\"short_url\"><span id =\""+data.short_url+"\">localhost:9393/"+data.short_url+"</span>"+
						"<button type=\"button\" id=\"copy\" onclick=\"copyToClipboard(\'"request.host_with_port+"/"+data.short_url+"\')\">COPY</button></div>"+
						"<div id=\"clickcount\">"+data.click_count+"<img src=\"/img/bar-chart.png\" id=\"barchart\"></div></td></tr>");
			

			$(".url_list tr:first-child td").hide(0.00001)
			$(".url_list tr:first-child td").slideDown("slow");
	  },
// @url.errors.messages.values.first.first
	  error: function(data){
	  	$("#flash").html(data.responseText)
	    $("#flash").hide(0.00001)
      	$("#flash").slideDown("slow");
	  }  

    }); // end of function .ajax
  }); // end of function .submit
})
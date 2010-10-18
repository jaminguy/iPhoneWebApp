<!DOCTYPE html>
<html>
  <head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
	<title>iTrip</title>
	
	<meta name="viewport" content="width=480px, user-scalable=no"/>
	<meta name="apple-mobile-web-app-capable" content="yes"/>
	<link rel="apple-touch-icon-precomposed" href="apple-touch-icon-precomposed.png"/>
	
	<link rel="stylesheet" href="style/iphone.css" type="text/css"/>
		
	<script type="text/javascript" src="javascript/prototype.js"></script>		
    <script type="text/javascript">    	

		var last_section = "";
		var state_id = "";
		var last_scroll_position = new Array(0);
		var backButton;
		
		window.onload=init;
		function init() {
			backButton = document.getElementById("button_back");
			backButton.addEventListener( "click", backClick, false);
		}

		function backClick(e) {
			switch(last_section) { 
			  case("state"): {
				url = "php/states.php";
				last_section = "";			
			  }break;
			  
			  case("city"): {
				url = "php/cities.php?state=" + state_id;
				last_section = "state";
			  }break;
			  
			  default: {
				return;
			  }break;         
			}
			  
			new Ajax.Updater("content", url, {method:"get" , asynchronous:true, onComplete:backClickComplete});			
		}

		function backClickComplete() {
			switch(last_section) { 
			  case("state"): {
				backButton.src = "images/button_states.png";
			  }break;
			  
			  default: {
				backButton.src = "images/spacer.gif";
			  }break;         
			}
			window.scrollTo(0, last_scroll_position.pop());
		}

		function itemClick(page, id) {	
			switch(page) { 
			  case("state"): {
				last_section = page;
				last_scroll_position.push(window.pageYOffset);
				url = "php/cities.php?state=" + id;
				state_id = id;			
			  }break;
			  
			  case("city"): {
				last_section = page;
				last_scroll_position.push(window.pageYOffset);
				url = "php/frequencies.php?city=" + id;
			  }break;
			  
			  default: {
				return;
			  }break;          
			}
			new Ajax.Updater("content", url, {method:"get" , asynchronous:true, onComplete:itemClickComplete});			
		}

		function itemClickComplete() {
			switch(last_section) { 
			  case("state"): {
					backButton.src = "images/button_states.png";			
			  }break;
			  
			  case("city"): {
					backButton.src = "images/button_cities.png";	
			  }break;         
			}
			window.scrollTo(0,0)
		}

		function voteChanged(id,vote) {
			if(vote != "") {
				urlv = "php/vote.php?id=" + id + "&vote=" + vote;
				new Ajax.Request(urlv, {onSuccess:voteComplete, onFailure:errFunc});
			}
		}
		
		function voteComplete() {
			new Ajax.Updater("content", url, { method: "get" , asynchronous:true});
		}
		
		function errFunc() {
			alert("vote error");
		}
		
  </script>
  </head>
  <body>  	
  	<div id="site">	
		<div id="header" align="center">				
			<img id="button_back" src="images/spacer.gif"/>
		</div>		
		<div id="content">			
			<?php include("php/states.php"); ?>			
		</div>		
	</div>	
  </body>
</html>
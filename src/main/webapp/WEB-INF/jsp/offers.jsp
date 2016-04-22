<!DOCTYPE html>
<html xmlns:fb="http://ogp.me/ns/fb#" lang="en">
	<head>
	    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=2.0, user-scalable=yes" />
		<meta http-equiv="X-UA-Compatible" content="IE=8"/>
	    <title>Special Offers</title>
	    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/style/sptab.css" media="Screen" type="text/css" />
	    <link rel="stylesheet" href="//ajax.googleapis.com/ajax/libs/jqueryui/1.7.2/themes/smoothness/jquery-ui.css" />
	
	    <!--[if IEMobile]>
	    <link rel="stylesheet" href="mobile.css" media="screen" type="text/css"  />
	    <![endif]-->
	
	    <!-- These are Open Graph tags.  They add meta data to your  -->
	    <!-- site that facebook uses when your content is shared     -->
	    <!-- over facebook.  You should fill these tags in with      -->
	    <!-- your data.  To learn more about Open Graph, visit       -->
	    <!-- 'https://developers.facebook.com/docs/opengraph/'       -->
	    <meta property="og:title" content="Midnight Delight at Novotel" />
	    <meta property="og:type" content="article" />
	    <meta property="og:url" content="http://damp-waters-4973.herokuapp.com/privacypolicy" />
	    <meta property="og:image" content="http://damp-waters-4973.herokuapp.com/resources/images/offers/midnight.jpg" />
	    <meta property="og:site_name" content="Novotel1" />
	    <meta property="og:description" content="Novotel2" />
	    <meta property="fb:app_id" content="644044125623538" />
	
	    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
	    <script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.7.2/jquery-ui.min.js"></script>
	    <style>
	    
	    </style>
	</head>
	<body>
		<div id="fb-root"></div>
		<div id="tabs">
			<ul>
				<li><a href="#tabs-1">Midnight Delight</a></li>
				<li style="display: none;"><a href="#tabs-2">Sunday Brunch</a></li>
				<li><a href="#tabs-3">Terms & Conditions</a></li>
			</ul>
			<div id="tabs-1" class="sp-outer-container">
				<div class="header-div" align="center">
					<div style="width: 720px;height: 510px;position: relative;">
						<img src="${pageContext.request.contextPath}/resources/images/new_canvas.gif">
						<label id="overlayMessage1" class="overlayMessage" style="position:absolute;top: 330px;right: 200px;display: none;"></label>
						<button id="shareBtn" class="likeButton" disabled="disabled" style="position:absolute;top: 325px;right: 5px; width: 150px;">Share with friends</button>
					</div>
				</div>

				<div>
					<div align="center" style="width: 100%;">
						<div id="couponMessage" style="width:100%;height:20px;font-size:14px;margin-bottom: 1px;position: relative;">Use the coupon code below to avail the offer</div>
						<div class="sb-coupon" align="center">
							<label id="couponCode" class="inactive">Like us (top right) to get the Coupon code</label>
						</div>
					</div>
	
				</div>
				<div style="margin-top: 10px;">
					<img src="${pageContext.request.contextPath}/resources/images/menu.gif"/>
				</div>
			</div>
			<div id="tabs-2" class="sp-outer-container" style="display: none;">
				<div class="header-div" align="center" style="height: 310px;">
					<div style="width: 720px;height: 310px;position: relative;">
						<img src="${pageContext.request.contextPath}/resources/images/contest/cover.jpg">
					</div>
				</div>
				<div id="offersSection">
					<ul class="offer-list">
						<li>
							<div class="offer-pic">
								<img width="275px;" src="${pageContext.request.contextPath}/resources/images/contest/square.gif"/>
							</div>
							<div class="offer-details">
								<div class="offer-title">
									<h3>Sunday Brunch</h3>
								</div>
								<div class="offer-description">
									<label>Enter this contest to win fabulous discounts at Sunday Brunch at Square , Novotel.  All you have to do is to like us on facebook and enter the contest.
									1 lucky couple will get a free lunch coupon and 3 lucky couples will get 50% off. 
									Hurry ! Contest ends on Friday , 5th July, 2013"
									</label>
								</div>
								<div align="right" style="width: 100%;padding-bottom: 5px;display: none;">
									<div>
										<label class="successMessage"></label>
										<button id="likeBtn" class="likeButton" disabled="disabled" style="display: none;">Like</button>
									</div>
								</div>
							</div>
							<div style="width: 100%;position: relative; top: 40px;">
								<label id="overlayMessage2" class="overlayMessage" style="position:absolute;bottom: 5px;right: 200px;display: none;"></label>
								<button id="enterContestButton" class="likeButton" disabled="disabled" style="position:absolute;bottom: 5px;right: 5px; width: 150px;">Enter Contest</button>
							</div>
						</li>
					</ul>
				</div>

				<div style="margin-top: 10px;" align="center">
					<img src="${pageContext.request.contextPath}/resources/images/contest/end_pic.gif"/>
				</div>
			</div>
			<div id="tabs-3" class="sp-outer-container">
				<div class="header-div" >
					<div style="width: 720px;height: 510px;position: relative;">
						<ol>
							<li style="list-style: decimal;">
								The Promotion is in no way sponsored, endorsed or administered by, or associated with, Facebook.  
							</li>
							<li style="list-style: decimal;">
								You are providing your information to the Sponsor and not to Facebook or Twitter.
							</li>
						</ol>
					</div>
				</div>


				<div style="margin-top: 10px;">
					<img src="${pageContext.request.contextPath}/resources/images/menu.gif"/>
				</div>
			</div>
			
		</div>
		<script>
			var signedData = ${signedData};

			$(document).ready(function() {
				$("#tabs").tabs();
				
				var getPageIndex = function(){
					return 0;
					try{
						return (parseInt(signedData.app_data)-1);
					} catch(e){
						
					}
					return 0;
				};
				if(signedData.app_data){
					$("#tabs").tabs('select', getPageIndex());
				}
				var hasLiked = false;
				var getCoupon = function(email, postId, userId, name){
			        $.ajax({
			            url: "/getCoupon?email="+email+"&postId="+postId+'&userId='+userId + '&name='+name,
			            dataType : "json",
			            jsonp:false,
			            type : "GET",
			            async: true,
			            data : "",
			            complete: function(data, textStatus, XMLHttpObj){        
							var response = JSON.parse(data.responseText);
							$("#couponCode").text(response.coupon);
							$("#couponCode").removeClass("inactive");
							$("#couponCode").addClass("active");
			            }
			        });
				};
				
				var enterContest = function(email, userId, name){
			        $.ajax({
			            url: "/enterContest?email="+email+"&userId="+userId+'&name='+name,
			            dataType : "json",
			            jsonp:false,
			            type : "GET",
			            async: true,
			            data : "",
			            complete: function(data, textStatus, XMLHttpObj){        
							  var msg = "Thanks for entering the lucky draw to WIN 50% off on Sunday Brunch at The Square, Novotel. We will declare results on Saturday, 5th July 2013.";
							  $("#enterContestButton").hide();
							  $("#overlayMessage2").text(msg);
							  $("#overlayMessage2").css('right','0px');
							  $("#overlayMessage2").fadeIn();
			            }
			        });
				};
				
				var postLike =  function() {
					var requestObj = {object: "http://damp-waters-4973.herokuapp.com/offers"};
				    FB.api('/me/og.likes', 'post',requestObj,function(response) {
		    	         if (!response) {
		    	           $(".successMessage").text('This is embarrassing and we have been notified about this.');
		    	         } else if (response.error) {
		    	        	 //$(".successMessage").text(response.error.message);
		    	        	 $(".successMessage").text('This is embarrassing and we have been notified about this.');
		    	         } else {
		    	        	 FB.api("/me", function(resp){
						    	getCoupon(resp.email, response.id, resp.id, resp.name);
						    });	
		    	        	 $(".successMessage").text("Thank you for liking us.");
		    	         }
		    	       }
		    	    );
				};
				
				var postShare = function(){
					var body = 'Awesome offer from Novotel Bengaluru  - Get 50% off on night menu at Chez Nous by just liking their page';
					var link = 'http://www.facebook.com/Novotel.Bengaluru.Techpark/app_644044125623538';
					FB.api('/me/feed', 'post', {link: link, message: body }, function(response) {
					  if (!response || response.error) {
					    //alert('Error occured');
					  } else {
						  var msg = "Thank you for introducing us to your friends.";
						  if(!hasLiked){
							  msg +=" Please like us to get the coupon code.";
						  }
						  $("#overlayMessage1").text(msg);
						  $("#overlayMessage1").fadeIn().fadeOut(8000);
					  }
					});
				};
				
				var detectLike = function(){
					FB.api("/me/likes", function(response){
						var likes = response.data;
						for(var i=0; i<likes.length; i++){
							var like = likes[i];
							if(like.category==="Hotel" && like.name==="Novotel Bengaluru Techpark" ){
								hasLiked = true;
								$("#enterContestButton").removeAttr("disabled");
			    	        	FB.api("/me", function(resp){
							    	getCoupon(resp.email, like.id, resp.id, resp.name);
							    });	
			    	        	break;
							} 
						}
						if(!hasLiked){
							$("#enterContestButton").attr("disabled","disabled");
							$("#overlayMessage2").text("Like us (top right) to get the Coupon code");
							$("#overlayMessage2").fadeIn();
							setTimeout(detectLike, 2000);
						}
					});
				};
				
				var getCurrentCoupon = function(email){
			    	$.ajax({
			            url: "/getCurrentCoupon?email="+email,
			            dataType : "json",
			            jsonp:false,
			            type : "GET",
			            async: true,
			            data : "",
			            complete: function(data, textStatus, XMLHttpObj){        
							var response = JSON.parse(data.responseText);
							
							if(response.coupon!="Coupon Code"){
								$("#couponCode").text(response.coupon);
								$("#couponCode").removeClass("inactive");
								$("#couponCode").addClass("active");
								$(".successMessage").text("Thank you for liking us.");
								hasLiked = true;
							} else {
								$(".successMessage").text("Please like us to avail the offer.");
								$("#couponCode").text("Like us (top right) to get the Coupon code");
								detectLike();
							}
			            }
			        });
				};
				
				var getContest = function(email){
			    	$.ajax({
			            url: "/getContest?email="+email,
			            dataType : "json",
			            jsonp:false,
			            type : "GET",
			            async: true,
			            data : "",
			            complete: function(data, textStatus, XMLHttpObj){        
							var response = data.responseText;
							
							if(response==="true"){
								$("#enterContestButton").hide();
								  var msg = "Thanks for entering the lucky draw to WIN 50% off on Sunday Brunch at The Square, Novotel. We will declare results on Saturday, 5th July 2013.";
								  $("#overlayMessage2").text(msg);
								  $("#overlayMessage2").css('right','0px');
								  $("#overlayMessage2").fadeIn();
							} else {
								FB.api("/me/likes", function(response){
									var likes = response.data;
									var likeFlag = false;
									for(var i=0; i<likes.length; i++){
										var like = likes[i];
										if(like.category==="Hotel" && like.name==="Novotel Bengaluru Techpark" ){
											likeFlag = true;
											$("#enterContestButton").removeAttr("disabled");
						    	        	break;
										} 
									}
									if(!likeFlag){
										$("#enterContestButton").attr("disabled","disabled");
										$("#overlayMessage2").text("Like us (top right) to get the Coupon code");
										$("#overlayMessage2").fadeIn();
									}
								});
							}
			            }
			        });
				};
				
				var logVisit = function(){
					FB.api('/me',function(response){
						var tabIndex = $("#tabs").tabs('option', 'selected');
				    	$.ajax({
				            url: "/logVisit?name=" + response.name + '&userid=' + response.id + '&tabIndex=' + tabIndex,
				            dataType : "json",
				            jsonp:false,
				            type : "GET",
				            async: true,
				            data : "",
				            complete: function(data, textStatus, XMLHttpObj){        
								
				            }
				        });
					});
				};
				
				var initPageOnLogin = function(){
					$("#likeButton").removeAttr("disabled");
				};
				
				$("#likeBtn").click(postLike);
				$("#shareBtn").click(function(){
					FB.login(function(response) {
			    		if (response.authResponse) {
							postShare();
			    	   	} else {
			    	     	//console.log('User cancelled login or did not fully authorize.');
			    	   	}
			   		}, {scope: 'email, user_likes, user_location, user_birthday, publish_actions, publish_stream'});
				});
				$("#enterContestButton").click(function(){
					FB.api("/me", function(resp){
				    	enterContest(resp.email, resp.id, resp.name);
				    });	
				});
				
				var requiredPermissions = 'email, user_likes, user_location, user_birthday';
				var hasAllPerms = function(userPerms){
					var reqPerms = requiredPermissions.split(",");
					for(var i=0; i<reqPerms.length; i++){
						var reqPerm = reqPerms[i];
						if(!userPerms[reqPerm]){
							return false;
						}
					}
				};
				
				var updateStatusCallback = function(response){
					logVisit();
					FB.api("/me/permissions", function(resp){
						/*if(hasAllPerms(resp.data[0])){
							FB.api("/me", function(resp1){
								getCurrentCoupon(resp1.email);
							});
							
						} else {*/
							FB.login(function(response) {
					    		if (response.authResponse) {
					    	    	//console.log('Welcome!  Fetching your information.... ');
					    	     	initPageOnLogin();
					    	     	//$("#likeBtn").removeAttr("disabled");
					    	     	$("#shareBtn").removeAttr("disabled");
									FB.api("/me", function(resp1){
										getCurrentCoupon(resp1.email);
										getContest(resp1.email);
									});
					    	   	} else {
					    	     	//console.log('User cancelled login or did not fully authorize.');
					    	   	}
					   		}, {scope: requiredPermissions});
						//}
					});
				};
				
				$.ajaxSetup({ cache: true });
				$.getScript('//connect.facebook.net/en_UK/all.js', function(){
					window.fbAsyncInit = function() {
						FB.init({
				        	appId: '644044125623538',
				        	cookie : true,
				        	status     : true,                                 // Check Facebook Login status
				        	xfbml      : true                                  // Look for social plugins on the page
				      	});       
				      	//$('#loginbutton,#feedbutton').removeAttr('disabled');
				      	FB.getLoginStatus(updateStatusCallback);
				    };
				  });
				});
		</script>
  	</body>
</html>

<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE>
<html>
<head>
<base href="<%=basePath%>">

<title>百一测评系统</title>
<meta name="viewport"
	content="width=device-width,target-densitydpi=medium-dpi,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/lib/bootstrap/css/bootstrap.min.css" />

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/lib/jquery-mobile/css/jquery.mobile-1.3.2.min.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/lib/jquery-mobile/css/jquery.mobile.theme-1.4.2.css" />

<script type="text/javascript"
	src="<%=request.getContextPath()%>/plugin/json2.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/lib/jquery-1.9.1.min.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/lib/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/lib/jquery-mobile/js/jquery.mobile-1.4.2.min.js"></script>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/page/ch/chstyle.css" />
     <link rel="stylesheet" href="<%= request.getContextPath() %>/page/ch/startpaper.css" />
</head>
<body onload="hidenShare()">

	<div data-role="page" id="topic" class="topic">
		<div data-role="content" data-theme="b" id="right_sc" class="right_sc">
			<form action="" method="post">
				<div class="topheader">
					<ul>
						<li class="toptitle">[<font class="total">1</font><span>/<font
								class="tol_s"></font>]</span></li>
						<li class="time"></li>
					</ul>
					<div style="clear:both;"></div>
				</div>
				<header class="header"> <!-- 
    <font class="set_font">[<font id="total">1</font>/4]</font>&nbsp;&nbsp;&nbsp;
    --> <font class="stem"><span>[<font class="type">单选</font>]&nbsp;</span><font
					class="to_ste"></font> </font> </header>
				<ul class="answer_are"></ul>

				<div class="btn_area">
					<button class="btn btn-info btn-hover" id="the_next" type="button">下一题</button>
					<a href="" data-transition="slide" data-role="button" id="first"><font
						class="next_one">下一题</font> </a>
				</div>
			</form>
		</div>


	</div>

	<div data-role="page" id="pagetwo" class="topic">
		<div data-role="content" data-theme="b" class="right_sc">
			<form action="" method="post">
				<div class="topheader">
					<ul>
						<li class="toptitle">[<font class="total">1</font><span>/<font
								class="tol_s"></font>]</span></li>
						<li class="time"></li>
					</ul>
					<div style="clear:both;"></div>
				</div>
				<header class="header"> <font class="stem"><span>[<font
						class="type">单选</font>]&nbsp;</span>&nbsp;&nbsp;&nbsp;<font
					class="to_ste"></font></font></header>
				<ul class="answer_are"></ul>
				<div class="btn_area">
					<button class="btn btn-info btn-hover" id="the_next2" type="button">下一题</button>
					<a href="" data-transition="slide" data-role="button" id="second"><font
						class="next_one">下一题</font> </a>
				</div>

			</form>

		</div>


	</div>

</body>
</html>
<script type="text/javascript">


   //单选部分
    function type1(data){
    
    $('.type').text("单选题");
    $('.to_ste').text(data.data.title);
    var length = data.data.options.length;
    for(var i=0;i<length;i++)
       { 
          
          $('.topic').find('.answer_are').append(' <li class="'+en[i]+'"><font class="sel_answer">'+en[i]+'</font><font class="answer">'+en[i]+"、"+data.data.options[i]+'</font><span><button class="btn btn-info btn_info1" type="button">下一题</button></span></li>');
       }
       
       $('.btn-info').hide();
       $('.answer_are').find('li').click(function(){
       $('.answer_are').find('li').removeClass("answer2");
       var b_li = $(this);
       b_li.addClass("answer2");
       
        //alert("why");
       $('.btn_info1').hide();
       b_li.find('.btn_info1').css({height:"auto",width:"0px"},function(){
        
        });
        var d =b_li.innerHeight();
        b_li.find('.btn_info1').show();
        b_li.find('.btn_info1').css({"height":d});
        
        b_li.find('.btn_info1').animate({right:'0px',width:'80px'},function(){
        
            
        });  
        answer=b_li.find('.sel_answer').text();
            
       });
    };
    
    //多选题
    
    function type2(data){
    $('.type').text("多选题");
     b = data.data.options.length;

       for(var i=0;i<b;i++)
       { 
          
          $('.topic').find('.answer_are').append(' <li class="'+en[i]+'"><font class="sel_answer">'+en[i]+'</font><font class="answer">'+en[i]+"、"+data.data.options[i]+'</font></li>');
       }
      $('#the_next').show();
     $('#the_next2').show();
        
           $('.answer_are').find('li').click(function(){
             
              $(this).toggleClass("answer2");
    
          });
     
          $('#the_next').click(function(){
              if($('.answer').parent().hasClass("answer2"))
              {
              $('#first').click();
              }
          });
        
          $('#the_next2').click(function(){
              var answer = $("li").filter(".answer2").find('.sel_answer').text();
              if(answer!='')
              {
              
                 
              $('#second').click();
              }
          });
    };  
      
    
    
    var h = 1;
	 var m = 0;
	 var s = 10;
     var tt = $('.time');
     if(m<10){m='0'+m;}
    if(h<10){h='0'+h;}
		function initTime(sug_time){
		
		        h = parseInt(sug_time / 3600);
				s = sug_time - h * 3600;
				m = parseInt(s / 60);
				s = s - m * 60;
				startTime();
				
		};
		
		function timeRender()
		{
		 s=s-1;
			 if(s<10)
			 {
				 s='0'+s;
			 }
			 if(s=="0-1")
			 {
				 if(m<10)
				 {
				 m='0'+(m-1);
				 s=59;
				 }
				 else{
					 m=m-1;
				     s=59;
					 }
			 }
		
			  if(m=="00"){m="00";}
		      if(m=='0-1')
			  {
				  if(h!='00')
				  {  
				      if(h<10)
					  {
					  h='0'+(h-1);
					  m=59;
					  }
					  else
					  {
						 h=h-1;
					     m=59;
						  }
				  }
				  else{
					  h="00";
					  m="00";
					  s="00";
				  }
			  }
			  if(m==0)
			  {
				  m = "00";
			  }
			  tt.text(h+':'+m+':'+s);
		}
	function startTime()
	{
	 setInterval(function(){
		timeRender();
		/* document.title='Java:'+h+'时'+m+'分'+s+'秒' */
		 },1000);
		timeRender();
	
	}
       
	function hidenShare(){
		//隐藏分享
		 document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
 	     WeixinJSBridge.call('hideOptionMenu');
 	 	});
 	}
 		
 	//答题时间统计
 	var init_s=0;
 	function useTime(init_s)
	 	{   
	 	    init_s = init_s+1;
	 	}
 	function staTime()
	 	{    
	 	   setInterval(function(){
	 	     useTime(init_s);
	 	   },1000);
	 	}
 		
 		//第一次生成试卷
     function firstGenerate(paperStem){
        var resCont = paperStem.data.partDatas[0];
        var pap_num = oldPaper;

        var dataResult = {"partSeq":resCont.partSeq,"question_id":pap_num};
        var tol_s = $('.tol_s').text(paperStem.data.partDatas[0].questionLength);
        $('.total').text(''+[index]+'');
		$.ajax({
            url:"<%=request.getContextPath()%>/wx/schoolExam/commitAnswerOrGetNext",
            type:"post",
            contentType: 'application/json',
            dataType:"json",
            data:JSON.stringify(dataResult),
            success:function(data){
            
             if(data.code==0&&data.data)
             { 
               if(data.data.type==1)
               {
                 
                 type1(data);
               }
               if(data.data.type==2)
               {
                
                 type2(data);
               }
             }
          }
        
        });
    
		
    } 
    
    var paperStem=''; 
    var sugTotal = '';
    var oldPaper = '';
    // 获取试卷结构
    function getPaper(){

		$.ajax({
			url: "<%=request.getContextPath()%>/wx/schoolExam/getPaper",
			type : "post",
			dataType : "json",
			success : function(result) {
				
				if(result.code!=0) // error
				{
					// ...
					return;
				}
				/* handleResult(result.data || []); */
				console.log(result.data.examInfo);
                
				if(result.data.examInfo!="")
				{
				  var restorePaper = result.data.examInfo.questionId;
				  				  
				  var length = result.data.partDatas[0].questionLength;
				  sug_time= result.data.examInfo.timeLeft;
				  initTime(sug_time);
				  for(var i =0;i<length;i++)
				  {  
				       oldPaper = result.data.partDatas[0].questionIds[0].questionId;
				       if(restorePaper==result.data.partDatas[0].questionIds[i].questionId)
				         {
				            index=i+2;
				            top_num = i+2;
				            paperStem = result;
			                oldPaper = result.data.examInfo.questionId;
				            firstGenerate(paperStem);
				            return index,top_num;
				         
				        }
				   }
				}
				else{
				
				var sug_time = result.data.partDatas[0].suggestTime;
				initTime(sug_time);
			    oldPaper = result.data.partDatas[0].questionIds[0].questionId;
			    alert(123);
			    firstGenerate(result);
			    
			    paperStem = result;
			    sugTotal = result.data.partDatas[0].questionLength;
			    }
			}
		});
    
    }
    //答题时间统计
    
    var answerTime = 0;
     
      
	function tolTime()
	{
	    
	    answerTime = answerTime+1;
	    
	};
	function relTimer()
	{
	   setInterval(function()
	   {
	      tolTime();
	      
	   },1000);
	   
	}
    //生成试卷
    function generatePaper(paperStem){
        
        var resCont = paperStem.data.partDatas[0];
        
        var pap_num = resCont.questionIds[top_num++].questionId;
        var pap_old = resCont.questionIds[top_num-2].questionId; 
        var dataResult = {
        "partSeq":resCont.partSeq,
        "question_id":pap_num,
        "answer":{                //当前题答案
	          "id":pap_old, 
	         "answerTime":answerTime,
	         "choice":answer
    			}
    					};
        var tol_s = $('.tol_s').text(paperStem.data.partDatas[0].questionLength);
        $.ajax({
            url:"<%=request.getContextPath()%>/wx/schoolExam/commitAnswerOrGetNext",
            type:"post",
            contentType: 'application/json',
            dataType:"json",
            data:JSON.stringify(dataResult),
          success:function(data){
             console.log(data);

             answerTime=0;
             
             if(data.code==0&&data.data)
             { 
               if(data.data.type==1)
               {
                 
                 type1(data);
               }
               if(data.data.type==2)
               {
                
                 type2(data);
               }
             }
          }
        
        });
    
    }
    //最后一道题
    function lastPaper(paperStem)
    {
       
       var last = paperStem.data.partDatas[0].questionIds.length-1;
       var lastPaper = paperStem.data.partDatas[0].questionIds[last].questionId;
       var dataResult = {
			            "partSeq":1,
			    		"answer":{                     //当前题答案
					    	    "id":lastPaper,
					        	"answerTime":answerTime,
					        	"choice":answer
			        	         }
			            };
       $.ajax({
            url:"<%=request.getContextPath()%>/wx/schoolExam/commitAnswerOrGetNext",
            type:"post",
            contentType: 'application/json',
            dataType:"json",
            data:JSON.stringify(dataResult),

        });
        
        
       <%--  $.ajax({
            url:"<%=request.getContextPath()%>/schoolExam/handInPaperPart",
            type:"post",
            conyentType:'application/json',
            dataType:"json",
            
        }); --%>
        
        
    }
    var top_num = 1;
    var i=-1;
    var answer = 1;
    var index = 2;
    var opt = 0;
    var t = 1;
    var en = ['A','B','C','D','E','F','G','H','I','J','K'];
    
    $(document).ready(function(){  
        $('.btn-info').hide();
    	getPaper();
        relTimer();
    
   $('#first').click(function jump(){
        $('.A').removeClass("answer2");
        $('.B').removeClass("answer2");
        $('.C').removeClass("answer2");
        $('.D').removeClass("answer2");
       
       
       $('.btn_info1').hide(); 
    if($('#the_next').text()=="完成试卷")
    {   
        if(answer!='')
	{  
    $('.total').text(''+[index++]+'');
    $('#first').attr("href","");
    $('#second').attr("href","");
    location.href="<%=request.getContextPath()%>/ch/handInPaper.jsp";
    
    }
    }
     
	else {
		if(answer!="")
	    {
	    
	    generatePaper(paperStem);
	 
    $('.total').text(''+[++index]+'');
    $('#first').attr("href","#pagetwo");
    $('#second').attr("href","");
	$('.answer_are').empty();
    
    if(index==49)
    {
      lastPaper(paperStem);
            $('.topic').on('click','li',function(){
         $(this).find('.btn_info1').text("完成试卷");
      });
      
      $('.btn_info1').text("完成试卷");
      $('.btn-info').text("完成试卷");
      
    }
/*     else
    {
    i=i+1;
    
    } */
    answer=1;
    }
    }
    });

 $('#second').click(function jump(){
	     
        $('.A').removeClass("answer2");
        $('.B').removeClass("answer2");
        $('.C').removeClass("answer2");
        $('.D').removeClass("answer2");
       
        $('.btn_info1').hide(); 
     if($('#the_next2').text()=="完成试卷")
     {

         if(answer!='')
			{	    
		    $('.total').text(''+[index++]+'');
		    $('#second').attr("href","");
		    $('#first').attr("href","");
		    
		   location.href="<%=request.getContextPath()%>/ch/handInPaper.jsp";

													}
												} else {
													if (answer != '') {
                                                         generatePaper(paperStem);
														$('.total').text(''	+ [ ++index]+ '');
														$('#second').attr("href","#topic");
														$('#first').attr("href", "");
														$('.answer_are').empty();
													
														if (index == 49) {
														    lastPaper(paperStem);
														          $('.topic').on('click','li',function(){
                             									  $(this).find('.btn_info1').text("完成试卷");
      																									});
															$('.btn_info1').text("完成试卷");
															$('.btn-info').text("完成试卷");
                                                            
														}/*  else {
															i = i + 1;

														} */
														answer = 1;
													}

												}
											});

							$('#topic').on('click', '.btn_info1', function() {
								/* $('.A').removeClass("answer2"); */
								$('#first').click();
							});

							$('#pagetwo').on('click', '.btn_info1', function() {

								$('#second').click();
							});
						});
</script>


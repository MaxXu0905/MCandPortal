<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>百一测评系统</title>
    <meta name="viewport" content="width=device-width,target-densitydpi=medium-dpi,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
    <link rel="stylesheet" href="css/bootstrap.css" />
	<link rel="stylesheet" href="css/jquery.mobile-1.3.2.min.css" />
	<link rel="stylesheet" href="css/jquery.mobile.theme-1.4.2.css" />
	
	<script type="text/javascript" src="js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.min.js"></script>
	<script type="text/javascript" src="js/jquery.mobile-1.4.2.min.js"></script>
	<script type="text/javascript" src="js/jquery.countdown.js"></script>
    <script type="text/javascript" src="js/lw-countdown.js"></script>

<style type="text/css">
	    body,div,button,ul,li,a,header,h4,input,button{
      font-family: "Open Sans",Arial,"Hiragino Sans GB","Microsoft YaHei","微软雅黑","STHeiti","WenQuanYi Micro Hei",SimSun,sans-serif;
		color: #424242;
    } 
    body{background:#f8f8f8;}
   header{padding:12px 16px 10px 16px;}
	.right_sc{background:#f8f8f8;padding:0px;}     
	    #next{width: 100px;height:35px}
	    .topic{ background:#f8f8f8;}
	    .J_countdown1{ margin-top:-17px;}
	    
	    .digit{float:left}
	    .hours_dash{ width:50px;}
	    .minutes_dash{margin-left:45px;margin-top:-20px;width:50px;}
	    .seconds_dash{width:50px; margin-left:85px;margin-top:-20px;}
	    .time_hour{margin-left: -8px}
	    .time_min{ margin-left:10px}
	    .time_sec{margin-left: 10px}
	    .surround{ margin: 0 auto;width: 120px;display:none}
	    .stem_topic{background-color:white;height:70px;}
	    
	 .answer_are{padding:0px;margin:0px; border-top:1px solid #d5d5d5;}   
	.answer_are >li{border-bottom:1px solid #d5d5d5;
	border-top:1px solid #fff;
	     font-family: normal 100% "Open Sans",Arial,"Hiragino Sans GB","Microsoft YaHei","微软雅黑","STHeiti","WenQuanYi Micro Hei",SimSun,sans-serif;
	padding:16px 12px 16px 16px;
	margin:0px;
	font-size:13pt;
	color:#7b7b7b;
	}    	    
	.answer2{border-bottom:1px solid #d5d5d5;
	border-top:1px solid #fff;
	color: #0092dd !important;
	     font-family: "Open Sans",Arial,"Hiragino Sans GB","Microsoft YaHei","微软雅黑","STHeiti","WenQuanYi Micro Hei",SimSun,sans-serif;
padding:16px 70px 16px 16px  !important;
background:#fff;
font-size:13pt;
position:relative;
	}
.answer2 span{position:absolute;right:0px;top:0px;}	
.answer2 span div{position:absolute;right:0px;top:0px;/* border:1px solid #00a8ff; */
font-size:12px;with:0px;height:auto;}		    	 
.btn_area{padding:20px 30px;}	      
.topheader{border-bottom:1px solid #00a8ff;
background:#fff;
padding:14px;
color:#fff;
padding:10px 16px;
}
.topheader ul{padding:0px;marginL:0px;}
.topheader li{padding:0px;marginL:0px;}
.topheader li{float:left;width:50%;font-size:18px;line-height:30px;}
.topheader li span{color:#adadad;line-height:30px;font-weight:300 !important;}
.toptitle{color:#00a8ff;line-height:30px;font-weight:700;}
.time{text-align:right;color:#ff3c00;font-size:24px !important;line-height:30px;}
/*

	    .B{width:100%;height:50px;border:hidden;text-align: left;background-color: 

white}
	    .C{width:100%;height:50px;border:hidden;text-align: left;background-color: 

white}
	    .D{width:100%;height:50px;border:hidden;text-align: left;background-color: 

white}
    */	
	    #stem{font-size:13pt;padding-bottom:20px;}
	    #stem1{font-size:13pt;padding-bottom:20px;}
	   #stem span{color:#00a8ff;}  
/*	    
	    #A_awr{font-size: large;}
	    #B_awr{font-size: large;}
	    #C_awr{font-size: large;}
	    #D_awr{font-size: large;}
*/	    
	    .set_font{ font-weight:400;color: #00a8ff;font-size: x-large;}
	    #pagetwo{}
	    #first{height:40px;background-color: #AAF4FB;text-decoration:none;width:50%;margin-left: 70px}
	    #second{height:40px;background-color: #AAF4FB;text-decoration:none;width:50%;margin-left: 70px}
	    .next_one{ color: black;line-height: 40px}
	    #first{display: none}
	    #second{display: none}
	    #the_next{width:100%;height:50px}
	    #the_next2{width:100%;height:50px}
	 	 .btn-info{background:#00a8ff;border:1px solid #0091dc;font-size:12pt;margin-top:0px;
	 	 border-radius: 0px;
	 	 }
	    .btn-info:hover{background:#0092dd;border:1px solid #0080c3;font-size:12pt;border-radius: 0px;} 
  
	    #total{ font-size: 30px; color:#3abf00; }
	    #total1{ font-size: 30px;color:#3abf00; }  	    
    </style>		
  </head> 
  <body onload="hidenShare()">
   <div class="surround">
         <div id="countdown_dashboard">  
         <div class="dash hours_dash">
	           <div class="digit" id="hh"></div>
	           <div class="digit"id="hh2"></div>
	           <span class="time_hour">时</span>
         </div>
         <div class="dash minutes_dash">
	           <div class="digit" id="mm"></div>
	           <div class="digit" id="mm1"></div>
	           <span class="time_min">分</span>
        </div>       
        <div class="dash seconds_dash">
	           <div class="digit" id="sec"></div>
	           <div class="digit" id="sec1"></div>
	           <span class="time_sec">秒</span>
	        </div>
        </div>   
    </div>     
<div data-role="page" id="topic" class="topic">  
    <div data-role="content" data-theme="b" id="right_sc" class="right_sc">
    <form action="" method="post">
    <div class="topheader">
      <ul>
         <li class="toptitle">第2题<span>（共30题）</span></li>
         <li class="time">00:35:28</li> 
      </ul>
      <div style="clear:both;"></div>
   </div>
    <header class="header">
    <!-- 
    <font class="set_font">[<font id="total">1</font>/4]</font>&nbsp;&nbsp;&nbsp;
    --> 
    <font id="stem"><span>[单选题]&nbsp;</span>A派生出子类B，B派生出子类C，并且在Java源代码中有如下声明：Aa0=new A();2.Aa1 =new B(); 3. Aa2=new C(); 
  问以下哪个说法是正确的？</font>
  </header>
  <ul class="answer_are">
  <li class="A"><font class="answer" id="A_awr">A、只有第1行能通过编译</font><span><button class="btn btn-info btn_info" type="button">下一题</button></span></li>
  <li class="B"><font class="answer" id="B_awr">B、第1、2行能通过编译，但第3行编译出错</font> <span><button class="btn btn-info btn_info"type="button">下一题</button></span></li>
  <li class="C"><font class="answer" id="C_awr">C、第1、2、3行能通过编译，但第2、3行运行时出错</font> <span><button class="btn btn-info btn_info"type="button">下一题</button></span> </li>
  <li class="D"><font class="answer" id="D_awr">D、第1行、第2行和第3行的声明都是正确的行和第3行的声明都是正确行和第3行的声明都是正确行和第3行的声明都是正确行和第3行的声明都是正确</font> <span><button class="btn btn-info btn_info"type="button">下一题</button></span> </li>
  </ul>
   
 <div class="btn_area">    
     <button class="btn btn-info" id="the_next" type="button">下一题</button> 
     <a href="" data-transition="slide" data-role="button" id="first"><font class="next_one">下一题</font></a>
 </div>     
    </form>
  </div>
 
  
</div>    

<div data-role="page" id="pagetwo" class="topic">
  <div data-role="content" data-theme="b" class="right_sc">
    <form action="" method="post" >   
    <header class="header"><font class="set_font">[<font id="total1"></font>/4]</font>&nbsp;&nbsp;&nbsp;<font id="stem1"></font></header>
         <ul class="answer_are">
			  <li class="A"><font class="answer" id="A_awr1"></font><span><button class="btn btn-info btn_info1" type="button">下一题</button></span> </li>
			  <li class="B"><font class="answer" id="B_awr1"></font> <span><button class="btn btn-info btn_info1" type="button">下一题</button></span> </li>
			  <li class="C"><font class="answer" id="C_awr1"></font> <span><button class="btn btn-info btn_info1" type="button">下一题</button></span> </li>
			  <li class="D"><font class="answer" id="D_awr1"></font> <span><button class="btn btn-info btn_info1" type="button">下一题</button></span> </li>
     </ul>
  <div class="btn_area">    
     <button class="btn btn-info" id="the_next2" type="button">下一题</button> 
     <a href="" data-transition="slide" data-role="button" id="second"><font class="next_one">下一题</font></a>
  </div>  
  
    </form>
    
  </div>


</div> 

  </body>
</html>
<script type="text/javascript">
    var h = 1;
	 var m = 0;
	 var s = 10;

     if(m<10){m='0'+m}
    if(h<10){h='0'+h}

function startTime()
{
    
 setInterval(function(){

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

	  if(m=="00"){m="00"}
      if(m=='0-1')
	  {
		  if(h!='00')
		  {  
		      if(h<10)
			  {
			  h='0'+(h-1);
			  m=59
			  }
			  else
			  {
				 h=h-1;
			     m=59
				  }
		  }
		  else{
			  h="00"
			  m="00"
			  s="00"
		  }
	  }
	  if(m==0)
	  {
		  m = "00";
	  }
	document.title='Java:'+h+'时'+m+'分'+s+'秒'
	 },1000);

}
       window.onload = startTime();
function hidenShare(){
		//隐藏分享
		 document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
 	     WeixinJSBridge.call('hideOptionMenu');
 	 	});
 		}
    $(document).ready(function(){                     
    var i=-1;
    var answer = 1;
    var index = 2;
    var opt = 0;
    
$('#first').click(function jump(){
        $('.A').removeClass("answer2");
        $('.B').removeClass("answer2");
        $('.C').removeClass("answer2");
        $('.D').removeClass("answer2");
       $('.btn-info').hide(); 
       $('.btn_info1').hide(); 
    if($('#the_next').text()=="完成试卷")
    {   
        if(answer=='A'||answer=='B'||answer=='C'||answer=='D')
	{
	 
	/*  $.ajax({
		url : root+"/CoreServlet",
		type : "post",
		dataType : "json",
		data : {
		      "i"  : i+3,
		      "answer":answer,
		    },
		success: function(data){
		    //返回结果关闭窗口
		}
		}); */
		
    var txt = '{ "topic" : [' +
'{ "stem":"java是从( )语言改进重新设计","A":"A、ada","B":"B、c","C":"C、pasacal","D":"D、basic" },' +
'{ "stem":"下列说法正确的有( ) ","A":"A、class中的constructor不可省略","B":"B、constructor必须与class同名，但方法不能与class同名","C":"C、constructor在一个对象被new时执行","D":"D、 一个class只能定义一个constructor " },' +
'{ "stem":"下列哪一种叙述是正确的( )","A":"A、abstract修饰符可修饰字段、方法和类","B":"B、抽象方法的body部分必须用一对大括号{ }包住","C":"C、声明抽象方法，大括号可有可无","D":"D、声明抽象方法不可写出大括号" } ]}';
    var top= eval ("(" + txt + ")");
 
    $('#stem1').text(top.topic[i+1].stem);
    $('#A_awr1').text(top.topic[i+1].A);
    $('#B_awr1').text(top.topic[i+1].B);
    $('#C_awr1').text(top.topic[i+1].C);
    $('#D_awr1').text(top.topic[i+1].D);
    $('#total1').text(''+[index++]+'');
    $('#first').attr("href","");
    $('#second').attr("href","");
    location.href="page5.jsp";
    
    }
    }
     
	else {if(answer=='A'||answer=='B'||answer=='C'||answer=='D')
	{

	 
		
    var txt = '{ "topic" : [' +
'{ "stem":"java是从( )语言改进重新设计","A":"A、ada","B":"B、c","C":"C、pasacal","D":"D、basic" },' +
'{ "stem":"下列说法正确的有( ) ","A":"A、class中的constructor不可省略","B":"B、constructor必须与class同名，但方法不能与class同名","C":"C、constructor在一个对象被new时执行","D":"D、 一个class只能定义一个constructor " },' +
'{ "stem":"下列哪一种叙述是正确的( )","A":"A、abstract修饰符可修饰字段、方法和类","B":"B、抽象方法的body部分必须用一对大括号{ }包住","C":"C、声明抽象方法，大括号可有可无","D":"D、声明抽象方法不可写出大括号" } ]}';
    var top= eval ("(" + txt + ")");
 
    $('#stem1').text(top.topic[i+1].stem);
    $('#A_awr1').text(top.topic[i+1].A);
    $('#B_awr1').text(top.topic[i+1].B);
    $('#C_awr1').text(top.topic[i+1].C);
    $('#D_awr1').text(top.topic[i+1].D);
    $('#total1').text(''+[index++]+'');
    $('#first').attr("href","#pagetwo");
    $('#second').attr("href","");
    if(i==1)
    {
      $('.btn_info1').text("完成试卷");
      $('.btn-info').text("完成试卷");
      
    }
    else
    {
    i=i+1;
    
    }
    answer=1;
    }
    }
    });

 $('#second').click(function jump(){
	     
        $('.A').removeClass("answer2");
        $('.B').removeClass("answer2");
        $('.C').removeClass("answer2");
        $('.D').removeClass("answer2");
        $('.btn-info').hide(); 
        $('.btn_info1').hide(); 
     if($('#the_next2').text()=="完成试卷")
     {
         if(answer=='A'||answer=='B'||answer=='C'||answer=='D')
			{
		    
			/*  $.ajax({
				url : root+"/CoreServlet",
				type : "post",
				dataType : "json",
				data : {
				      "i" : 1, 
				      "qid " : i+3,
				      "answer":answer,
				       },
			    success: function(data){
		    			//返回结果关闭窗口
		               }
				}); */
				
		    var txt = '{ "topic" : [' +
		'{ "stem":"java是从( )语言改进重新设计","A":"A、ada","B":"B、c","C":"C、pasacal","D":"D、basic" },' +
		'{ "stem":"下列说法正确的有( ) ","A":"A、class中的constructor不可省略","B":"B、constructor必须与class同名，但方法不能与class同名","C":"C、constructor在一个对象被new时执行","D":"D、 一个class只能定义一个constructor " },' +
		'{ "stem":"下列哪一种叙述是正确的( )","A":"A、abstract修饰符可修饰字段、方法和类","B":"B、抽象方法的body部分必须用一对大括号{ }包住","C":"C、声明抽象方法，大括号可有可无","D":"D、声明抽象方法不可写出大括号" } ]}';
		    var top= eval ("(" + txt + ")");
		  
		    $('#stem').text(top.topic[i+1].stem);
		    $('#A_awr').text(top.topic[i+1].A);
		    $('#B_awr').text(top.topic[i+1].B);
		    $('#C_awr').text(top.topic[i+1].C);
		    $('#D_awr').text(top.topic[i+1].D);
		    $('#total').text(''+[index++]+'');
		    $('#second').attr("href","");
		    $('#first').attr("href","");
		   location.href="page5.jsp";
		    
     }
     }
    else{ 
	if(answer=='A'||answer=='B'||answer=='C'||answer=='D')
	{

    var txt = '{ "topic" : [' +
'{ "stem":"java是从( )语言改进重新设计","A":"A、ada","B":"B、c","C":"C、pasacal","D":"D、basic" },' +
'{ "stem":"下列说法正确的有( ) ","A":"A、class中的constructor不可省略","B":"B、constructor必须与class同名，但方法不能与class同名","C":"C、constructor在一个对象被new时执行","D":"D、 一个class只能定义一个constructor " },' +
'{ "stem":"下列哪一种叙述是正确的( )","A":"A、abstract修饰符可修饰字段、方法和类","B":"B、抽象方法的body部分必须用一对大括号{ }包住","C":"C、声明抽象方法，大括号可有可无","D":"D、声明抽象方法不可写出大括号" } ]}';
    var top= eval ("(" + txt + ")");
  
    $('#stem').text(top.topic[i+1].stem);
    $('#A_awr').text(top.topic[i+1].A);
    $('#B_awr').text(top.topic[i+1].B);
    $('#C_awr').text(top.topic[i+1].C);
    $('#D_awr').text(top.topic[i+1].D);
    $('#total').text(''+[index++]+'');
    $('#second').attr("href","#topic");
    $('#first').attr("href","");
    if(i==1)
    {
      $('.btn_info1').text("完成试卷");
      $('.btn-info').text("完成试卷");
      
    }
    else
    {
    i=i+1;
    
    }
    answer=1;
    }
	 
     }
	 });
     $('.btn-info').hide();
     $('.btn_info1').hide(); 
    $('.A').click(function(){
         $('.btn-info').hide();
         $('.btn_info1').hide(); 
        $('.next_btn').text(""); 
        $('.A').addClass("answer2");
        $('.B').removeClass("answer2");
        $('.C').removeClass("answer2");
        $('.D').removeClass("answer2");
        
        answer = 'A';
          $('.btn-info').css({height:"auto",width:"0px"},function(){
        
        });
        var d =$(this).innerHeight();
        $(this).find('.btn-info').show();
        $('.btn-info').css({"height":d});
        
        $('.btn-info').animate({right:'0px',width:'80px'},function(){
        $(this).find('button').text("下一题"); 
            
        }); 
        
         $('.btn_info1').css({height:"auto",width:"0px"},function(){
        
        });
        var d =$(this).innerHeight();
        $(this).find('.btn_info1').show();
        $('.btn_info1').css({"height":d});
        
        $('.btn_info1').animate({right:'0px',width:'80px'},function(){
        $(this).find('button').text("下一题"); 
            
        }); 
    });
    
    $('.B').click(function(){
         $('.btn-info').hide();
         $('.btn_info1').hide(); 
        $('.next_btn').text(""); 
        $('.A').removeClass("answer2");
        $('.B').addClass("answer2");
        $('.C').removeClass("answer2");
        $('.D').removeClass("answer2");
        answer = 'B';
          $('.btn-info').css({height:"auto",width:"0px"},function(){
        
        });
        var d =$(this).innerHeight();
        $(this).find('.btn-info').show();
        $('.btn-info').css({"height":d});
        
        $('.btn-info').animate({right:'0px',width:'80px'},function(){
        $(this).find('button').text("下一题"); 
            
        }); 
        
        $('.btn_info1').css({height:"auto",width:"0px"},function(){
        
        });
        var d =$(this).innerHeight();
        $(this).find('.btn_info1').show();
        $('.btn_info1').css({"height":d});
        
        $('.btn_info1').animate({right:'0px',width:'80px'},function(){
        $(this).find('button').text("下一题"); 
            
        }); 
        
        
    });
    
    $('.C').click(function(){
        $('.btn-info').hide();
        $('.btn_info1').hide(); 
        $('.next_btn').text(""); 
        $('.A').removeClass("answer2");
        $('.B').removeClass("answer2");
        $('.C').addClass("answer2");
        $('.D').removeClass("answer2");
        answer = 'C';
        $('.btn-info').css({height:"auto",width:"0px"},function(){
        
        });
        var d =$(this).innerHeight();
        $(this).find('.btn-info').show();
        $('.btn-info').css({"height":d});
        
        $('.btn-info').animate({right:'0px',width:'80px'},function(){
        $(this).find('button').text("下一题"); 
            
        }); 
        
        //
        $('.btn_info1').css({height:"auto",width:"0px"},function(){
        
        });
        var d =$(this).innerHeight();
        $(this).find('.btn_info1').show();
        $('.btn_info1').css({"height":d});
        
        $('.btn_info1').animate({right:'0px',width:'80px'},function(){
        $(this).find('button').text("下一题"); 
            
        }); 
    });
    
    $('.next_btn').text(""); 
    $('.D').click(function(){
        $('.btn-info').hide();
        $('.btn_info1').hide(); 
        $('.next_btn').text(""); 
        $('.A').removeClass("answer2");
        $('.B').removeClass("answer2");
        $('.C').removeClass("answer2");
        $('.D').addClass("answer2");
        answer = 'D';
          $('.btn-info').css({height:"auto",width:"0px"},function(){
        
        });
        var d =$(this).innerHeight();
        $(this).find('.btn-info').show();
        $('.btn-info').css({"height":d});
        
        $('.btn-info').animate({right:'0px',width:'80px'},function(){
        $(this).find('button').text("下一题"); 
            
        }); 
        //
        
        $('.btn_info1').css({height:"auto",width:"0px"},function(){
        
        });
        var d =$(this).innerHeight();
        $(this).find('.btn_info1').show();
        $('.btn_info1').css({"height":d});
        
        $('.btn_info1').animate({right:'0px',width:'80px'},function(){
        $(this).find('button').text("下一题"); 
            
        }); 
    });
    
    
    
  /*   
    $('#countdown_dashboard').countDown({
		 
		});
       
      function count_time(){
      
      setInterval(function(){
      
      	var hh = $('#hh').find('.bottom').text();
      	var hh1 = $('#hh2').find('.bottom').text();
      	var mm = $('#mm').find('.bottom').text();
      	var mm1 = $('#mm1').find('.bottom').text();
      	var sec = $('#sec').find('.bottom').text();
      	var sec1 = $('#sec1').find('.bottom').text();
      	document.title='Java:'+hh+''+hh1+'时'+mm+''+mm1+'分'+sec+''+sec1+'秒';
      
      }, 0);
      
      
       /* setInterval("var hh = $('#hh').find('.bottom').text();var hh1 = $('#hh2').find('.bottom').text();var mm = $('#mm').find('.bottom').text();var mm1 = $('#mm1').find('.bottom').text();var sec = $('#sec').find('.bottom').text();var sec1 = $('#sec1').find('.bottom').text();document.title='Java:'+hh+''+hh1+'时'+mm+''+mm1+'分'+sec+''+sec1+'秒';", 0);
        var hh = $('#hh').text();
       var hh1 = $('#hh2').text();
       var mm = $('#mm').text();
       var mm1 = $('#mm1').text();
       var sec = $('#sec').text();
       var sec1 = $('#sec1').text();
       document.title='剩余时间:'+hh+''+hh1+'时'+mm+''+mm1+'分'+sec+''+sec1+'秒';  }count_time(); */



	$('#topic').on('click','.btn_info',function(){
	         /* $('.A').removeClass("answer2"); */
             $('#first').click();
	});  

    $('#pagetwo').on('click','.btn_info1',function(){
	        
             $('#second').click();
	});
     });
</script>


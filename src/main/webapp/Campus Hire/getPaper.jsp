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
    header{padding:1.0em 1.0em 0.6em 1.0em ;font-size:13pt;}
	#right_sc{background:#f8f8f8;padding:0px;}     
	    #next{width: 100px;height:35px}
	    #topic{ background:#f8f8f8;}
	    #topic2{background:#f8f8f8;}
	    .J_countdown1{ margin-top:-17px;}
	    #headr{text-align: center;background-color:#f8f8f8;margin-top:-10px;font-size:4pt;}
	    .digit{float:left}
	    .hours_dash{ width:50px;}
	    .minutes_dash{margin-left:45px;margin-top:-20px;width:50px;}
	    .seconds_dash{width:50px; margin-left:85px;margin-top:-20px;}
	    .time_hour{margin-left: -8px}
	    .time_min{ margin-left:10px}
	    .time_sec{margin-left: 10px}
	    .surround{ margin: 0 auto;width: 120px;display:none}
	    .stem_topic{background-color:white;height:70px;}
	    h1{display:none}
	 .answer_are{padding:0px;margin:0px; border-top:1px solid #d5d5d5;}   
	.answer_are >li{border-bottom:1px solid #d5d5d5;
	
	     font-family: normal 100% "Open Sans",Arial,"Hiragino Sans GB","Microsoft YaHei","微软雅黑","STHeiti","WenQuanYi Micro Hei",SimSun,sans-serif;
	padding:20px 50px 20px 30px;
	margin:0px;
	}    	    
	.answer_are >li:hover{border-bottom:1px solid #d5d5d5;
	border-left:5px solid #ffcc00;
	     font-family: "Open Sans",Arial,"Hiragino Sans GB","Microsoft YaHei","微软雅黑","STHeiti","WenQuanYi Micro Hei",SimSun,sans-serif;
padding:20px 50px 20px 25px;
background:#fff url("images/icon.png") no-repeat right center;
	}	    	 
.btn_area{padding:30px 20px;}	      


	   .title{font-size:12pt;padding:15px 0px;color:#7b7b7b;}
	   .btn-group{margin-bottom:10px;}
	    .set_font{ font-weight: bold;color: #00a8ff;font-size: x-large;}
	    #pagetwo{}
	    #first{height:40px;background-color: #AAF4FB;text-decoration:none;width:50%;margin-left: 70px}
	    #second{height:40px;background-color: #AAF4FB;text-decoration:none;width:50%;margin-left: 70px}
	    .next_one{ color: black;line-height: 40px}
	    #first{display: none}
	    #second{display: none}
	    #the_next{width:100%;height:50px}
	    #the_next2{width:100%;height:50px}
	 	 .btn-info{background:#00a8ff;border:1px solid #0091dc;font-size:16pt;}
	    .btn-info:hover{background:#0092dd;border:1px solid #0080c3;font-size:16pt;}   
	    
	    
	    
	    body{background:#f8f8f8;}
	    #topic{}
	    #konw{ height:50px;margin:0 auto;}
	    #headr{text-align: center;padding:0.8em;border-bottom:1px solid #d2d2d2;margin:0px 1.3em;}
	    #title{font-size:16pt;color: #00a8ff;}
	    #content{font-size:13pt; color:#3A3A3A;padding:0.8em 1.2em 2.0em 1.2em;line-height:1.6em;}
	    #content >div{color:#ff8a00;padding:0.2em 1.0em;margin:0.8em 0.2em; border:1px solid #ffdd83;line-height:2.0em;}
	     #content ul{color:#ff8a00;margin:0px;}
	    #content  li{color:#00a8ff;line-height:1.8em;}
	    .btn_area{
	    padding:0.1em 1.2em;
	    }
	    h1{
	    display: none;
	    }
	 	 .btn-info{background:#00a8ff;border:1px solid #0091dc;font-size:16pt;}
	    .btn-info:hover{background:#0092dd;border:1px solid #0080c3;font-size:16pt;}  
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
.toptitle{color:#00a8ff;line-height:30px;font-weight:400;} 
    </style>
  </head>
  
  <body>

<div data-role="page" id="topic">
   
    
    <div data-role="content" data-theme="b" id="right_sc">
    <form action="" method="post">
    
    <header>请在以下三组中分别选出您最擅长的语言或技能，以便我们更好的了解您的能力： </header>
  <div style="padding:0px 20px;">
       <div class="title">1、请在下面一组中选出最擅长的一项：</div>
		<div class="btn-group btn-group-justified">
		  <a class="btn btn-default btn-lg">Java</a>
		  <a type="button" class="btn btn-default btn-lg">C++</a>
		</div>
	 <div class="title">2、请在下面一组中选出最擅长的一项：</div>	
		<div class="btn-group btn-group-justified">
		  <a class="btn btn-default btn-lg">Java</a>
		  <a type="button" class="btn btn-default btn-lg btn-info">C++</a>
		  <a type="button" class="btn btn-default btn-lg">数据库</a>
		</div>
	<div class="title">3、请在下面一组中选出最擅长的一项：</div>
		<div class="btn-group btn-group-justified">
		  <a class="btn btn-default btn-lg">Java</a>
		  <a type="button" class="btn btn-default btn-lg">C++</a>
		  <a class="btn btn-default btn-lg">Java</a>
		</div>
   </div> 
 <div class="btn_area">    
     <button class="btn btn-info" id="the_next" type="button">提交</button> 
     <a href="#topic2" data-transition="slide" data-role="button" id="first"><font class="next_one">提交</font></a>
 </div>     
    </form>
  </div>
</div>

   <!-- 显示部分 -->
  <div data-role="page" id="topic2"> 
         <div class="topheader">
      <ul>
         <li class="toptitle">考前须知</li>
      </ul>
      <div style="clear:both;"></div>
   </div>
  <div  id="topic">
 <!-- Title -->

  <!-- 内容 --> 
    <div id="content">
    您参加的是2014年亚信联创春季校园招聘会。<br><br>
 考试说明：
   <ul>   
      <li>考试时长<font id="suggestTime"></font>分钟</li>
      <li>共有<font id="questionLength"></font>道题，题型包含<font id="partDesc"></font></li>
      <li>错选、漏选均不得分。</li>
   </ul>    
 <!-- 
     <ul>
       <li>计算机基础：<font class="tot_num">20题</font></li>
        <li>Java基础：<font class="tot_num">20题</font></li>
        <li>数据库：<font class="tot_num">10题</font></li>
        <li>英语：<font class="tot_num">10题</font></li>
     </ul>
    
      <br>祝您取得好成绩！         --> 
    </div>          
          
    </div>  
  <!-- 按钮 -->
    <div  data-theme="b" class="btn_area">
      <button class="btn btn-info btn-block" id="konw">我知道了</button>   
    </div>
</div>
</div>    
</div>
  </body>
</html>

<script type="text/javascript">
         $(document).ready(function(){

       
	     $('#the_next').click(function(){
	         $('#first').click();
              $.ajax({
		url: "schoolExam/generatePaper/",
		type : "post",
		dataType : "json",
		data : {"passcode":"123","language":"java","companyWeixinId":"123456abc","weixinId":"zhangjg"},
		success :  function(result){
		
          $('#partDesc').text(result.data.partDatas[0].partDesc);
         $('#suggestTime').text(result.data.partDatas[0].suggestTime/60);
         $('#questionLength').text(result.data.partDatas[0].questionLength); 
		},
		      
			   
		
		

	}); 
	     });
         /* alert("题目类型:  "+result.data.partDatas[0].partDesc+"答题时间："+result.data.partDatas[0].suggestTime/60+"分钟"+result.data.partDatas[0].questionIds[0].answered); */

         $('#konw').click(function jump(){

 /*result.data.partDatas[0].questionIds[0].questionId*/
	location.href="page3.jsp"
         });
         });
</script>

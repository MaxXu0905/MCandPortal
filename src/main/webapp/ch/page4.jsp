<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>2014年亚信联创春季校园招聘会</title>
    <meta name="viewport" content="width=device-width,target-densitydpi=medium-dpi,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<link rel="stylesheet" href="css/bootstrap.css" />

	

	<link rel="stylesheet" href="css/jquery.mobile.theme-1.4.2.css" />

	<script type="text/javascript" src="js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.min.js"></script>
	<script type="text/javascript" src="js/jquery.mobile-1.4.2.min.js"></script>

    <style type="text/css">
    	    body,div,button,ul,li,a,header,h4,input{
    	font-family:"Open Sans",Arial,"Hiragino Sans GB","Microsoft YaHei","微软雅黑","STHeiti","WenQuanYi Micro Hei",SimSun,sans-serif;
	color: #666666;
    } 
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
  <body onload="hidenShare()">
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
      <li>考试时长60分钟</li>
      <li>共有30道题，题型包含单选题和多选题</li>
      <li>多选题有一个或多个答案，多选、少选均不得分。</li>
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
  </body>
</html>

<script type="text/javascript">
	
	function hidenShare(){
		//隐藏分享
		 document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
 	     WeixinJSBridge.call('hideOptionMenu');
 	 });
 	
	} 	
	
      $(document).ready(function(){
         $('#konw').click(function jump(){
            location.href="page3.jsp#wechat_webview_type=1";
           }); 
         });
    
	
</script>

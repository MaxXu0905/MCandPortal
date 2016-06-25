<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
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
	    #content{font-size:13pt; padding:0.8em 1.2em 2.0em 1.2em; line-height:1.6em;}
	   #content >div{color:#00a8ff;padding:0.5em;margin:1.0em 0em; border:1px solid #d6d6d6;line-height:1.5em;background:#fff;
	   font-size:18pt;
	   }
	    .btn_area{
	    padding:0.1em 1.2em;
	    }
	 	 .btn-info{background:#00a8ff;border:1px solid #0091dc;font-size:16pt;}
	    .btn-info:hover{background:#0092dd;border:1px solid #0080c3;font-size:16pt;}  
		 h1{display:none}
    	 li{list-style: none}
    </style>    
  </head>
  
  <body onload="hidenShare()">
  <div  id="topic">
 <!-- Title -->

  <!-- 内容 --> 
    <div id="content">
    感谢您参加2014年亚信联创春季校园招聘会。
    <div>
    请您随时关注我们的微信公众号信息,考试结果将通过微信公众号通知您！
    </div>          
   祝您成功！    <br>
   亚信联创科技（中国）有限公司人力资源部         
    </div>  
  <!-- 按钮 -->
  <!-- 
    <div  data-theme="b" class="btn_area">
      <button class="btn btn-info btn-block" id="konw">提交试卷</button>   
    </div>
  -->
</div>
  </body>
</html>

<script type="text/javascript">
	//隐藏
	function hidenShare(){
		//隐藏分享
		 document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
 	     WeixinJSBridge.call('hideOptionMenu');
 	 });
 	
	}
      $(document).ready(function(){
         
      });

</script>

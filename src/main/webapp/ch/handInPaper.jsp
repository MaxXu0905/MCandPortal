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
	<link rel="stylesheet" href="<%= request.getContextPath() %>/lib/bootstrap/css/bootstrap.css" />
    <link rel="stylesheet" href="<%= request.getContextPath() %>/lib/jquery-mobile/css/jquery.mobile.theme-1.4.2.css" />	
	<script type="text/javascript" src="<%= request.getContextPath() %>/lib/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="<%= request.getContextPath() %>/lib/bootstrap/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="<%= request.getContextPath() %>/lib/jquery-mobile/js/jquery.mobile-1.4.2.min.js"></script>	
    <link rel="stylesheet" href="<%= request.getContextPath() %>/page/ch/chstyle.css" />
    <style type="text/css">
	    #headr{text-align: center;padding:0.8em;border-bottom:1px solid #d2d2d2;margin:0px 1.3em;}
	    #content{font-size:13pt; padding:0.8em 1.2em 2.0em 1.2em; line-height:1.6em;}
		 h1{display:none}
    </style>    
  </head>
  
  <body onload="hidenShare()">
   <div class="topbanner"></div> 
  <div  id="topic">
 <!-- Title -->

  <!-- 内容 --> 
    <div id="content">
  
    感谢您参加2014年亚信联创春季校园招聘会。
    <div class="notice_end">
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
	var company_name = "${sessionScope.SESSION_COMPANY_NAME}";
	var act_id = "${sessionScope.SCHOOL_WEIXIN_SESSION}";
	act_id = act_id.activityId;
	console.log("company_name : "+company_id+",act_id : "+act_id);
      $(document).ready(function(){
         $.ajax({
         url:"<%=request.getContextPath()%>/wx/schoolExam/handInPaper",
         type : "post",
         contentType: 'application/json',
		 dataType : "json",
         
         })
      });

</script>

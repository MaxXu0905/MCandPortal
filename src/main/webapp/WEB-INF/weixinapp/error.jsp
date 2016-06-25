<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
 <title>百一测评系统</title>
    <meta name="viewport" content="width=device-width,target-densitydpi=medium-dpi,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
  
	
    <link rel="stylesheet" href="<%= request.getContextPath() %>/page/ch/chstyle.css" />
<title>错误</title>
</head>
  <body>
	<div data-role="page">
	   <div class="error">
		  <div id="error">333</div>
	   </div>  
	</div> 
</body>
<script src="<%=request.getContextPath()%>/page/appframework.min.js"></script>
<script type="text/javascript">
	var status = "${sessionScope.status}";
	var msg = "${sessionScope.message}";
	var errormsg = document.getElementById('error');
	if (status == "EXCEPTION") {
		errormsg.innerHTML = "百一系统异常了，马上联系百一客服：18601322635，<br/>或者发送邮件：service@101test.com 。<br/>给您的带来的不便，敬请谅解。";
	} else if (status == 8) {
		errormsg.innerHTML = "请不要同时进行考试。如果不能进入另一次考试，请尝试清空浏览器缓存或者重启浏览器进入。如果不能进行正常考试，马上联系百一客服：18601322635，或者发送邮件：service@101test.com 。\n给您的带来的不便，敬请谅解。";
	} else if (status == 13) {
		errormsg.innerHTML = "考试会话超时，请重新点击考试链接，尝试重新进入。如果不能进行正常考试，马上联系百一客服：18601322635，或者发送邮件：service@101test.com 。\n给您的带来的不便，敬请谅解。";
	} else {
		errormsg.innerHTML = msg;
	}
</script>
</html>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE>
<html>
  <head>
    <title>百一测评系统</title>
    <meta name="viewport" content="width=device-width,target-densitydpi=medium-dpi,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/lib/bootstrap/css/bootstrap.min.css" />
  
	<link rel="stylesheet" href="<%= request.getContextPath() %>/lib/jquery-mobile/css/jquery.mobile-1.3.2.min.css" />
	<link rel="stylesheet" href="<%= request.getContextPath() %>/lib/jquery-mobile/css/jquery.mobile.theme-1.4.2.css" />
	
	<script type="text/javascript" src="<%= request.getContextPath() %>/plugin/json2.js"></script>
	<script type="text/javascript" src="<%= request.getContextPath() %>/lib/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="<%= request.getContextPath() %>/lib/bootstrap/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="<%= request.getContextPath() %>/lib/jquery-mobile/js/jquery.mobile-1.4.2.min.js"></script>	
     <link href="<%=request.getContextPath()%>/lib/bootstrap/css/font-awesome.min.css" rel="stylesheet" /> 
    <link rel="stylesheet" href="<%= request.getContextPath() %>/page/ch/chstyle.css" />
  </head> 
  <body>
 
<div data-role="page">
  <div class="page404"><i class="icon-exclamation-sign"></i></div>
  <div class="error">Sorry，您访问的页面不存在！<br>请尝试重新加载！
  
    <button class="btn btn-default btn-lg btnerror"><i class="icon-repeat"></i>重新加载</button>
  
  
  </div>  
 </div> 

</html>


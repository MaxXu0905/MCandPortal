<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
  <head>
    
    <title></title>
    <meta name="viewport" content="width=device-width,target-densitydpi=medium-dpi,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
    <script src="<%= request.getContextPath() %>/page/appframework.js"></script>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/page/ch/chstyle.css" />
    <style type="text/css">
	    #headr{text-align: center;padding:0.8em;border-bottom:1px solid #d2d2d2;margin:0px 1.3em;}
	    #content{font-size:13pt; padding:0.8em 1.2em 2.0em;line-height:30px; }
		 h1{display:none}
		 a{text-decoration: none}
		 .link{ white-space: nowrap;
				cursor: pointer;
				font-family: inherit;
				font-size: 18px;
				overflow: hidden;
				color: #0091dc;
				font-weight: 600;
		 }
		 .code_end{padding-top:40px;}
		 .code_end ul{padding:0px;margin:0px;border:1px solid #ff0000;height:120px;padding:10px;background:#fff;border:1px dashed #cbcbcb;}
		 .code_end li{float:left;list-style-type:none;margin-right:3px;line-height:32px;}
		 .code_text{color:#0091dc;font-size:18px;line-height:38px;}
    </style>    
  </head>
  
  <body>
   <div class="topheader" style="margin-top:2px;">
  考试完成
   </div> 
  <div  id="topic">
 <!-- Title -->

  <!-- 内容 --> 
    <div id="content">
  
    感谢您参加<span class="activity"></span>。
<!--     <br>
    关注<a href="weixin://contacts/profile/gh_f5c18da52a08"><b class="link">百一微测试</b></a>，测评成绩早知道。<br> -->
     祝您成功！   
      <br>
   <span class="company_name"></span>人力资源部         
<!--  <div class="code_end" style="display:none">
      <ul>   
        <li><img src="http://101testneeds.oss-cn-beijing.aliyuncs.com/pictures/employee/qrcode_for_employee_0.jpg" /></li> 
        <li class="code_text" style="padding-top:20px;">扫一扫<br>测评结果早知道<br>公众号：百一微测试</li>
     </ul> 
     <div style="clear:both;"></div>
     </div>   -->
    </div>  

</div>
  </body>
</html>

<script type="text/javascript">
	var act_id = '${sessionScope.SCHOOL_INFO}';
	var company_name = JSON.parse(act_id).companyName;
	var weixinCompany = JSON.parse(act_id).weixinCompany;
	var activity_name = JSON.parse(act_id).positionName;
	document.title = activity_name;
	$('.company_name').text(company_name);
	$('.activity').text(activity_name);
	var root = "<%=basePath%>";
	if(weixinCompany==1){
		$('.code_end').show();
	}
</script>
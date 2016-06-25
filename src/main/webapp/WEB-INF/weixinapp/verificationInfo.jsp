<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html>
   <head>
    <title>百一测评系统</title>
    <meta name="viewport" content="width=device-width,target-densitydpi=medium-dpi,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
    <script src="<%=request.getContextPath()%>/page/appframework.min.js"></script>
    <link rel="stylesheet"
	href="<%=request.getContextPath()%>/page/ch/chstyle.css" />
      
  </head> 
  
  <style type="text/css">
  .info{width:90%;height:50px;padding-left: 20pt}.btn-block{margin-top:20px;width:100% !important}.btn-info{background:#00a8ff!important;border:1px solid #0091dc;font-size:13pt;color:#fff!important;height:50px !important}.btn-info:hover{background:#0092dd!important;border:1px solid #0080c3;font-size:13pt;color:#fff}
  .wrong_shadow {
	border: 1px solid #f36767 !important;
	box-shadow: 0 1px 1px rgba(0, 0, 0, 0.075) inset, 0 0 8px
		rgba(243, 103, 103, 0.4) !important;
	outline: 0 none;
}
  </style>
  
  <body>
    <div style="margin-top:16px" >
			<div class="topheader">填写考试口令 ：</div>
			<form method="post" action="" style="width:92%;margin-top:10px;margin-left:3%">
                <input type="text" placeholder="请填写考试口令" class="info" id = "passcode">

				<button type="button" id="startExam" class=" btn-info btn-block "
					style="margin-top:20px;">进入考试</button>
			</form>
		</div>
	<div style="margin-top:25%;width:92%;margin-left:3%" id="demo-content">
	  <a href="http://www.101test.com/campus/wx/index/gh_df877ca37d29_demo?modelFlag=1" style="display:block;width:100%;text-align: center;border:1px dashed red;color:red;height:50px;line-height:50px">进入练习</a>
    </div>
  </body>
</html>


<script type="text/javascript">
      (function(){
         var root = "<%=basePath%>";
           function bindEvent(){
           $('#passcode').focus(function(){
           		$(this).removeClass('wrong_shadow');
           		$('#demo-content').hide();
           });
           $('#passcode').blur(function(){
           		$('#demo-content').show();
           });
               $('#startExam').click(function(){
                  var passcode = $('#passcode').val();
                  var $startBtn = $('#startExam');
                  if(passcode!=""){
                   $.ajax({
                      url:root+'wx/schoolInfo/getPositionByPassport/'+passcode,
                      type:'post',
                      dataType:'json',
                      beforeSend:function(){
                         $startBtn.attr('disabled','disabled').text("口令验证中。。。。");
                      },
                      contentType:'application/json',
                      success:function(result){
                           var companyId = result.data;
                               location.replace(root+"wx/index/"+companyId);
                           
                      },
                      error:function(){
                      	 alert("您的网络出现问题了，请检查网络后重试");
                         $startBtn.removeAttr('disabled').text("进入考试");
                      },
                      complete:function(){
                      }
                   })
                  }else{
                  		$('#passcode').addClass('wrong_shadow');
                  }
               });
           }
           
           //
           $(document).ready(function(){
               bindEvent();
           });
      })();
      
      var position_option  = {
    			enableHighAccuracy:true,
    			maximumAge: 30000,
    			timeout:20000
    		};

    		//navigator.geolocation.getCurrentPosition(getPositionSuccess,getPositionError, position_option);

    		function getPositionSuccess(position ){
    		  var lat = position.coords.latitude;
    			var lng = position.coords.longitude;
    			alert("您所在的位置： 纬度" + lat + "，经度" + lng );
    			if(typeof position.address !== "undefined"){
    				 var country = position.address.country;
    				 var province = position.address.region;
    					var city = position.address.city;
    					alert('您位于 ' + country + province + '省' + city +'市');
    			}

    		}


    		function getPositionError(error)
    		 {
    				switch (error.code)
    		 		{

    		        case error.TIMEOUT:

    		            alert("连接超时，请重试");

    		            break;

    		        case error.PERMISSION_DENIED:

    		            alert("您拒绝了使用位置共享服务，查询已取消");

    		            break;

    		        case error.POSITION_UNAVAILABLE:

    		            alert("获取位置信息失败");

    		            break;

    		    }

    		}
      
</script>
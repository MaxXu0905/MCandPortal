<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE>
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>2014年亚信联创春季校园招聘</title>	
    <meta name="viewport" content="width=device-width,target-densitydpi=medium-dpi,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" href="css/bootstrap.css" />
	<link rel="stylesheet" href="css/jquery.mobile-1.4.2.min.css" />
	<script type="text/javascript" src="js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.min.js"></script>
	<script type="text/javascript" src="js/jquery.mobile-1.4.2.min.js"></script> 

    <style type="text/css">
    body{
    background:#f4f4f4 !important;
    padding:0px;
    margin:0px;
    }
    body,div,button,ul,li,a,header,h4,input{
    	font-family:"Open Sans",Arial,"Hiragino Sans GB","Microsoft YaHei","微软雅黑","STHeiti","WenQuanYi Micro Hei",SimSun,sans-serif;
	color: #666666;
    }
    .index_input{font-size:12pt  !important;}
	#banner_back{ margin-top:-100px; width:100%; padding:0.6em 0em;text-align:center;
	/* background:url("images/logo.png") no-repeat center center !important; */
	}
	header{ margin-top:-10px; margin-left:0px;}
	#title{background:#ffcc00;padding:1.5em;}
	h4{ text-align:center;color:#4a4949;padding-top:20px;}
	form{margin: 0 auto;}
	/* input, textarea{font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;background-color: #fff;border: 1px solid #ccc;font-size: 20px;width: auto;display: block;margin-bottom: 16px;margin-top: 5px; }
	 */textarea{ height:auto; width:500px}
	 .right{ width:30px;height:30px;margin-left:305px;margin-top:-43px; display:none;}
	 .wrong{ width:30px;height:30px;margin-left:305px;margin-top:-43px;display:none;}
  	
#username{
background:url("images/user.png") no-repeat 0.6em center !important;
 padding-left:2.4em  !important;
}
#email{
background:url("images/mail.png") no-repeat 0.6em center !important;
 padding-left:2.4em  !important;
}	
#tel{
background:url("images/tel.png") no-repeat 0.6em center !important;
 padding-left:2.4em  !important;
}
#school{
background:url("images/school.png") no-repeat 0.6em center !important;
 padding-left:2.6em  !important;
}
label{margin:0px; !important; height:0.1em !important;}
.login{background:#f8f8f8;padding-top:10px;}
	 	 .btn-info{background:#00a8ff;border:1px solid #0091dc;font-size:16pt;}
	    .btn-info:hover{background:#0092dd;border:1px solid #0080c3;font-size:16pt;}  
#save_messages{margin-top:0.7em;}
.top{
height:138px;
background:rgba(0, 146, 221, 0.6);
color:#fff;
padding:8px 20px;
font-weight:600;
font-size:16px;
line-height:24px;
}
.title_a{font-family:Arial;font-size:40px;font-weight:700;line-height:1.1em;color:#fff;}
.headertop{
background:url("images/01.gif") no-repeat top center;
padding:40px 20px 10px 20px;
margin-top:-19px;

}

	</style>
    <script type="text/javascript">
    	var root = "<%=basePath %>";
    	
    </script>
  </head>
  
  <body onload="hidenShare()">
      
 
<div class="headertop">
    <div class="top">
	<DIV class="title_a">Hello,</DIV>
	您所在的学校还未开始宣讲，敬请期待！<br>您可以先去完善个人信息。
	</div>
</div>    
<header id="banner" >


<!-- 
<div id="banner_back">2014年亚信联创春季校园招聘会</div>
<img src="images/01.gif" id="banner_back">
 -->
</header>
  <!-- Tittle部分 -->
        <!-- 用户信息部分 -->
  <!--  <h4>2014年亚信联创春季校园招聘会</h4>  -->    
    <div data-role="content" class="login">
    <form method="post" action="">
  <label for="username">&nbsp;</label>
    <input type="text" id="username" name="username" class="index_input" placeholder="请填写真实姓名">
   <label for="email">&nbsp;</label>
    <input type="text" id="email" name="email" class="index_input"  placeholder="请填写邮箱">
    <label for="tel">&nbsp;</label>
    <input type="text" id="tel" name="tel" class="index_input" placeholder="请填写电话号">
  <label for="school">&nbsp;</label>
    <input type="text" id="school" name="school" class="index_input" placeholder="请填写毕业院校">
   <label for="school">&nbsp;</label> 
   <button type="button" id="save_messages" class="btn btn-info btn-block">保存信息</button>
    </form>
    </div>
</body>
</html>


<script type="text/javascript">
//发送状态码的json 同时接到后台传来的一个json值来判断是保存信息页面还是开始测评页面
	//隐藏微信页面分享功能键   
/* 	$(document).ready(function(){
      	 document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
 	     WeixinJSBridge.call('hideOptionMenu');
 		 }); */
function hidenShare(){
		//隐藏分享
		 document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
 	     WeixinJSBridge.call('hideOptionMenu');
 	 });
 	
	} 		 
    
 
$.ajax({
		url : root + "/GetJsonServlet",
		type : "post",
		dataType : "json",
		data : {"res":"2"},
		success : function(data) {
			if(data.re=='notime')
			{
			  $('#save_messages').text('保存信息');
			  $('#title').show();
			}
			if(data.re!='notime')
			{
			 // alert(data.re);
			  $('#save_messages').text('开始考试');
			   $('#title').hide();
			}
			if(data.userName!='')
			{
			   $('#username').val(data.userName);
			   $('#email').val(data.email);
			   $('#tel').val(data.tel);
			   $('#school').val(data.school);
			}
		
		},
		error : function(e){
		},
	});



/* var txt = '{ "employees" : [' +
'{ "userName":"Kobe" , "email":"921541921@qq.com","tel":"15568584988","school":"长春理工大学光电信息学院" },' +
'{ "userName":"" , "email":"","tel":"","school":"" },' +
'{ "userName":"" , "email":"","tel":"","school":"" } ]}';

var obj= eval ("(" + txt + ")");

document.getElementById("username").value = obj.employees[0].userName;
document.getElementById("email").value = obj.employees[0].email;
document.getElementById("tel").value = obj.employees[0].tel;
document.getElementById("school").value = obj.employees[0].school; */

$(document).ready(function(){
    $('#save_messages').removeClass('ui-btn ui-shadow ui-corner-all'); 
   	if($('#username').val()!='')
     {
       $('#save_messages').text('开始测评');
      
     };
     
     
     //验证真实姓名
     $('#username').focus(function(){
     var username = $.trim($('#username').val());
     //获取焦点恢复初始样式
     $('#username').css('background-color','white');

     });
     
     $('#username').blur(function(){
     var Name=/^[\u4e00-\u9fa5]+$/;   
     var username = $.trim($('#username').val());
     if(!username)
     {
        //$(this).parent().next().next().show();
        $('#username').val('');
        $('#username').css('border','1px solid #ff3600');
     }
     if(!Name.test(username))
     {
       // $(this).parent().next().next().show();
        $('#username').css('border','1px solid #ff3600');
     }
     if(username!='')
     {
        if(Name.test(username))
     {
        $('#username').css('border','1px solid #00da29');
       // $(this).parent().next().show();
     }
        
     }
    
     });
     
     //验证email
     $('#email').focus(function(){
     var email = $.trim($('#email').val());
     //获取焦点恢复初始样式
     $('#email').css('background-color','white');

     });
     
     $('#email').blur(function(){
     var email = $.trim($('#email').val());
     var check = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
     if(!email)
     {
       // $(this).parent().next().next().show();
        $('#email').val('');
        $('#email').css('border','1px solid #ff3600');
     }
     if(!check.test(email))
     {
  	   // $(this).parent().next().next().show();
        $('#email').css('border','1px solid #ff3600');
     }
     if(email!='')
     {
        if(check.test(email))
        {
        $('#email').css('border','1px solid #00da29');
       // $(this).parent().next().show();
        }
     }
     
     });
     
     //验证电话
     $('#tel').focus(function(){
     var tel = $.trim($('#tel').val());
     //获取焦点恢复初始样式
     $('#tel').css('background-color','white');

     });
     
     $('#tel').blur(function(){
     var tel = $.trim($('#tel').val());
     var num =/^(\(\d{3,4}\)|\d{3,4}-|\s)?\d{7,14}/;
     if(!tel)
     {
        $('#tel').css('border','1px solid #ff3600');
        $('#tel').val('');
        //$(this).parent().next().next().show();
     }
     if(!num.test(tel))
     {
        $('#tel').css('border','1px solid #ff3600');
       // $(this).parent().next().next().show();
     }
     if(tel!='')
     {
       if(num.test(tel)){
        $('#tel').css('border','1px solid #00da29');
       // $(this).parent().next().show();
        }
     }
     
     });
     
      //验证学校
     $('#school').focus(function(){
     var school = $.trim($('#school').val());
     //获取焦点恢复初始样式
     $('#school').css('background-color','white');

     });
     
     $('#school').blur(function(){
     var school = $.trim($('#school').val());
     if(!school)
     {
        $('#school').css('border','1px solid #ff3600');
        $('#school').val('');
        //$(this).parent().next().next().show();
     }
     if(school!='')
     {
        $('#school').css('border','1px solid #00da29');
       // $(this).parent().next().show();
     }
     });
     
     //保存验证
     $('#save_messages').click(function(){
        var username = $.trim($('#username').val());
        var email = $.trim($('#email').val());
        var tel = $.trim($('#tel').val());
        var school = $.trim($('#school').val());
        var choice = $('#save_messages').text();

        if(username=='')
        {
           $('#username').css('border','1px solid #ff3600');
          // $('#username').parent().next().next().show();
        }
        if(email=='')
        {
           $('#email').css('border','1px solid #ff3600');
          // $('#email').parent().next().next().show();
        }
        if(tel=='')
        {
           $('#tel').css('border','1px solid #ff3600');
           //$('#tel').parent().next().next().show();
        }
        if(school=='')
        {
           $('#school').css('border','1px solid #ff3600');
          // $('#school').parent().next().next().show();
        }
        
        if(tel!=''&&school!=''&&email!=''&&username!='')
        {
          if(choice=='保存信息')
          {
          	var requestData = {
			username: $('#username').val(),
			email: $('#email').val(),
			tel: $('#tel').val(),
			school : $('#school').val(),
		    "resultsave":"1",
		};
	 	  $.ajax({
			url : root + "/CoreServlet",  //保存信息时做提交
			type : "post",
			dataType : "json",
			data : requestData,
		 	success : function(data) {
				if(data.re == "notime")
				{
				window.close();
				// alert(data.re);  //已经获取到从后台传过来的消息
				}
			},
			error : function(e){
				//alert("error");
			},
		});
             //跳转到信息界面
   			
          }
           if(choice=='开始考试')
          {
   			 location.href="page4.jsp#wechat_webview_type=1";
   	
          } 
        }
        
     });
     

});
</script>

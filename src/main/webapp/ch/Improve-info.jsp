<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
%>

<!DOCTYPE>
<html>
<head>
<base href="<%=basePath%>">

<title>2014年亚信联创春季校园招聘</title>
<meta name="viewport"
	content="width=device-width,target-densitydpi=medium-dpi,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/lib/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/lib/jquery-mobile/css/jquery.mobile-1.4.2.min.css" />
<script type="text/javascript"
	src="<%=request.getContextPath()%>/plugin/json2.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/lib/jquery-1.9.1.min.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/lib/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/lib/jquery-mobile/js/jquery.mobile-1.4.2.min.js"></script>

<style type="text/css">
body {
	background: #f4f4f4 !important;
	padding: 0px;
	margin: 0px;
}

body,div,button,ul,li,a,header,h4,input {
	font-family: "Open Sans", Arial, "Hiragino Sans GB", "Microsoft YaHei",
		"微软雅黑", "STHeiti", "WenQuanYi Micro Hei", SimSun, sans-serif;
	color: #666666;
}

.index_input {
	font-size: 12pt !important;
}

#banner_back {
	margin-top: -100px;
	width: 100%;
	padding: 0.6em 0em;
	text-align: center;
	/* background:url("images/logo.png") no-repeat center center !important; */
}

header {
	margin-top: -10px;
	margin-left: 0px;
}

#title {
	background: #ffcc00;
	padding: 1.5em;
}

h4 {
	text-align: center;
	color: #4a4949;
	padding-top: 20px;
}

form {
	margin: 0 auto;
}
/* input, textarea{font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;background-color: #fff;border: 1px solid #ccc;font-size: 20px;width: auto;display: block;margin-bottom: 16px;margin-top: 5px; }
	 */
textarea {
	height: auto;
	width: 500px
}

.right {
	width: 30px;
	height: 30px;
	margin-left: 305px;
	margin-top: -43px;
	display: none;
}

.wrong {
	width: 30px;
	height: 30px;
	margin-left: 305px;
	margin-top: -43px;
	display: none;
}

#username {
	background: url("<%=request.getContextPath()%>/core/images/user.png")
		no-repeat 0.6em center !important;
	padding-left: 2.4em !important;
}

#email {
	background: url("<%=request.getContextPath()%>/core/images/mail.png")
		no-repeat 0.6em center !important;
	padding-left: 2.4em !important;
}

#tel {
	background: url("<%=request.getContextPath()%>/core/images/tel.png")
		no-repeat 0.6em center !important;
	padding-left: 2.4em !important;
}

#school {
	background: url("<%=request.getContextPath()%>/core/images/school.png")
		no-repeat 0.6em center !important;
	padding-left: 2.6em !important;
}

label {
	margin: 0px; ! important;
	height: 0.1em !important;
}

.login {
	background: #f8f8f8;
	padding-top: 10px;
}

.btn-info {
	background: #00a8ff;
	border: 1px solid #0091dc;
	font-size: 16pt;
}

.btn-info:hover {
	background: #0092dd;
	border: 1px solid #0080c3;
	font-size: 16pt;
}

#save_messages {
	margin-top: 0.7em;
}

.top {
	height: 138px;
	background: rgba(0, 146, 221, 0.6);
	color: #fff;
	padding: 8px 20px;
	font-weight: 600;
	font-size: 16px;
	line-height: 24px;
}

.title_a {
	font-family: Arial;
	font-size: 40px;
	font-weight: 700;
	line-height: 1.1em;
	color: #fff;
}

.headertop {
	background: url("<%=request.getContextPath()%>/core/images/01.gif")
		no-repeat top center;
	padding: 40px 20px 10px 20px;
	margin-top: -19px;
}
</style>
<script type="text/javascript">
    	var root = "<%=basePath%>";
</script>
</head>

<body>
	<div class="headertop">
		<div class="top">
			<DIV class="title_a">Hello,</DIV>
			您所在的学校还未开始宣讲，敬请期待！<br>您可以先去完善个人信息。
		</div>
	</div>
	<header id="banner">


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
			 <input type="text" id="FULL_NAME" name="FULL_NAME" class="index_input"placeholder="请填写真实姓名"> 
			 <label for="email">&nbsp;</label> 
			 <input type="text" id="EMAIL" name="EMAIL" class="index_input"placeholder="请填写邮箱"> 
			 <label for="tel">&nbsp;</label> 
			 <input type="text" id="PHONE" name="PHONE" class="index_input" placeholder="请填写电话号"> 
			 <label for="switch"></label>
       		 <select name="SEX" id="SEX" data-role="slider">
		          <option value="2"  selected="selected">男</option>
		          <option value="1">女</option>
        	 </select>
			 <label for="school">&nbsp;</label> 
			 <input type="text" id="GRADUATE_COLLEGE" name="GRADUATE_COLLEGE" class="index_input" placeholder="请填写毕业院校"> 
		
	         <label for="day">&nbsp;</label>
		        <select name="EDUCATION" id="EDUCATION">
		         <option value="1">本科</option>
		         <option value="2">硕士</option>
		         <option value="3">博士</option>
		         <option value="4">大专</option>
		         <option value="5">其他</option>
		    	</select>
		    <label for="day">&nbsp;</label>
		        <select name="POSTGRADUATE_APPLIED" id=POSTGRADUATE_APPLIED>
		         <option  selected="selected">是否报考研究生</option>
		         <option value="1">是</option>
		         <option value="0">否</option>
		    	</select>
	    
			<button type="button" id="save_messages"class="btn btn-info btn-block">保存信息</button>
		</form>
	</div>
</body>
</html>


<script type="text/javascript">

	function hidenShare() {
		//隐藏分享
		document.addEventListener('WeixinJSBridgeReady',
				function onBridgeReady() {
					WeixinJSBridge.call('hideOptionMenu');
				});
	}

	 	var companyWeixinId = "123456abc";
		var weixinId = "123123";
	function schoolLogin(weixinId,activityId){
		$.ajax({
			url:root+"wx/schoolLogin/"+weixinId+"/"+activityId,
			type:"post",
			dataType:"json",
			success:function(result){
				if(result.code!=0){
				 alert("login error");
				}
				getInput();
			}
			
		});
	
	}
	function getInput() {
	
		$.ajax({
			url : root+"wx/schoolInfo/getInput",
			type : "post",
			contentType : "application/json",
			dataType : "json",
			success : function(result) {
				console.log(result)
				if (result.code != 0) {
					alert("getinput error");
					return;
				}
				var datas = result.data;
				for ( var i = 0; i < datas.length; i++) {
					var data = datas[i];
					$("#"+data.infoId).val(data.value);  //获取数据填充到表单中
				}
			}
		});
	}
	function conmmitInfo(datas){

			$.ajax({
						    url: root+"wx/schoolInfo/commitInfo",
							type : "post",
							contentType:"application/json",
							dataType : "json",
							data : JSON.stringify(datas),
							success : function(result){
							console.log(result);
							if(result.code!=0){
							alert("save error!");
							return;
							}
							else{
							location.href="www.baidu.com";
							}
						}
						}); 
	}
	$(document).ready(function() {
						var reqData = {
							"passcode" : "beiyou"
						};
						$.ajax({
							url :root+"wx/schoolInfo/getActivityId/"+companyWeixinId,
							type : "post",
							contentType : "application/json",
							dataType : "json",
							data : JSON.stringify(reqData),
							success : function(result) {
							
								if (result.code != 0) {
									return;
								}
								var activityId = result.data.activityId;
								
								schoolLogin(weixinId,activityId);

							},
							
						});
						       
								var datas = [] ;
								var data = {};
								data.id = {infoId:"FULL_NAME"};
								data.value = $('#FULL_NAME').val();
								data.realValue = data.value ;
								datas.push(data);
													
												
								var data = {};
								data.id = {infoId:"EMAIL"};
								data.value = $('#EMAIL').val();
								data.realValue = data.value ;
								datas.push(data);
													
								var data = {};
								data.id = {infoId:"GRADUATE_COLLEGE"};
								data.value = $('#GRADUATE_COLLEGE').val();
								data.realValue = data.value ;
								datas.push(data);
													
								var data = {};
								data.id = {infoId:"SEX"};
								data.value = $('#SEX').val();
								data.realValue = $("#SEX").find("option:selected").text();
								datas.push(data);	
					
					//點擊提交按鈕調用conmmitInfo方法							
					$('#save_messages').click(function(){
					   
					 //   console.dir(datas);
						conmmitInfo(weixinId,datas);
					});
					return;
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
						$('#save_messages').removeClass('ui-btn ui-shadow ui-corner-all');
						if ($('#username').val() != '') {
							$('#save_messages').text('开始测评');

						};

						//验证真实姓名
						$('#username').focus(function() {
							var username = $.trim($('#username').val());
							//获取焦点恢复初始样式
							$('#username').css('background-color', 'white');

						});

						$('#username')
								.blur(
										function() {
											var Name = /^[\u4e00-\u9fa5]+$/;
											var username = $
													.trim($('#username').val());
											if (!username) {
												//$(this).parent().next().next().show();
												$('#username').val('');
												$('#username').css('border',
														'1px solid #ff3600');
											}
											if (!Name.test(username)) {
												// $(this).parent().next().next().show();
												$('#username').css('border',
														'1px solid #ff3600');
											}
											if (username != '') {
												if (Name.test(username)) {
													$('#username')
															.css('border',
																	'1px solid #00da29');
													// $(this).parent().next().show();
												}
											}
									});

						//验证email
						$('#email').focus(function() {
							var email = $.trim($('#email').val());
							//获取焦点恢复初始样式
							$('#email').css('background-color', 'white');

						});

						$('#email')
								.blur(
										function() {
											var email = $.trim($('#email')
													.val());
											var check = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
											if (!email) {
												// $(this).parent().next().next().show();
												$('#email').val('');
												$('#email').css('border',
														'1px solid #ff3600');
											}
											if (!check.test(email)) {
												// $(this).parent().next().next().show();
												$('#email').css('border',
														'1px solid #ff3600');
											}
											if (email != '') {
												if (check.test(email)) {
													$('#email')
															.css('border',
																	'1px solid #00da29');
													// $(this).parent().next().show();
												}
											}

										});

						//验证电话
						$('#tel').focus(function() {
							var tel = $.trim($('#tel').val());
							//获取焦点恢复初始样式
							$('#tel').css('background-color', 'white');

						});

						$('#tel')
								.blur(
										function() {
											var tel = $.trim($('#tel').val());
											var num = /^(\(\d{3,4}\)|\d{3,4}-|\s)?\d{7,14}/;
											if (!tel) {
												$('#tel').css('border',
														'1px solid #ff3600');
												$('#tel').val('');
												//$(this).parent().next().next().show();
											}
											if (!num.test(tel)) {
												$('#tel').css('border',
														'1px solid #ff3600');
												// $(this).parent().next().next().show();
											}
											if (tel != '') {
												if (num.test(tel)) {
													$('#tel')
															.css('border',
																	'1px solid #00da29');
													// $(this).parent().next().show();
												}
											}

										});

						//验证学校
						$('#school').focus(function() {
							var school = $.trim($('#school').val());
							//获取焦点恢复初始样式
							$('#school').css('background-color', 'white');

						});

						$('#school').blur(
								function() {
									var school = $.trim($('#school').val());
									if (!school) {
										$('#school').css('border',
												'1px solid #ff3600');
										$('#school').val('');
										//$(this).parent().next().next().show();
									}
									if (school != '') {
										$('#school').css('border',
												'1px solid #00da29');
										// $(this).parent().next().show();
									}
								});

						//保存验证
						$('#save_messages').click(function() {
											var username = $.trim($('#username').val());
											var email = $.trim($('#email').val());
											var tel = $.trim($('#tel').val());
											var school = $.trim($('#school').val());
											var choice = $('#save_messages').text();

											if (username == '') {
												$('#username').css('border','1px solid #ff3600');
												// $('#username').parent().next().next().show();
											}
											if (email == '') {
												$('#email').css('border','1px solid #ff3600');
												// $('#email').parent().next().next().show();
											}
											if (tel == '') {
												$('#tel').css('border',
														'1px solid #ff3600');
												//$('#tel').parent().next().next().show();
											}
											if (school == '') {
												$('#school').css('border',
														'1px solid #ff3600');
												// $('#school').parent().next().next().show();
											}

											if (tel != '' && school != ''
													&& email != ''
													&& username != '') {
												if (choice == '保存信息') {
													
												
													$.ajax({
																url :root+"/wx/schoolInfo/commitInfo/{weixinId}", //保存信息时做提交
																type : "post",
																dataType : "json",
																data : requestData,
																success : function(
																		data) {
																	if (data.re == "notime") {
																		window
																				.close();
																		// alert(data.re);  //已经获取到从后台传过来的消息
																	}
																},
																error : function(
																		e) {
																	//alert("error");
																},
															});
													//跳转到信息界面

												}
												if (choice == '开始考试') {
													location.href = "page4.jsp#wechat_webview_type=1";

												}
											}

										});

					});
</script>

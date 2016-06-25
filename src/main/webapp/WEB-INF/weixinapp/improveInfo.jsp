<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">

<title></title>
<meta name="viewport"
	content="width=device-width,target-densitydpi=medium-dpi,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/page/ch/chstyle.css" />

<script type="text/javascript">
function change(a){$("#"+a).val(),$("#"+a).removeClass("ne")}var state,companyWeixinId,session_mail,session_name,weixinId,zz_name,zz_email,zz_phone,zz_college,root="<%=basePath%>";document.addEventListener("WeixinJSBridgeReady",function(){WeixinJSBridge.call("hideOptionMenu")}),state="",companyWeixinId="${requestScope.companyWeixinId}",session_mail="${sessionScope.SESSION_MAIL}",session_name="${sessionScope.SESSION_NAME}",weixinId="122122",zz_name=/^[^\s]+$/,zz_email=/^[\w\-][\w\-\.]*@[a-zA-Z0-9]+([a-zA-Z0-9\-\.]*[a-zA-Z0-9\-]+)*\.[a-zA-Z0-9]{2,}$/,zz_phone=/^\d{11}$/,zz_college=/^[^\s]+$/;
var companyId = "${requestScope.companyWeixinId}";var act_id = '${sessionScope.SCHOOL_INFO}';var modelFlag="${param.modelFlag}";var weixinCompany = JSON.parse(act_id).weixinCompany;var notify = JSON.parse(act_id).notifyScore
</script>
<style type="text/css">.exam_type >li{margin-bottom:15px}
.wrn{border:1px solid red !important}#topic2{display:none}.select_mod{font-size:14pt}.topheader{padding:4% 5% 4% 5%}.username{background:#fff;padding-left:1.4em !important}.email{background:#fff;padding-left:1.4em !important}.tel{background:#fff;padding-left:1.4em !important}.school{background:#fff;padding-left:1.4em !important}.chose_sex>li{float:left !important}.exam_type{padding:0}.exam_type>li{color:#00a8ff !important}.index_input{font-size:12pt!important;background:#fff!important}.yikaore{padding-top:15px;color:#ff5a00;padding-left:15px}#title{background:#fc0;padding:1.5em}h4{text-align:center;color:#4a4949;padding-top:20px}form{margin:0 auto}.toplist22 li{float:left;list-style:none}.right{width:30px;height:30px;margin-left:305px;margin-top:-43px;display:none}.wrong{width:30px;height:30px;margin-left:305px;margin-top:-43px;display:none}.login{background:#f8f8f8}#save_messages{margin-top:.7em}.back{position:absolute;left:0;top:0;padding:3%}.headertop{padding:16px 16px 0 16px}.ne{color:#ff3600!important}.yy{font-weight:0!important}.hiden{display:none}.welcometext{padding:0 20px;line-height:26px}#pagetwo{display:none}.btn-info{background:#00a8ff!important;border:1px solid #0091dc;font-size:13pt;color:#fff!important;height:50px !important}.btn-info:hover{background:#0092dd!important;border:1px solid #0080c3;font-size:13pt;color:#fff}.comit{padding-bottom:20px}li{list-style:none;width:100%}.new_index{width:90%;margin-top:10px;margin-bottom:6px;height:40px;border:1px solid #bcbcbc}.btn-block{margin-top:20px;width:100% !important}.select_mod{width:100%;height:40px;margin-top:20px;font-size:12pt !important;padding-left:1.2em !important;font:normal 100% "微软雅黑";color:#424242;text-align:center}.loader{z-index:9999;height:100%}.username_b{margin-top:20px}.topheader{border-bottom:1px solid #00a8ff;background:#fff;color:#00a8ff;padding:2% 5% 4% 5%;font-weight:700}.topheader ul{padding:0;marginL:0}.topheader li{padding:0;marginL:0;float:left;font-size:20px;line-height:30px;list-style:none}@media print{*{background:none repeat scroll 0 0 rgba(0,0,0,0)!important;box-shadow:none!important;color:#000!important;text-shadow:none!important}a,a:visited{text-decoration:underline}a[href]:after{content:" (" attr(href) ")"}abbr[title]:after{content:" (" attr(title) ")"}a[href^="javascript:"]:after,a[href^="#"]:after{content:""}*,*:before,*:after{box-sizing:border-box}
</style>

</head>

<body>
	&nbsp;
	<div data-role="content" class="login">

		<!--       第一部分的DIV        -->
		<div data-role="page" id="pageone" class="page_one">
			<div class="topheader">第一步：完善个人信息</div>
			<form method="post" action="" style="width:92%;margin-top:10px;">


				<input type="text" id="Name" name="FULL_NAME"
					class="index_input username readyOnly new_index"
					placeholder="请填写真实姓名"> <input type="text" id="Email"
					name="EMAIL" class="index_input email readyOnly new_index"
					placeholder="请填写邮箱">
				<div class="page_er" style="left:-30px !important">网络数据异常</div>
				<button type="button" id="nextButton" class=" btn-info btn-block "
					style="margin-top:20px;">下一步</button>
				<div style="padding-top:30px;display:none;line-height:30px;" class="code_end">
					考前关注 <span style="font-weight:700;font-size:14pt">百一应聘 </span>  公众号并绑定，比别人早知道考试分数，一般人我可不告诉他。
				</div>
			</form>
		</div>
		<!--        第二部分的DIV      -->
		<div data-role="page" id="pagetwo" class="page_two">
			<div class="topheader" style="padding-left:55px;">
				<div class="back">
					<img
						src="<%=request.getContextPath()%>/core/images/weixin/back.png"
						id='passButton'>
				</div>
				第二步：继续完善个人信息
			</div>

			<!-- 网络异常提示语  -->
			<div class="page_er" id="error">网络数据异常</div>

			<form method="post" action="" style="width:92%;padding-bottom:20px;" >

				<ul class="exam_type"
					style="border:1px dashed #bcbcbc;padding:0.8em 1.4em;background:#fff;">
					<li>试卷有<span id="total-part"></span>部分，分别计时。</li>
					<li class="skillCountInfos"></li>
					<li>合计<span
						id="questionLength"></span>道题，共<span id="suggestTime"></span>分钟</li>
					<li style="font-size:10pt">答题过程中，如果遇到页面长时间没反应。请重新进入，继续答题。</li>
				</ul>
				<div id="secondPart"></div>
                <div id="thirdPart"></div>
			</form>
		</div>
	</div>

	<a id="button_a"></a>
	<a id="button_b"></a>
</body>
</html>
<script src="<%=request.getContextPath()%>/page/appframework.min.js"></script>
<script src="<%=request.getContextPath()%>/ch/js/improveInfo.min.js"></script>

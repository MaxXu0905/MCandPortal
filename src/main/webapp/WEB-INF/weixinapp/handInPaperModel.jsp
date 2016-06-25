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

<title></title>
<meta name="viewport"
	content="width=device-width,target-densitydpi=medium-dpi,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

<script src="<%=request.getContextPath()%>/page/appframework.js"></script>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/page/ch/chstyle.css" />
<style type="text/css">
#headr {
	text-align: center;
	padding: 0.8em;
	border-bottom: 1px solid #d2d2d2;
	margin: 0px 1.3em;
}

#content {
	font-size: 13pt;
	padding: 0.8em 1.2em 2.0em;
	line-height: 30px;
}

h1 {
	display: none
}

.score {
	color: #00a8ff;
	padding-left: 15px
}

a {
	text-decoration: none
}

#content {
	text-align: center
}

.score-content {
	display: none
}

.content {
	font-size: 15pt;
	height: 80px;
	line-height: 80px;
	border-bottom: 1px solid rgb(190, 190, 190)
}

.message {
	border-bottom: 1px solid rgb(190, 190, 190);
	padding: 8px 20px;
	font-size: 11pt;
	text-align: left !important;
	height: 50px;
	line-height: 50px
}

.message font {
	float: right;
	color: #00a8ff;
	font-size: 13pt;
}

.message span {
	float: right;
	color: #00a8ff;
	font-size: 13pt;
}

.bs-callout-danger {
	line-height: 22px;
}

.bs-callout {
	border: 1px solid #eee;
	border-radius: 3px;
	margin-top: 15px;
	padding: 5px 0px;
	text-align: left !important;
}

.bs-callout-success {
	line-height: 22px;
}

.answer_wrong {
	background: url('../../core/images/rtwg.png') no-repeat left bottom;
	padding-left: 30px;
	margin-left: 20px
}

.answer_right {
	background: url('../../core/images/rtwg.png') no-repeat left top;
	padding-left: 30px;
	margin-left: 20px
}
</style>
</head>

<body>
	<div class="topheader" style="margin-top:2px;">练习完成</div>
	<div id="topic">
		<!-- Title -->

		<!-- 内容 -->
		<div id="content">
			<span id="score-titile">练习完成，正在出成绩，请稍候。。。</span> <br>
			<div class="score-content"></div>
			<div id="paperContent" style="font-size:14px"></div>
		</div>

	</div>
</body>
</html>

<script type="text/javascript">
	var root = "<%=basePath%>";
	$.ajax({
		url : root + "wx/schoolExam/gradeReport",
		type : "post",
		contentType : "application/json",
		dataType : "json",
		success : function(result) {
			for ( var i = 0; i < result.data.items.length; i++) {
				if (result.data.items[i].score) {
					$('.score-content').append(
							'<div class="message">' + result.data.items[i].name
									+ ' :<span>' + result.data.items[i].score
									+ '分</span></div>');
				}
			}
			var datas = result.data.parts;
			paper(datas);
		},
		complete : function() {
			$('#score-titile').hide();
			$('.score-content').show();
			$.ajax({
				url : root + "wx/clearSession",
				type : "post"
			});
		}
	});
	function paper(datas) {
		var $paperContent = $('#paperContent');
		for ( var t = 0; t < datas[0].partItems.length; t++) {
			var content = [];
			var paperReport = datas[0].partItems[t];

			if (paperReport.optAnswer == paperReport.optRefAnswer) {
				var rightAnswer = paperReport.optRefAnswer.split("");
				var answer = "";
				var rel_answer = [];
				content.push('<div class="bs-callout bs-callout-success">');
				content.push('<div style="padding:0 20px">');
				content.push(t + 1 + '、');
				content.push(paperReport.title);
				content.push('</div>');
				content.push('<div>');
				content.push('<p><span class="answer_right">我的答案：</span>');
				for ( var a = 0; a < rightAnswer.length; a++) {
					switch (rightAnswer[a]) {
					case 'A':
						answer = 0;
						break;
					case 'B':
						answer = 1;
						break;
					case 'C':
						answer = 2;
						break;
					case 'D':
						answer = 3;
						break;
					case 'E':
						answer = 4;
						break;
					case 'F':
						answer = 5;
						break;
					}
					for ( var p = 0; p < paperReport.options.length; p++) {
						if (answer == p) {
							rel_answer.push(paperReport.options[p]);
						}
					}
				}
				for ( var q = 0; q < rel_answer.length; q++) {
					content.push(rel_answer[q] + '<br>');
				}
				content.push('</div>');
				$paperContent.append(content.join(""));
			} else {
				var rightAnswer = paperReport.optRefAnswer.split("");
				var studentAnswer = paperReport.optAnswer.split("");
				var answer = "";
				var rel_answer = [];
				var stu_answer = [];
				content.push('<div class="bs-callout bs-callout-danger">');
				content.push('<div style="padding:0 20px">');
				content.push(t + 1 + '、');
				content.push(paperReport.title);
				content.push('</div>');
				content.push('<div>');
				content.push('<p><span class="answer_wrong">我的答案：</span>');
				for ( var a = 0; a < studentAnswer.length; a++) {
					switch (studentAnswer[a]) {
					case 'A':
						answer = 0;
						break;
					case 'B':
						answer = 1;
						break;
					case 'C':
						answer = 2;
						break;
					case 'D':
						answer = 3;
						break;
					case 'E':
						answer = 4;
						break;
					case 'F':
						answer = 5;
						break;
					}
					for ( var p = 0; p < paperReport.options.length; p++) {
						if (answer == p) {
							stu_answer.push(paperReport.options[p]);
						}
					}
				}
				for ( var q = 0; q < stu_answer.length; q++) {
					content.push(stu_answer[q] + '<br>');
				}
				content.push('</p>');
				content.push('<p style="padding-left:30px;margin-left:20px;border-top:1px dashed #c9c9c9;padding-top:13px">正确答案：')
				for ( var b = 0; b < rightAnswer.length; b++) {
					switch (rightAnswer[b]) {
					case 'A':
						answer = 0;
						break;
					case 'B':
						answer = 1;
						break;
					case 'C':
						answer = 2;
						break;
					case 'D':
						answer = 3;
						break;
					case 'E':
						answer = 4;
						break;
					case 'F':
						answer = 5;
						break;
					}
					for ( var l = 0; l < paperReport.options.length; l++) {
						if (answer == l) {
							rel_answer.push(paperReport.options[l]);
						}
					}
					for ( var o = 0; o < rel_answer.length; o++) {
						content.push(rel_answer[o] + '<br>');
					}
					content.push('</div>');
					$paperContent.append(content.join(""));
				}

			}

		}
	}
</script>
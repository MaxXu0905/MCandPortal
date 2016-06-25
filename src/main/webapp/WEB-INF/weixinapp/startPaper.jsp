<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML>
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
<script src="<%=request.getContextPath()%>/page/appframework.min.js"></script>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/page/ch/chstyle.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/page/ch/startpaper.css" />
<style type="text/css">
body,div,button,ul,li,a,header,h4,input,button {
	font: normal 100% "微软雅黑";
	color: #424242
}

body {
	background: #f8f8f8;
	padding: 0;
	margin: 0
}

.loader {
	height: 100%;
	position: fixed;
	top: 0;
	z-index: 99999;
	width: 100%;
	background-color: rgba(0, 0, 0, 0.4);
	display: none
}

.topheader {
	font-weight: 0 !important;
	margin-top: 0 !important
}

.model-examPaper {
	width: 100%;
}

#model-btn {
	width: 80%;
	height: 50px;
	margin-top: 20px
}

#model-btn-area {
	text-align: center;
}

#model-title-body>ul {
	padding: 0;
	margin: 0;
	border-top: 1px solid #d5d5d5
}

#model-topic {
	font-size: 13pt;
	padding-bottom: 20px;
	padding: 1.8em 1.4em;
	border-bottom: 1px solid #d5d5d5
}

.gone {
	display: none
}

#model-title-body>li {
	border-bottom: 1px solid #d5d5d5;
	border-top: 1px solid #fff;
	font-family: normal 100% "微软雅黑";
	padding: 16px 12px 16px 16px;
	margin: 0;
	font-size: 13pt;
	color: #7b7b7b;
	position: relative;
	list-style: none;
	word-break:break-all !important
}

.type {
	color: #00a8ff;
	font-size: 13pt;
}

pre {
	display: inline;
	white-space: pre-wrap;
	word-break:break-all
}
</style>
</head>

<body>
	<!-- 加载模态层  -->
	<div class="loader">
		<div style="height:190px;text-align: center;margin-top: 200px">
			<div style="width:">
				<canvas id="canvas" width="100" height="40"
					style="border-radius:50%"></canvas>
				<br> <span style="font-weight: 700;color:#fff">加载中.....</span>
			</div>
		</div>
	</div>
	<!--题目部分  -->
	<div class="topheader">
		<ul>
			<li class="toptitle">[<font class="total">1</font><span>/<font
					class="tol_s"></font> </span>]<span class="qbname"></span></li>
		</ul>
		<span class="time" style="float:right;"></span>
		<div style="clear:both;"></div>
	</div>
	<div class="" id="model-topic"></div>
	<div class="model-examPaper" id="model-title-body">
		<ul></ul>
	</div>
	<!--文本区域  -->
	<div class="model-examPaper gone" id="iq-text"
		style="text-align: center;margin-top: 30px">
		<textarea class="textType" id="intel-text" style="width:80%"
			placeholder="请填写正确解释"></textarea>
	</div>
	<!--按钮区域  -->
	<div class="model-examPaper" id="model-btn-area">
		<button class="btn-info" id="model-btn">下一题</button>
	</div>
	
</body>
</html>
<script type="text/javascript">
var h,m,s,paperDatas,relAnswerTime,check,checkTime,answerTime,endExam,suggestTime,choice;var paperParts=0;var paperIndex =0;answerTime=0;var en =["A","B","C","D","E","F"]
var modelFlag = "${param.modelFlag}";
var root = "<%=basePath%>";
function showLoader() {
    $(".loader").show();
}

function hideLoader() {
    $(".loader").hide();
}
//时间处理
	var timerManager = {
		init : function(a){
			var that = this;
			this.timeFormat(a);
			this.startTime(that);
		},timeFormat : function(t){
			h = parseInt(t / 3600), 
			s = t - 3600 * h, 
			m = parseInt(s / 60), 
			s -= 60 * m;
			if(h<10){h="0"+h}if(m<10){m="0"+m}if(s<10){s="0"+s}
		},
		timeRender : function(){
			s -= 1, 10 > s && (s = "0" + s), "0-1" == s && (10 >= m ? (m = "0" + (m - 1), s = 59) :(m -= 1, 
    		s = 59)), "00" == m && (m = "00"), "0-1" == m && ("00" != h ? 10 >= h ? (h = "0" + (h - 1), 
    		m = 59) :(h -= 1, m = 59) :(h = "00", m = "00", s = "00")), 0 == m && (m = "00"), this.statistical(h, m, s),
    		$('.time').text(h + ":" + m + ":" + s);
		},
		exchangeTime :function(t){
			var p =Math.round(localStorage.examEndTime*1-new Date().getTime()*1/1000);
			if(p>0){
				if(p<t){
					return p;
				}else{
					return t;
				}
			}else{
				clearInterval(endExam)
				clearInterval(check)
				alert("考试时间到了!");
				paperDeal.handInPart();
			}
		},
		statistical :function(h,m,s){
			localStorage.totalTime = h*1*60*60+m*1*60+s*1;
		},
		startTime : function(that){
			endExam = setInterval(function() {
        		that.timeRender();
    		}, 1e3), that.timeRender();
		},endExam : function(){
			clearInterval(endExam);
		},answerTime :function(){
			relAnswerTime = setInterval(function() {
        		answerTime += 1;
   			}, 1e3);
		},checkTime:function(){
		 check = setInterval(function() {
        		if(m==0&&h==0&&s==0){
        		paperDeal.dealAnswer();
        		clearInterval(endExam)
				clearInterval(check)
				alert("考试时间到了!");
				paperDeal.handInPart();
			}
   			}, 1e3);
			
		} 
};
/*试卷类型模板  */
var modelType = {
//typeIndex 1:单选；2：多选；3：编程；4：文本；5：单选文本；6：多选文本；7：面试
	init:function(){
		bindEvent();
	},
	singleChoice : function(e,total){
		$('#iq-text').hide();
		var b, c, d,total;total = paperDatas.partDatas[paperParts].questionIds.length
    	for (b = e.data.title,  
	    $("#model-topic").append('<div><span><span class="type">[单选题]</span></span>&nbsp;<span class="to_ste">'+b+'</span></div>'), $(".qbname").text(e.data.qbName), 
	    c = e.data.options.length, d = 0; c > d; d++)if(total==paperIndex&&paperParts+1!=paperDatas.partDatas.length){$("#model-title-body").append(' <li class="' + en[d] + '"><font class="sel_answer">' + en[d] + '</font><font class="answer">' + en[d] + "、" + e.data.options[d]+ '</font><span><button class="btn btn-info btn_info1" type="button">提交部分</button></span></li>');}
	    else if(total==paperIndex&&paperParts+1==paperDatas.partDatas.length){$("#model-title-body").append(' <li class="' + en[d] + '"><font class="sel_answer">' + en[d] + '</font><font class="answer">' + en[d] + "、" + e.data.options[d]+ '</font><span><button class="btn btn-info btn_info1" type="button">提交试卷</button></span></li>');}else{$("#model-title-body").append(' <li class="' + en[d] + '"><font class="sel_answer">' + en[d] + '</font><font class="answer">' + en[d] + "、" + e.data.options[d]+ '</font><span><button class="btn btn-info btn_info1" type="button">下一题</button></span></li>');}
	    hideLoader(), $(".btn-info").hide(), $("#model-title-body").find("li").click(function() {
        var a, b;
        $("#model-title-body").find("li").removeClass("answer2"), a = $(this), a.addClass("answer2"), 
        $(".btn_info1").hide(), a.find(".btn_info1").css({
            height:"auto",
            width:"0px"
        }, function() {}), b = a.height() + 32, a.find(".btn_info1").show(), a.find(".btn_info1").css({
            height:b
        }), a.find(".btn_info1").css({
            right:"0px",
            width:"80px"
        }, function() {}), choice = a.find(".sel_answer").text();
    });
	},
	multipleChoice : function(e,total){
	$('.textType').val("");$('#iq-text').hide();$('.btn-info').attr("disabled","disabled").css("opacity","0.5");
		$("#model-topic").append('<div><span><span class="type">[多选题]</span></span>&nbsp;<span class="to_ste">'+e.data.title+'</span></div>');
    var c, d;
    for (
    b = e.data.options.length, d = 0; b > d; d++) $("#model-title-body").append(' <li class="' + en[d] + ' choice"><font class="sel_answer">' + en[d] + '</font><font class="answer">' + en[d] + "、" + e.data.options[d]+ "</font></li>");
    hideLoader(), $("#model-btn").show(), $("#model-title-body").find("li").click(function() {
        $("#model-title-body").find("li"), $(this).toggleClass("answer2");if( $("#model-title-body").find(".answer2").length>0){$(".btn-info").removeAttr("disabled").css("opacity","1")}else{$(".btn-info").attr("disabled", "disabled").css("opacity","0.5")}
    })
	},
	intelModel : function(e,total){
		$('.btn-info').show();$('#iq-text').show();$('#intel-text').val("");
		$("#model-topic").append('<div><span><span class="type"></span></span>&nbsp;<span class="to_ste">'+e.data.title+'</span></div>');
		for (b = e.data.options.length, d = 0; b > d; d++) $("#model-title-body").append(' <li class="' + en[d] + ' choice"><font class="sel_answer">' + en[d] + '</font><font class="answer">' + en[d] + "、" + e.data.options[d]+ "</font></li>");
		$("#model-title-body").find("li").click(function() {$("#model-title-body").find("li").removeClass("answer2"), $(this).addClass("answer2")
        if( $("#model-title-body").find(".answer2").length>0){$(".btn-info").removeAttr("disabled").css("opacity","1")}else{$(".btn-info").attr("disabled", "disabled").css("opacity","0.5")}
        });
        if(localStorage.textType!=""){
			$('#intel-text').val(localStorage.textType);
		}
		hideLoader()
	},
	qaModel : function(e,n){
		$('#iq-text').hide();
		$('.btn-info').show();
		$('.tol_s').text(n);
		$('#model-topic').html(e.data.title);
		$('#model-title-body').append('<div style="text-align:center;margin-top:30px"><textarea class="textType" placeholder="请在此作答" style="width:80%"></textarea></div>');
		if(localStorage.textType!=""){
			$('.textType').val(localStorage.textType);
		}
		hideLoader();
	},intelMul:function(e,total){
		$('.btn-info').show();$('#iq-text').show();$('#intel-text').val("");
		$('.btn-info').attr("disabled","disabled").css("opacity","0.5");
		$("#model-topic").append('<div><span><span class="type">[多选题]</span></span>&nbsp;<span class="to_ste">'+e.data.title+'</span></div>');
	    var c, d;
	    for (
	    b = e.data.options.length, d = 0; b > d; d++) $("#model-title-body").append(' <li class="' + en[d] + ' choice"><font class="sel_answer">' + en[d] + '</font><font class="answer">' + en[d] + "、" + e.data.options[d]+ "</font></li>");
	    hideLoader(), $("#model-btn").show(), $("#model-title-body").find("li").click(function() {
        $("#model-title-body").find("li"), $(this).toggleClass("answer2");if( $("#model-title-body").find(".answer2").length>0){$(".btn-info").removeAttr("disabled").css("opacity","1")}else{$(".btn-info").attr("disabled", "disabled").css("opacity","0.5")}
    })
    	if(localStorage.textType!=""){
			$('.textType').val(localStorage.textType);
		}
	}
}
var paperDeal ={
	init : function(){
		var _this = this;
		$.ajax({
			url:root+"wx/schoolExam/startPaper",
		        type:"post",
		        dataType:"json",
		        timeout:"60000",
		        success : function(c){
		        if(c.code==0){
		        	$.ajax({
		        		url:root+"/wx/schoolExam/getPaper",
				        type:"post",
				        dataType:"json",
				        timeout:"60000",
				        success : function(e){
				        	paperDatas = e.data;
				        	if(paperDatas.examInfo && paperDatas.examInfo.questionId){
								//还原试题部分
								_this.examInfoGenerate();
							}else{
								//正常答题部分
								_this.firstGenerate();
							}
				        	},error:function(){
				        		alert("您的网络出现问题了，请检查网络后重试");
				        	},complete : function(){
				        		hideLoader()
				        	}
		      			 })
		      			 }
		        },error:function(){
		        	alert("您的网络出现问题了，请检查网络后重试");
		        },complete:function(){
		        	hideLoader()
		        }
		})
		
	},examInfoGenerate : function(){
		var d = {partSeq:paperDatas.examInfo.partSeq,question_id:paperDatas.examInfo.questionId};
		this.examIndex(paperDatas.examInfo.questionId, paperDatas.examInfo.partSeq)
		suggestTime = localStorage.totalTime;
		suggestTime = timerManager.exchangeTime(suggestTime)
		timerManager.init(suggestTime)
		timerManager.checkTime();
		this.generate(d)
	},firstGenerate : function(){
		localStorage.textType = "";
		paperDeal.startPart();
		paperDatas.partDatas[paperParts].partSeq
		var d = {partSeq:paperDatas.partDatas[paperParts].partSeq,question_id:paperDatas.partDatas[paperParts].questionIds[paperIndex].questionId};
		suggestTime = paperDatas.partDatas[paperParts].suggestTime;
		localStorage.examEndTime = new Date().getTime()/1000*1+suggestTime*1+1200; 
		localStorage.totalTime = suggestTime;
		timerManager.init(suggestTime)
		timerManager.checkTime();
		this.generate(d)
	},generate : function(e){
		var total = paperDatas.partDatas[paperParts].questionIds.length;
		$.ajax({
	        url:root+"wx/schoolExam/commitAnswerOrGetNext",
	        type:"post",
	        contentType:"application/json",
	        beforeSend : function(){
	        	showLoader();
	        	timerManager.endExam();
	        	clearInterval(relAnswerTime)
	        	answerTime = 0;
	        },
	        dataType:"json",
	        timeout:"60000",
	        data:JSON.stringify(e),
	        success:function(a) {
	        	if(a.code==0){
	        	$('.textType').val("");
	        		if(a.message!="commit part"){
	        			$('.qbname').text(paperDatas.partDatas[paperParts].partDesc);	
				        $('.total').text(paperIndex+1);
				        paperIndex++;
				        $('#model-title-body').empty();
				        $('#model-topic').empty();
				        timerManager.init(localStorage.totalTime);
				        timerManager.answerTime();
				        $('.tol_s').text(total);
				        if(total==paperIndex&&paperParts+1!=paperDatas.partDatas.length){
				        	$('.btn-info').text("提交部分");$("#model-title-body").find('.btn_info1').text("提交部分");
				        }else if(total==paperIndex&&paperParts+1==paperDatas.partDatas.length){
				        	$('.btn-info').text("提交试卷");$("#model-title-body").find('.btn_info1').text("提交试卷");
				        }else{
				        	$('.btn-info').text("下一题");
				        }
				        switch(a.data.type){
				        	case 1 :
				        	modelType.singleChoice(a, total);
				        	break;
				        	case 2 :
				        	modelType.multipleChoice(a,total);
				        	break;
				        	case 5 :
				        	modelType.qaModel(a, total);
				        	paperDeal.saveAnswer();
				        	break;
				        	case 7 :
				        	modelType.intelModel(a, total);
				        	paperDeal.saveAnswer();
				        	break;
				        	case 8 :
				        	modelType.intelMul(a, total)
				        	paperDeal.saveAnswer();
							break;
				        }
				        }
	        	}else{alert("您的网络出现问题了，请检查网络后重试");}
	        },
	        error:function() {
	        alert("您的网络出现问题了，请检查网络后重试");
	        $(".btn-info").removeAttr("disabled");
	        	hideLoader()
	        },
	        complete:function() {
	        	hideLoader()
	        }
    });
	},examIndex : function(id,seq){
			for(var i=0;i<paperDatas.partDatas.length;i++){
					if(paperDatas.partDatas[i].partSeq==seq){
						paperParts =i;
						for(var q=0;q<paperDatas.partDatas[i].questionIds.length;q++){
							if(paperDatas.partDatas[i].questionIds[q].questionId==id){
									paperIndex = q;
							}
						}
					}
			}
	},endExamIndex : function(){
			if(paperIndex!=$('.tol_s').text()*1){
			if($('.answer2').length>0&&$('.textType').length<1){
				var d = {partSeq:paperDatas.partDatas[paperParts].partSeq,
       				 question_id:paperDatas.partDatas[paperParts].questionIds[paperIndex].questionId,
        			 answer:{
				            id:paperDatas.partDatas[paperParts].questionIds[paperIndex-1].questionId,
				            answerTime:answerTime,
				            choice:choice
        					}
        			 };
        		}else if($('.textType').length>0&&$('.answer2').length<1){
        			var d = {partSeq:paperDatas.partDatas[paperParts].partSeq,
       				 question_id:paperDatas.partDatas[paperParts].questionIds[paperIndex].questionId,
        			 answer:{
				            id:paperDatas.partDatas[paperParts].questionIds[paperIndex-1].questionId,
				            answerTime:answerTime,
				            choiceDesc:$('.textType').val()
        					}
        			 };
        		}else{
        			var d = {partSeq:paperDatas.partDatas[paperParts].partSeq,
       				 question_id:paperDatas.partDatas[paperParts].questionIds[paperIndex].questionId,
        			 answer:{
				            id:paperDatas.partDatas[paperParts].questionIds[paperIndex-1].questionId,
				            answerTime:answerTime,
				            choice:choice,
				            choiceDesc:$('.textType').val()
        					}
        			 };
        		}
        		}
        		else{
        			if($('.answer2').length>0&&$('.textType').length<1){
				var d = {partSeq:paperDatas.partDatas[paperParts].partSeq,
        			 answer:{
				            id:paperDatas.partDatas[paperParts].questionIds[paperIndex-1].questionId,
				            answerTime:answerTime,
				            choice:choice
        					}
        			 };
        		}else if($('.textType').length>0&&$('.answer2').length<1){
        			var d = {partSeq:paperDatas.partDatas[paperParts].partSeq,
        			 answer:{
				            id:paperDatas.partDatas[paperParts].questionIds[paperIndex-1].questionId,
				            answerTime:answerTime,
				            choiceDesc:$('.textType').val()
        					}
        			 };
        		}else{
        			var d = {partSeq:paperDatas.partDatas[paperParts].partSeq,
        			 answer:{
				            id:paperDatas.partDatas[paperParts].questionIds[paperIndex-1].questionId,
				            answerTime:answerTime,
				            choice : choice,
				            choiceDesc:$('.textType').val()
        					}
        			 };
        		}
        		}
        	return d;
	},handInPart : function(){
		$.ajax({
			url:root+"wx/schoolExam/handInPaperPart/"+paperDatas.partDatas[paperParts].partSeq,
			type:"post",
			timeout:"60000",
			contentType:"application/json",
			success : function(a){
				clearInterval(check)
				localStorage.textType = "";
				if(paperParts+1!=paperDatas.partDatas.length){
					paperParts = paperParts+1;
					$('.qbname').text(paperDatas.partDatas[paperParts].partDesc);
					paperIndex = 0;
					$('#model-btn').text("下一题");
					timerManager.endExam();
					paperDeal.firstGenerate();
				}else{
					timerManager.endExam();
					paperDeal.handInPaper();
				}
			},error:function(){
				alert("您的网络出现问题了，请检查网络后重试");
				$(".btn-info").removeAttr("disabled");
			},
			complete:function(){
				hideLoader()
			}
			
		})
	},startPart : function(){
		$.ajax({
			url:root+"wx/schoolExam/startPaperPart/"+paperDatas.partDatas[paperParts].partSeq,
			type:"post",
			timeout:"60000",
			contentType:"application/json",
			success : function(a){
			},error:function(){
				alert("您的网络出现问题了，请检查网络后重试");
			},complete:function(){
				hideLoader()
			}
			
		})
		
	},handInPaper : function(){
		$.ajax({
        url:root+"wx/schoolExam/handInPaper",
        type:"post",
        timeout:"60000",
        contentType:"application/json",
        dataType:"json",
        success : function(a){
        	clearInterval(check)
        	if(a.code==0){
        	if(modelFlag){
			            location.replace(root + "wx/weixinapp/handInPaperModel?modelFlag=1")
                	}else{
		        		location.replace(root + "wx/weixinapp/handInPaper");
                	}
        	}
        },error:function(){
        	alert("您的网络出现问题了，请检查网络后重试");
        },complete:function(){
        	hideLoader()
        }
        })
	},saveAnswer : function(){
		setInterval(function(){
			localStorage.textType =$('.textType').val();
		}, 5000)
	},dealAnswer : function(){
		d= paperDeal.endExamIndex();
		paperDeal.generate(d);
	}
}
function bindEvent(){
	$('#model-btn').click(function(){
		showLoader();
	});
	$('#model-title-body').on('click','.btn-info',function(){
		var btn = $('.btn-info').text();
			d= paperDeal.endExamIndex();
			if(d.question_id){
				paperDeal.generate(d);
			}else{
				paperDeal.generate(d);
				paperDeal.handInPart();
			}
			localStorage.textType = "";
	});
	$("#model-btn").click(function() {
        var a = [];
        if($(".answer2").length>0){
        $(".answer2").find(".sel_answer").each(function() {
            a.push($(this).text());
        }), choice = a.join("")
			d= paperDeal.endExamIndex();
			if(choice!=""){
				if(d.question_id){
					paperDeal.generate(d);
				}else{
					paperDeal.generate(d);
					paperDeal.handInPart();
				}
			}
			localStorage.textType = "";
        }else{
        	d= paperDeal.endExamIndex();
        	if($('.textType').val()!=""){
			if(d.question_id){
				paperDeal.generate(d);
			}else{
				paperDeal.generate(d);
				paperDeal.handInPart();
			}
        	}else{
        		alert("请填写合理解释");
        		hideLoader()
        	}
        }
        localStorage.textType = "";
    });
};
$(document).ready(function(){
	modelType.init();
	paperDeal.init();
});
</script>
<script>  
function loading(a,b){this.canvas=a,b?(this.radius=b.radius||12,this.circleLineWidth=b.circleLineWidth||4,this.circleColor=b.circleColor||"lightgray",this.dotColor=b.dotColor||"black"):(this.radius=12,this.circelLineWidth=4,this.circleColor="lightgray",this.dotColor="black")}loading.prototype={show:function(){var b,c,d,e,a=this.canvas;a.getContext&&(a.__loading||(a.__loading=this,b=a.getContext("2d"),c=this.radius,d=[{angle:0,radius:1.5},{angle:3/c,radius:2},{angle:7/c,radius:2.5},{angle:12/c,radius:3}],e=this,a.loadingInterval=setInterval(function(){var f,g,h,i,j,k;for(b.clearRect(0,0,a.width,a.height),f=e.circleLineWidth,g={x:a.width/2-c,y:a.height/2-c},b.beginPath(),b.lineWidth=f,b.strokeStyle=e.circleColor,b.arc(g.x,g.y,c,0,2*Math.PI),b.closePath(),b.stroke(),h=0;h<d.length;h++)i=d[h].currentAngle||d[h].angle,j={x:g.x-c*Math.cos(i),y:g.y-c*Math.sin(i)},k=d[h].radius,b.beginPath(),b.fillStyle=e.dotColor,b.arc(j.x,j.y,k,0,2*Math.PI),b.closePath(),b.fill(),d[h].currentAngle=i+4/c},50)))},hide:function(){var b,a=this.canvas;a.__loading=!1,a.loadingInterval&&window.clearInterval(a.loadingInterval),b=a.getContext("2d"),b&&b.clearRect(0,0,a.width,a.height)}};
</script>
<script> var loadingObj = new loading(document.getElementById('canvas'),{radius:8,circleLineWidth:3});loadingObj.show();</script>
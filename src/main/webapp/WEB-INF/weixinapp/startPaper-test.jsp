<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>

<!DOCTYPE>
<html>
<head>
<base href="<%=basePath%>">

<title>百一测评系统</title>
<meta name="viewport"
    content="width=device-width,target-densitydpi=medium-dpi,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

<style type="text/css">
.page_er {
    margin-left: -15px
}

.topheader {
    font-weight: 0 !important;
    margin-top: 0 !important
}
pre{
    display: inline;
    white-space: pre-wrap
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
</style>
</head>
<body>

    <div class="loader">
        <div style="height:190px;text-align: center;margin-top: 200px">
            <div style="width:">
                <canvas id="canvas" width="100" height="40"
                    style="border-radius:50%"></canvas>
                <br> <span style="font-weight: 700;color:#fff">加载中.....</span>
            </div>
        </div>
    </div>

    <div data-role="page" id="topic" class="topic">
        <div data-role="content" data-theme="b" id="right_sc" class="right_sc">
            <form action="" method="post">
                <div class="topheader">
                    <ul>
                        <li class="toptitle">[<font class="total">1</font><span>/<font
                                class="tol_s"></font> </span>]<span class="qbname"></span>
                        </li>
                    </ul>
                    <span class="time" style="float:right;"></span>
                    <div style="clear:both;"></div>
                </div>
                <header class="header">
                    <!-- 
    <font class="set_font">[<font id="total">1</font>/4]</font>&nbsp;&nbsp;&nbsp;
    -->
                    <font class="stem"><span>[<font class="type"></font>]&nbsp;</span><font
                        class="to_ste"></font> </font>
                </header>
                <ul class="answer_are"></ul>

                <div class="btn_area">
                    <button class="btn btn-info btn-hover" id="the_next" type="button">下一题</button>
                    <button class="btn btn-info btn-hover" style="display:none"
                        type="button" id="first"></button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>


<script src="<%=request.getContextPath()%>/page/appframework.min.js"></script>
<link rel="stylesheet"
    href="<%=request.getContextPath()%>/page/ch/chstyle.css" />
<link rel="stylesheet"
    href="<%=request.getContextPath()%>/page/ch/startpaper.css" />

<script type="text/javascript">
var modelFlag = "${param.modelFlag}";
function showLoader() {
    $(".loader").show();
}

function hideLoader() {
    $(".loader").hide();
}

function Monitoring(){
    $(window).blur(function(){
        $.ajax({
            url:"<%=request.getContextPath()%>/exam/getSwitchTimesConfig",
            dataType:"json",
            contentType : "application/json",
            success : function(result){
                var left_times =result.data.switchTimes; 
                if(left_times<10){
                    var qbId = $('.qbname').data("qbId");
                    var datas = {"partSeq":"1","questionId":qbId};
                    $.ajax({
                        url:"<%=request.getContextPath()%>/exam/updateSwitchTimes",
                        type : "post",
                        contentType : "application/json",
                        data:JSON.stringify(datas),
                        success : function(result){
                        }
                          });
                }else{
                    $.ajax({
                        url:"<%=request.getContextPath()%>/wx/schoolExam/handInPaper",
                        type:"post",
                        dataType  : "json",
                        success : function(result){
                            if(result.data.code=="SUCCESS"){
                                $.ajax({
                                url:root+"/wx/clearSession",
                                type:"post",
                                complete : function(){
                                    alert("离开页面10次，系统将自动交卷");
                                        location.replace(root + "wx/weixinapp/handInPaper");
                                }
                            })
                            }
                        }
                    })
                }
            }
        })
})
}
function startPaper() {
    $.ajax({
        url:"<%=request.getContextPath()%>/wx/schoolExam/startPaper",
        contentType:"application/json",
        success:function(a) {
            console.log(a), 0 != a.code && setTimeout(function() {
                $(".page_er").show(), setTimeout(function() {
                    $(".page_er").hide();
                }, 5e3);
            }, 0);
        }
    });
}
function handle(img){
    if(img.indexOf("img") > 0){
    var rel_image="";
    var editing = "";
    var pic = "";
    var content = [];
    rel_image = img.split("@");
    content.push(rel_image[0]+"@");
    editing = rel_image[1].split("|");
    pic = editing[0].split("_");
    content.push("100w_");
    content.push("100h_");
    content.push(pic[2]+"|");
    content.push(editing[1]);
    img = content.join("");
    return img;
    }else{
        return img;
    }
}
function type1(a,qd) {
    var b, c, d;
    for ($(".type").text("单选题"), b = a.data.title, b =handle(b), 
    $(".to_ste").html(b), $(".qbname").text(a.data.qbName), $(".qbname").data("qbId",qd),
    c = a.data.options.length, d = 0; c > d; d++) $(".topic").find(".answer_are").append(' <li class="' + en[d] + '"><font class="sel_answer">' + en[d] + '</font><font class="answer">' + en[d] + "、" + handle(a.data.options[d])+ '</font><span><button class="btn btn-info btn_info1" type="button">下一题</button></span></li>');
    hideLoader(), $(".btn-info").hide(), $(".answer_are").find("li").click(function() {
        var a, b;
        $(".answer_are").find("li").removeClass("answer2"), a = $(this), a.addClass("answer2"), 
        $(".btn_info1").hide(), a.find(".btn_info1").css({
            height:"auto",
            width:"0px"
        }, function() {}), b = a.height() + 32, a.find(".btn_info1").show(), a.find(".btn_info1").css({
            height:b
        }), a.find(".btn_info1").css({
            right:"0px",
            width:"80px"
        }, function() {}), answer = a.find(".sel_answer").text();
    });
}

function type2(a,qd) {
    var c, d;
    for ($(".type").text("多选题"), c = a.data.title, c=handle(c),
    $(".to_ste").html(c), $(".qbname").text(a.data.qbName), 
    b = a.data.options.length, d = 0; b > d; d++) $(".topic").find(".answer_are").append(' <li class="' + en[d] + '"><font class="sel_answer">' + en[d] + '</font><font class="answer">' + en[d] + "、" + a.data.options[d]+ "</font></li>");
    hideLoader(), $("#the_next").show(), $("#the_next2").show(), $(".answer_are").find("li").click(function() {
        $(".topic").find("li"), $(this).toggleClass("answer2"), $(this).hasClass("answer2") ? $(".btn-info").removeAttr("disabled") :$(".btn-info").attr("disabled", "disabled");
    }), $("#the_next").click(function() {
        var a = [];
        $(".answer2").find(".sel_answer").each(function() {
            a.push($(this).text());
        }), answer = a.join(""), 1 != answer && $("#first").click();
    });
}

function initTime(a) {
    h = parseInt(a / 3600), s = a - 3600 * h, m = parseInt(s / 60), s -= 60 * m, startTime();
}

function timeRender() {
    s -= 1, 10 > s && (s = "0" + s), "0-1" == s && (10 >= m ? (m = "0" + (m - 1), s = 59) :(m -= 1, 
    s = 59)), "00" == m && (m = "00"), "0-1" == m && ("00" != h ? 10 >= h ? (h = "0" + (h - 1), 
    m = 59) :(h -= 1, m = 59) :(h = "00", m = "00", s = "00")), 0 == m && (m = "00"), 
    tt.text(h + ":" + m + ":" + s);
}

function startTime() {
    setInterval(function() {
        timeRender();
    }, 1e3), timeRender();
}

function useTime(a) {
    a += 1;
}

function staTime() {
    setInterval(function() {
        useTime(init_s);
    }, 1e3);
}

function checkTime() {
    0 == h && 0 == m && 0 == s && (clearInterval(endTime), $.ajax({
        url:"<%=request.getContextPath()%>/wx/schoolExam/handInPaper",
        type:"post",
        contentType:"application/json",
        dataType:"json",
        success:function(a) {
            if(0==a.code){
            if(modelFlag){
                        location.replace(root + "wx/weixinapp/handInPaperModel?modelFlag=1");
                        }else{
                            $.ajax({
                                url:root+"/wx/clearSession",
                                type:"post",
                                complete : function(){
                                    alert("考试时间结束,试卷将自动提交");
                                        location.replace(root + "wx/weixinapp/handInPaper");
                                }
                            })
                        }
            }
        }
    }));
}

function firstGenerate(a) {
    var b = a.data.partDatas[0], c = oldPaper, d = {
        partSeq:b.partSeq,
        question_id:c
    };
    $(".tol_s").text(a.data.partDatas[0].questionLength), $(".total").text("" + [ index ]), 
    $.ajax({
        url:"<%=request.getContextPath()%>/wx/schoolExam/commitAnswerOrGetNext",
        type:"post",
        contentType:"application/json",
        dataType:"json",
        data:JSON.stringify(d),
        success:function(a) {
            0 != a.code && location.replace(root + "wx/weixinapp/error"), 0 == a.code && a.data && (1 == a.data.type && type1(a,c), 
            2 == a.data.type && type2(a,c));
        },
        error:function() {
            location.replace(root + "wx/weixinapp/error");
        },
        complete:function() {
            initTime(sug_time);
        }
    });
}

function getPaper() {
    $.ajax({
        url:"<%=request.getContextPath()%>/wx/schoolExam/getPaper",
        type:"post",
        dataType:"json",
        success:function(a) {
            var b, c, d;
            if (partSeq = a.data.partDatas[0].partSeq, 0 != a.code) return location.replace(root + "wx/weixinapp/error"), 
            void 0;
            if (a.data.examInfo.questionId) {
                for (b = a.data.examInfo.questionId, c = a.data.partDatas[0].questionLength, sug_time = a.data.examInfo.timeLeft, 
                d = 0; c > d; d++) if (oldPaper = a.data.partDatas[0].questionIds[0].questionId, 
                b == a.data.partDatas[0].questionIds[d].questionId) return index = d + 1, top_num = d + 1, 
                paperStem = a, oldPaper = a.data.examInfo.questionId, index == c && ($(".answer_are").on("click", "li", function() {
                    $(this).find("button").text("完成试卷");
                }), $(".topic").find(".btn-info").text("完成试卷")), firstGenerate(paperStem), sugTotal = a.data.partDatas[0].questionLength, 
                top_num;
            } else sug_time = a.data.partDatas[0].suggestTime, oldPaper = a.data.partDatas[0].questionIds[0].questionId, 
            firstGenerate(a), paperStem = a, sugTotal = a.data.partDatas[0].questionLength;
        },
        error:function() {
            location.replace(root + "wx/weixinapp/error");
        }
    });
}

function tolTime() {
    answerTime += 1;
}

function relTimer() {
    setInterval(function() {
        tolTime();
    }, 1e3);
}

function generatePaper(a) {
    var b, c, d, e;
    ajaxLocker = !0, b = a.data.partDatas[0], c = b.questionIds[top_num++].questionId, 
    d = b.questionIds[top_num - 2].questionId, e = {
        partSeq:b.partSeq,
        question_id:c,
        answer:{
            id:d,
            answerTime:answerTime,
            choice:answer
        }
    }, $(".tol_s").text(a.data.partDatas[0].questionLength), $.ajax({
        url:"<%=request.getContextPath()%>/wx/schoolExam/commitAnswerOrGetNext",
        type:"post",
        contentType:"application/json",
        dataType:"json",
        data:JSON.stringify(e),
        success:function(a) {
            console.log(a), answerTime = 0, 0 != a.code && setTimeout(function() {
                $(".page_er").show(), setTimeout(function() {
                    $(".page_er").hide();
                }, 5e3);
            }, 0), 0 == a.code && a.data && (1 == a.data.type && type1(a,c), 2 == a.data.type && type2(a,c));
        },
        error:function() {
            setTimeout(function() {
                $(".page_er").show(), setTimeout(function() {
                    $(".page_er").hide();
                }, 5e3);
            }, 0);
        },
        complete:function() {
            ajaxLocker = !1, hideLoader();
        }
    });
}

function lastPaper(a) {
    var b = !1, c = a.data.partDatas[0].questionIds.length - 1, d = a.data.partDatas[0].questionIds[c].questionId, e = {
        partSeq:1,
        answer:{
            id:d,
            answerTime:answerTime,
            choice:answer
        }
    };
    $.ajax({
        url:"<%=request.getContextPath()%>/wx/schoolExam/commitAnswerOrGetNext",
        type:"post",
        contentType:"application/json",
        dataType:"json",
        data:JSON.stringify(e),
        beforeSend:function() {
            $(".btn-info").attr("disabled", "disabled").text("试卷提交中.....");
        },
        success:function(a) {
            0 == a.code && (b = !0);
        },
        complete:function() {
             (b = !0) && $.ajax({
                url:"<%=request.getContextPath()%>/wx/schoolExam/handInPaper",
                type:"post",
                contentType:"application/json",
                dataType:"json",
                success:function(a) {
                if(0 == a.code){
                    if(modelFlag){
                        location.replace(root + "wx/weixinapp/handInPaperModel?modelFlag=1")
                    }else{
                    $.ajax({
                            url:root+"/wx/clearSession",
                            type:"post",
                            complete :function(){
                                location.replace(root + "wx/weixinapp/handInPaper")
                            }
                        })
                    }
                }else{
                      setTimeout(function() {
                        $btn.text("提交失败"), setTimeout(function() {
                            $(".btn-info").removeAttr("disabled").text("完成试卷");
                        }, 2e3);
                    }, 2e3);
                }
                },
                error:function() {
                    setTimeout(function() {
                        $(".page_er").show(), setTimeout(function() {
                            $(".page_er").hide();
                        }, 5e3);
                    }, 0);
                }
            }); 
        }
    });
}

   function firstClick(){
        showLoader();
        for (var a = 0; a < en.length; a++) $("." + en[a]).removeClass("answer2");
        $(".btn_info1").hide(), "完成试卷" == $("#the_next").text() ? "" != answer && ($(".total").text("" + [ index++ ]), 
        lastPaper(paperStem)) :"" != answer && ($(".btn-info").hide(), $(".total").text("" + [ ++index ]), 
        $(".answer_are").empty(), $(".to_ste").text(""), $(".type").text(""), $(".btn-info").attr("disabled", "disabled"), 
        index == sugTotal && ($(".topic").on("click", "li", function() {
            $(this).find(".btn_info1").text("完成试卷");
        }), $(".btn_info1").text("完成试卷"), $(".btn-info").text("完成试卷")), generatePaper(paperStem), 
        answer = 1);
   }

var root, ajaxLocker, h, m, s, tt, init_s, endTime, paperStem, sugTotal, oldPaper, partSeq, sug_time, answerTime, top_num, i, answer, index, opt, t, en;

document.addEventListener("WeixinJSBridgeReady", function() {
    WeixinJSBridge.call("hideOptionMenu");
}), root = "<%=basePath%>", ajaxLocker = !1, $("#pagetwo").hide(), h = 1, m = 0, 
s = 10, tt = $(".time"), 10 > m && (m = "0" + m), 10 > h && (h = "0" + h), init_s = 0, 
endTime = setInterval(checkTime, 1e3), paperStem = "", sugTotal = "", oldPaper = "", 
partSeq = "", sug_time = "", answerTime = 0, top_num = 1, i = -1, answer = 1, index = 1, 
opt = 0, t = 1, en = [ "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K" ], 
$(document).ready(function() {
    $(".btn-info").hide(),Monitoring(), getPaper(), relTimer(), startPaper(), showLoader(), $("#first").click(function() {
        showLoader();
        for (var a = 0; a < en.length; a++) $("." + en[a]).removeClass("answer2");
        $(".btn_info1").hide(), "完成试卷" == $("#the_next").text() ? "" != answer && ($(".total").text("" + [ index++ ]), 
        lastPaper(paperStem)) :"" != answer && ($(".btn-info").hide(), $(".total").text("" + [ ++index ]), 
        $(".answer_are").empty(), $(".to_ste").text(""), $(".type").text(""), $(".btn-info").attr("disabled", "disabled"), 
        index == sugTotal && ($(".topic").on("click", "li", function() {
            $(this).find(".btn_info1").text("完成试卷");
        }), $(".btn_info1").text("完成试卷"), $(".btn-info").text("完成试卷")), generatePaper(paperStem), 
        answer = 1);
    }), $("#second").click(function() {
        showLoader();
        for (var a = 0; a < en.length; a++) $("." + en[a]).removeClass("answer2");
        $(".btn_info1").hide(), "完成试卷" == $("#the_next2").text() ? "" != answer && ($(".total").text("" + [ index++ ]), 
        lastPaper(paperStem)) :"" != answer && ($(".btn-info").hide(), generatePaper(paperStem), 
        $(".total").text("" + [ ++index ]), $(".answer_are").empty(), $(".to_ste").text(""), 
        $(".type").text(""), $(".btn-info").attr("disabled", "disabled"), index == sugTotal && ($(".topic").on("click", "li", function() {
            $(this).find(".btn_info1").text("完成试卷");
        }), $(".btn_info1").text("完成试卷"), $(".btn-info").text("完成试卷")), answer = 1);
    }), $("#topic").on("click", ".btn_info1", function() {
        firstClick()
    });
});
</script>
<script>  
function loading(a,b){this.canvas=a,b?(this.radius=b.radius||12,this.circleLineWidth=b.circleLineWidth||4,this.circleColor=b.circleColor||"lightgray",this.dotColor=b.dotColor||"black"):(this.radius=12,this.circelLineWidth=4,this.circleColor="lightgray",this.dotColor="black")}loading.prototype={show:function(){var b,c,d,e,a=this.canvas;a.getContext&&(a.__loading||(a.__loading=this,b=a.getContext("2d"),c=this.radius,d=[{angle:0,radius:1.5},{angle:3/c,radius:2},{angle:7/c,radius:2.5},{angle:12/c,radius:3}],e=this,a.loadingInterval=setInterval(function(){var f,g,h,i,j,k;for(b.clearRect(0,0,a.width,a.height),f=e.circleLineWidth,g={x:a.width/2-c,y:a.height/2-c},b.beginPath(),b.lineWidth=f,b.strokeStyle=e.circleColor,b.arc(g.x,g.y,c,0,2*Math.PI),b.closePath(),b.stroke(),h=0;h<d.length;h++)i=d[h].currentAngle||d[h].angle,j={x:g.x-c*Math.cos(i),y:g.y-c*Math.sin(i)},k=d[h].radius,b.beginPath(),b.fillStyle=e.dotColor,b.arc(j.x,j.y,k,0,2*Math.PI),b.closePath(),b.fill(),d[h].currentAngle=i+4/c},50)))},hide:function(){var b,a=this.canvas;a.__loading=!1,a.loadingInterval&&window.clearInterval(a.loadingInterval),b=a.getContext("2d"),b&&b.clearRect(0,0,a.width,a.height)}};
</script>
<script> var loadingObj = new loading(document.getElementById('canvas'),{radius:8,circleLineWidth:3});loadingObj.show();</script>

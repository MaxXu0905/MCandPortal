<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<meta name="viewport" content="width=device-width,target-densitydpi=medium-dpi,initial-scale=1.0,user-scalable=no"/>
</head>
<body>
<div style="text-align:center;padding:20% 5%;font-size:13pt;line-height:30px;">运营商网络不太给力，正在努力重新连接，请客官耐心等待（<span id="t"></span>秒）</div>
</body>
</html>
<script type="text/javascript">
var t="${sessionScope.SESSION_WAIT_TIME}";
var e=document.getElementById("t");
e.innerText=t;
var i=setInterval(function(){t--,0>t?(clearInterval(i),location.replace("${sessionScope.SESSION_BASE_URL}")):e.innerText=t;},1e3);
</script>
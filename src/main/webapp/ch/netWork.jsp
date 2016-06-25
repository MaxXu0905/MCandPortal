<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'netWork.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
    <script src="<%= request.getContextPath() %>/lib/jquery-1.9.1.min.js"></script>
    <script src="<%= request.getContextPath() %>/lib/bootstrap/js/bootstrap.min.js"></script>
    <link  rel="stylesheet" href="<%= request.getContextPath() %>/lib/bootstrap/css/bootstrap.min.css">
    <style type="text/css">
        p{padding:5% 5%;text-align: center;border-bottom: 1px solid #0091dc}
        .user{border:1px solid red;margin-top:10px;height:30px;}
        .user >label{width:33.33%}
        .title >li{float:left;list-style: none;border-bottom: 1px dashed #bcbcbc;margin-top:20px;word-wrap:break-word;height:40px}
        .modelview{width:100%;height:100%;z-index: 9999;background-color: rgba(58,45,45,0.8);position: absolute;display:none}
        .set{margin-top:15px;background-color: #fff;width:60%}
        #setOrSel{background-color: #5BC0DE;color:#fff;font-size: 15pt}
        .bak{width:60%}
        #setMaxtime{margin-left:30px}
        #setMaxwait{margin-left:30px}
        #setFlag{margin-left:30px}
        .tl >li{list-style: none;width:33.33%;float:left}
    </style>
  </head>
  
  <body>
      <div class="modelview">
      	<p id="setOrSel">设置&查看</p>
      <center>
        <input type="text" class="set form-control" id="timer"/><button type="button" class="btn btn-default" id="getMaxtime">获取队列最大时间值</button><button type="button" class="btn btn-info" id="setMaxtime">设置队列最大时间值</button><br>
        <input type="text" class="set form-control" id="team"/><button type="button" class="btn btn-default" id="getMaxwait">获取队列最大等待数</button><button type="button" class="btn btn-info" id="setMaxwait">设置队列最大等待数</button><br>
        <input type="text" class="set form-control" id="strOrend"/><button type="button" class="btn btn-default" id="getFlag">获取启动/停止状态</button><button type="button" class="btn btn-info" id="setFlag">设置启动/停止状态</button><br>
        <button id="back" type="button" class="btn btn-success bak">返回</button>
      </center>
      </div>
      <div>
            <p>管理者页面</p>
      </div>
      <div id="content">
          <div>
             <ul class="tl">
               <li><button type="button" class="btn btn-success btn-block" id="setAtt">设置&查看</button></li>
               <li><button type="button" class="btn btn-danger btn-block" id="delAll">删除全部</button></li>
               <li><button type="button" class="btn btn-info btn-block" id= "refesh">刷新</button></li>
             </ul>
          </div>
          <ul class="title" id="cont">
	          <li style="width:25%">ID</li>
	          <li style="width:25%">开始时间/总用时</li>
	          <li style="width:50%">URL</li>
          </ul>
      </div>
  </body>
</html>
<script type="text/javascript">
var root = "<%=basePath%>";
     function getAll(){
       $.ajax({
         url:root+"wx/schoolQueue/getAllReqQueue",
         type:"post",
         dataType:"json",
         contentType:"application/json",
         success:function(result){
         console.dir(result);
         var con = result.data;
         for(var i=0;i<result.data.length;i++)
         {
          $('#content').append('<ul class="title title_2"><li style="width:25%">'+con[i].sessionId+'</li><li style="width:25%">'+con[i].beginTime+'/'+con[i].usedTime+'</li><li style="width:50%"><span>'+con[i].url+'</span><button type="button" class="btn btn-danger del" style="float:right">删除</button></li></ul>')
         }
         }
         
       });
     }
     $(document).ready(function(){
          getAll();
          //刷新
          $('#refesh').click(function(){
              $('.title_2').remove();
              getAll();
          });
          
          $('#getMaxtime').click(function(){
          
              $.ajax({
                 url:root+"wx/schoolQueue/getMaxWaitTime",
                 type:"post",
                 dataType:"json",
                 contentType:"application/json",
                 success:function(result){
                    $('#timer').val(result.data);
                 },
              });
          
          });
          $('#setMaxtime').click(function(){
               var maxWaitTime = $('#timer').val();
               $.ajax({
	                 url:root+"wx/schoolQueue/updateMaxWaitTime/"+maxWaitTime,
	                 type:"post",
	                 dataType:"json",
	                 contentType:"application/json",
	                 success:function(result){
	                      alert("设置成功!")
	                 }
               });
          });
          $('#getMaxwait').click(function(){
               $.ajax({
                 url:root+"wx/schoolQueue/getMaxWaitNumber",
                 type:"post",
                 dataType:"json",
                 contentType:"application/json",
                 success:function(result){
                     $('#team').val(result.data);
                 }
               });
          });
          
          $('#setMaxwait').click(function(){
               var maxWaitNumber = $('#team').val();
               $.ajax({
	                 url:root+"wx/schoolQueue/updateMaxWaitNumber/"+maxWaitNumber,
	                 type:"post",
	                 dataType:"json",
	                 contentType:"application/json",
	                 success:function(result){
	                      alert("设置成功!")
	                 }
               });
          });
          $('#back').click(function(){
             $('.modelview').fadeOut();
          });
          $('#setAtt').click(function(){
              $('.modelview').fadeIn();
          });
          
          $('#delAll').click(function(){
              $.ajax({
                 url:root+"wx/schoolQueue/delAllReqQueue",
                 type:"post",
                 dataType:"json",
                 contentType:"application/json",
                 success:function(result){
                     if(result.data.code=="SUCCESS")
                       {
                         alert("删除成功");
                       }
                 }
              });
          });
          
          $('#content').on('click','.del',function(){
                var url = $(this).prev().text();
                var sesId = $(this).parent().prev().prev().text();
                var datas = {"sessionId":sesId,"url":url}
                $.ajax({
                  url:root+"wx/schoolQueue/delFromReqQueue",
                  type:"post",
                  dataType:"json",
                  contentType:"application/json",
                  data:JSON.stringify(datas),
                  success:function(result){
                       if(result.data.code=="SUCCESS")
                       {
                         alert("删除成功");
                       }
                  }
                  
                });
          });
          
          $('#getFlag').click(function(){
              $.ajax({
                  url:root+"wx/schoolQueue/getFlag",
                  type:"post",
                  dataType:"json",
                  contentType:"application/json",
                  success:function(result){
                     $('#strOrend').val(result.data);
                  }
                  
              });
          });
          $('#setFlag').click(function(){
              var flag = $('#strOrend').val();
              $.ajax({
                  url:root+"wx/schoolQueue/updateFlag/"+flag,
                  type:"post",
                  dataType:"json",
                  contentType:"application/json",
                  success:function(result){
                        console.log(result);
                  }
              })
          });
     
     });
</script>
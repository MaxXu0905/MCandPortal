<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
%>

<!DOCTYPE>
<html>
  <head>
  <base href="<%=basePath%>">
    <title>百一测评系统</title>
    <meta name="viewport" content="width=device-width,target-densitydpi=medium-dpi,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
    
      
  </head> 
  <style type="text/css">
      .wrn{border:1px solid red !important}
      #topic2{display:none}
      .loader{height:100%;position: fixed;top:0;z-index: 99999;width:100%;background-color: rgba(0,0,0,0.4);display:none}
  </style>
  <body>
<div data-role="page" id="topic">
<div class="page_er">网络数据异常</div> 
    <div data-role="content" data-theme="b" id="right_sc">
    <form action="" method="post">
     <div class="topheader">语言选择</div>
   <!--  <header>请选出您最擅长的语言或技能，以便我们更好的了解您的能力： </header> -->
  <div class="Language">
        <div class="title">请选出您最擅长的语言或技能： </div>
		<div class="btn-group btn-group-justified">
		  <a class="btn btn-default btn-lg">Java</a>
		  <a type="button" class="btn btn-default btn-lg">C++</a>
		</div>			

   </div> 
 <div class="btn_area">    
     <button class="btn btn-info btnradius" id="the_next" type="button">提交</button> 
 </div>     
    </form>
  </div>
</div>

   <!-- 显示部分 -->
  <div data-role="page" id="topic2"> 
       <div class="topheader">考前须知</div>
  <div  id="topic">
 <!-- Title -->

  <!-- 内容 --> 
    <div id="content" class="Language">
    <div class="title">您参加的是2014年亚信联创春季校园招聘会。 <br><br>考试说明：</div>

   <ul>   
      <li>考试时长<font id="suggestTime"></font>分钟</li>
      <li>共有<font id="questionLength"></font>道题，题型包括</li>
      <ol class="skillCountInfos"></ol>
      <li>错选、漏选均不得分。</li>
   </ul>    

    </div>          
          
    </div>  
  <!-- 按钮 -->
    <div  data-theme="b" class="btn_area">
      <button class="btn btn-info btn-block btnradius" id="konw">我知道了</button>   
    </div>
</div>

  </body>
</html>

      <script src="<%= request.getContextPath() %>/page/appframework.min.js"></script>
      <link rel="stylesheet" href="<%= request.getContextPath() %>/page/ch/chstyle.css" />
      <link rel="stylesheet" href="<%= request.getContextPath() %>/page/ch/getpaper.css" />

<script type="text/javascript">
        var root = "<%=basePath%>";
        document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
 	     WeixinJSBridge.call('hideOptionMenu');});
        function add(result){
	        var type = result.data.skillCountInfos;
	        var length = result.data.skillCountInfos.length;
	        for(var i=0;i<length;i++)
	        {
	            $('.skillCountInfos').append('<li>'+type[i].skillName+':'+type[i].questionLength+'道</li>');
	        }
        
        };

         $(document).ready(function(){
         $('.page_er').hide();
         var language=1; 
         $('.btn-group').find('a').click(function(){
                $('a').removeClass('btn-info');
                $(this).addClass('btn-info');
                language = $(this).text();
                language = language.toLocaleLowerCase() ;
         });
         $('.btn-lg').click(function(){
             $('.btn-lg').removeClass('wrn');
            
         });
         
	     $('#the_next').click(function(){
	         var $btn = $(this);
	         var defaultText = $btn.text();
	         if(language!=1)
	         {
	         
	         var mes = {"language":language};
	         var success = false;
              $.ajax({
					url: root+"wx/schoolExam/generatePaper",
					type : "post",
					contentType: 'application/json',
					dataType : "json",
					data : JSON.stringify(mes),
					beforeSend: function(){
						 $btn.attr('disabled', 'disabled').text('正在提交...');
			             $('.btn-lg').attr("disabled","disabled");
					},
					success :  function(result){
			          if(result.code==0)
			          {
			          success = true;
			          add(result);	
			          $('#partDesc').text(result.data.partDatas[0].partDesc);
			          $('#suggestTime').text(result.data.partDatas[0].suggestTime/60);
			          $('#questionLength').text(result.data.partDatas[0].questionLength); 
			          }
			          else
			          {
			            <%-- location.href="<%=request.getContextPath()%>/wx/weixinapp/error" --%>
			            	 setTimeout(function(){
								$('.page_er').show();
								 setTimeout(function(){
									$('.page_er').hide();
								 }, 5000);
							}, 0);
			            
			          }
					},
					error:function(){
					
					   setTimeout(function(){
								$('.page_er').show();
								 setTimeout(function(){
									$('.page_er').hide();
								 }, 5000);
							}, 0);
					},
					complete: function(){
						$('#topic').hide();
						$('#topic2').show();
						if(!success){
							setTimeout(function(){
								$btn.text('提交失败');
								setTimeout(function(){
									$btn.removeAttr('disabled').text(defaultText);
								}, 2000);
							}, 2000);
						}
		}
        });
        
         }
         else
         {
             $('.btn-lg').addClass('wrn');
         }
	     });

         $('#konw').click(function (){
         $(this).attr('disabled','disabled').text("试卷生成中......");
         setTimeout(function(){
	       location.replace(root+"wx/weixinapp/startPaper");  
         },1000);
	     
	     
         });
         });

        
</script>

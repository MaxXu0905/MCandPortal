<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE>
<html>
  <head>
    <title>百一测评系统</title>
    <meta name="viewport" content="width=device-width,target-densitydpi=medium-dpi,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/lib/bootstrap/css/bootstrap.min.css" />
  
	<link rel="stylesheet" href="<%= request.getContextPath() %>/lib/jquery-mobile/css/jquery.mobile-1.3.2.min.css" />
	<link rel="stylesheet" href="<%= request.getContextPath() %>/lib/jquery-mobile/css/jquery.mobile.theme-1.4.2.css" />
	
	<script type="text/javascript" src="<%= request.getContextPath() %>/plugin/json2.js"></script>
	<script type="text/javascript" src="<%= request.getContextPath() %>/lib/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="<%= request.getContextPath() %>/lib/bootstrap/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="<%= request.getContextPath() %>/lib/jquery-mobile/js/jquery.mobile-1.4.2.min.js"></script>	
    <link rel="stylesheet" href="<%= request.getContextPath() %>/page/ch/chstyle.css" />
     <link rel="stylesheet" href="<%= request.getContextPath() %>/page/ch/getpaper.css" />
  </head> 
  <body>
<div data-role="page" id="topic">
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
<!-- 	  <div class="title">2、请在下面一组中选出最擅长的一项：</div>	
		<div class="btn-group btn-group-justified">
		  <a class="btn btn-default btn-lg">Java</a>
		  <a type="button" class="btn btn-default btn-lg ">C++</a>
		  <a type="button" class="btn btn-default btn-lg">数据库</a>
		</div>
	<div class="title">3、请在下面一组中选出最擅长的一项：</div>
		<div class="btn-group btn-group-justified">
		  <a class="btn btn-default btn-lg">Java</a>
		  <a type="button" class="btn btn-default btn-lg">C++</a>
		  <a class="btn btn-default btn-lg">Java</a>
		</div>  -->
   </div> 
 <div class="btn_area">    
     <button class="btn btn-info btnradius" id="the_next" type="button">提交</button> 
     <a href="#topic2" class="btn btn-info" data-transition="slide" data-role="button" id="first"><font class="next_one">提交</font></a>
 </div>     
    </form>
  </div>
</div>

   <!-- 显示部分 -->
  <div data-role="page" id="topic2"> 
       <div class="topheader">考前须知</div>
      <!--     <div class="topbanner"></div>-->
  <div  id="topic">
 <!-- Title -->

  <!-- 内容 --> 
    <div id="content" class="Language">
    <div class="title">您参加的是2014年亚信联创春季校园招聘会。 <br><br>考试说明：</div>

   <ul>   
      <li>考试时长<font id="suggestTime"></font>分钟</li>
      <li>共有<font id="questionLength"></font>道题，题型包含<font id="partDesc"></font></li>
      <li>错选、漏选均不得分。</li>
   </ul>    
 <!-- 
     <ul>
       <li>计算机基础：<font class="tot_num">20题</font></li>
        <li>Java基础：<font class="tot_num">20题</font></li>
        <li>数据库：<font class="tot_num">10题</font></li>
        <li>英语：<font class="tot_num">10题</font></li>
     </ul>
    
      <br>祝您取得好成绩！         --> 
    </div>          
          
    </div>  
  <!-- 按钮 -->
    <div  data-theme="b" class="btn_area">
      <button class="btn btn-info btn-block btnradius" id="konw">我知道了</button>   
    </div>
</div>
  </body>
</html>

<script type="text/javascript">

         $(document).ready(function(){
         var language=1;
         $('.btn-group').find('a').click(function(){
                $('a').removeClass('btn-info');
                $(this).addClass('btn-info');
                language = $(this).text();
                language = language.toLocaleLowerCase() ;
         });
         
	     $('#the_next').click(function(){
	         if(language!=1)
	         {
	         $('#first').click();
	         var mes = {"language":language};
              $.ajax({
		url: "<%=request.getContextPath()%>/wx/schoolExam/generatePaper",
		type : "post",
		contentType: 'application/json',
		dataType : "json",
		data : JSON.stringify(mes),
		success :  function(result){
		  
	        console.log(result)
        
          $('#partDesc').text(result.data.partDatas[0].partDesc);
          $('#suggestTime').text(result.data.partDatas[0].suggestTime/60);
          $('#questionLength').text(result.data.partDatas[0].questionLength); 
		},
        });
         }
	     });
         
        	
         $('#konw').click(function(){
        	 alert(123);

         });
      });
</script>

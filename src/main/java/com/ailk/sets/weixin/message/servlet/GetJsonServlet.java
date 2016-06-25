package com.ailk.sets.weixin.message.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;





public class GetJsonServlet extends HttpServlet {

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {


	}
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		String resultload = request.getParameter("res");
		//在页面加载的时候得到一个json根据这个值做判断 然后还要传送给前台一个值
		System.out.println("getJson :"+resultload);
		if("2".equals(resultload)){
			//发送一条数据到前台做处理
			JSONObject sendobj = new JSONObject();
		   	sendobj.put("re", "asdf");//返回个后台一个值 notime是没倒考试时间  不是notime就是可以擦你啊吃
			sendobj.put("userName", "tracy");
			sendobj.put("email", "tracy@126.com");
			sendobj.put("tel", "10086");
			sendobj.put("school", "长春理工大学");
			response.getWriter().print(sendobj.toString());
	}
	}
}

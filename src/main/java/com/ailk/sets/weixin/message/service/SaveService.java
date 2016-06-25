package com.ailk.sets.weixin.message.service;
import java.io.IOException;
import java.util.Date;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

import com.ailk.sets.weixin.message.resp.TextMessage;
import com.ailk.sets.weixin.message.util.MessageUtil;


public class SaveService {
	public static String processRequest1(HttpServletRequest request ) throws ServletException, IOException {  
		
    	String respMessage = null;  
    	try {  
        // xml请求解析  
        Map<String, String> requestMap = MessageUtil.parseXml(request);  
        // 发送方帐号（open_id）  
        String fromUserName = requestMap.get("FromUserName");  
        // 公众帐号  
        String toUserName = requestMap.get("ToUserName");  
        // 消息类型  
        String msgType = requestMap.get("MsgType");     
        // 回复文本消息  
        TextMessage textMessage = new TextMessage();  
        textMessage.setToUserName(fromUserName);  
        textMessage.setFromUserName(toUserName);  
        textMessage.setCreateTime(new Date().getTime());  
        textMessage.setMsgType(MessageUtil.RESP_MESSAGE_TYPE_TEXT);  
        textMessage.setFuncFlag(0); 
       
        //获得点击保存按钮的时候传过来的resultSave
        String respContent = "考试时间尚未开始，敬请期待！";
      
        textMessage.setContent(respContent);  
        respMessage = MessageUtil.MessageToXml(textMessage);  
        
           }catch (Exception e) {  
	            e.printStackTrace();  
	        } 
          // System.out.println(respMessage);
           return respMessage;
	}
}


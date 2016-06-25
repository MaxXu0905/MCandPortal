package com.ailk.sets.control;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.methods.RequestEntity;
import org.apache.commons.httpclient.methods.StringRequestEntity;


public class CoreServletTest {
	public static void postXmlRequest(String requestUrl, String xmlData, String contentType, String charset){
    PostMethod post = new PostMethod(requestUrl);
    try {
        RequestEntity entity = new StringRequestEntity(xmlData, contentType, charset);
    	post.setRequestEntity(entity);
    	post.getParams().setContentCharset("UTF-8");
        HttpClient httpClient = new HttpClient();
        int statusCode = httpClient.executeMethod(post);
        System.out.println(statusCode);
        String bodyContent = post.getResponseBodyAsString();
        System.out.println(bodyContent);
        
    } catch (UnsupportedEncodingException e) {
        e.printStackTrace();
    }catch (HttpException e) {
        e.printStackTrace();
    } catch (IOException e) {
        e.printStackTrace();
    } catch (Exception e){
        e.printStackTrace();
    }finally {
        //close the connection.
        post.releaseConnection();
    }
}
	
	public static void main(String[] args) {
		String requestUrl = "http://localhost:8080/CandPortal/CoreServlet";//服务地址
		String  xmlData = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><msg>" +
	      "<FromUserName>aaa</FromUserName>"+ //考生微信号
	      "<ToUserName>gh_7b7faedf05db</ToUserName>"+//公司微信号
	      "<MsgType>text</MsgType>"+
	      "<Content>beiyou</Content>" +  //口令
	      "</msg>";
		CoreServletTest.postXmlRequest(requestUrl, xmlData, "text/html", "UTF-8");
	}
}

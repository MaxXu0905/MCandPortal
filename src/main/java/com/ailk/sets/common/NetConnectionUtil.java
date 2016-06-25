package com.ailk.sets.common;

import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;

import org.jasig.cas.client.validation.Assertion;
import org.jasig.cas.client.validation.TicketValidationException;

public class NetConnectionUtil {
	public static String httpRequest(String urlPath)
	{
//		try {
			
			TicketValidator netUtil = new TicketValidator("") {
				
				@Override
				protected String retrieveResponseFromServer(URL arg0, String arg1) {
					// TODO Auto-generated method stub
					return null;
				}
				
				@Override
				protected Assertion parseResponseFromServer(String arg0)
						throws TicketValidationException {
					// TODO Auto-generated method stub
					return null;
				}
				
				@Override
				protected String getUrlSuffix() {
					// TODO Auto-generated method stub
					return null;
				}
			};
//		}
			
			return netUtil.httpRequest(urlPath);
//			URLConnection conn = new URL(urlPath).openConnection();
//			InputStream is = conn.getInputStream();
//			
//			String sTotalString = "";
//			String sCurrentLine = "";
//			BufferedReader l_reader = new BufferedReader(new InputStreamReader(is));
//	        while ((sCurrentLine = l_reader.readLine()) != null) {
//	            sTotalString += sCurrentLine;  
//	        }
//	        return sTotalString;
//		} catch (MalformedURLException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		} catch (IOException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//		return "";
	}
	
	public static String httpRequest(String urlPath,String httpMethodName,InputStream bis,int contentLength)
	{
		try {
			URLConnection conn = new URL(urlPath).openConnection();
			
			HttpURLConnection httpUrlConnection = (HttpURLConnection) conn;  
			httpUrlConnection.setRequestMethod(httpMethodName);
			
			if(bis != null && ("PUT".equals(httpMethodName)))
			{

				httpUrlConnection.setRequestProperty("Content-type", "multipart/form-data;   boundary=---------------------------7d318fd100112");  
				httpUrlConnection.setRequestProperty("Connection", "Keep-Alive");  
				httpUrlConnection.setRequestProperty("Content-Length", contentLength+"");
				httpUrlConnection.setFixedLengthStreamingMode(contentLength);  
				ByteArrayOutputStream bos = new ByteArrayOutputStream();
				int ch;
				long length = 0;
				while ((ch = bis.read()) != -1) {
					bos.write(ch);
					length++;
				}
				
				httpUrlConnection.setDoOutput(true);
				
				byte[] data = bos.toByteArray(); 
				OutputStream out = httpUrlConnection.getOutputStream();  
				//写入图片流  
				out.write(data);  
				out.flush();  
				out.close();  
			}
			
			InputStream is = httpUrlConnection.getInputStream();
			
			String sTotalString = "";
			String sCurrentLine = "";
			BufferedReader l_reader = new BufferedReader(new InputStreamReader(is));
	        while ((sCurrentLine = l_reader.readLine()) != null) {
	            sTotalString += sCurrentLine;  
	        }
	        return sTotalString;
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "ERROR";
	}
}

package com.ailk.sets.weixin.message.util;

import java.io.InputStream;
import java.io.Writer;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

import com.ailk.sets.weixin.message.resp.TextMessage;
import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.core.util.QuickWriter;
import com.thoughtworks.xstream.io.HierarchicalStreamWriter;
import com.thoughtworks.xstream.io.xml.PrettyPrintWriter;
import com.thoughtworks.xstream.io.xml.XppDriver;




public class MessageUtil {
	

		public static final String REQ_MESSAGE_TYPE_TEXT="text";
		
		public static final String REQ_MESSAGE_TYPE_IMAGE="image";
	
		public static final String REQ_MESSAGE_TYPE_VOICE="voice";
	
		public static final String REQ_MESSAGE_TYPE_VIDEO="video";

		public static final String REQ_MESSAGE_TYPE_LOACTION="loaction";

		public static final String REQ_MESSAGE_TYPE_LINK="link";
	
		public static final String REQ_MESSAGE_TYPE_EVENT="event";
		
		public static final String REQ_MESSAGE_TYPE_SUBSCRIBE="subscribe";
	
		public static final String RESP_MESSAGE_TYPE_TEXT="text";
	
		public static final String RESP_MESSAGE_TYPE_IMAGE="image";
	
		public static final String RESP_MESSAGE_TYPE_VOICE="voice";

		public static final String RESP_MESSAGE_TYPE_VIDEO="video";
	
		public static final String RESP_MESSAGE_TYPE_MUSIC="music";

		public static final String RESP_MESSAGE_TYPE_NEWS="news";
		
		public static final String EVENT_TYPE_SUBSCRIBE = "subscribe";
		
		public static final String EVENT_TYPE_UNSUBSCRIBE ="unsubscribe";
		
		public static final String REQ_MESSAGE_TYPE_LOCATION = "loaction";
		
		public static final String EVENT_TYPE_CLICK = "click";
		
		public static Map<String, String> parseXml(HttpServletRequest request) throws Exception {  
        // ���������洢��HashMap��  
        Map<String, String> map = new HashMap<String, String>();  
  
        // ��request��ȡ��������  
        InputStream inputStream = request.getInputStream();  
        // ��ȡ������  
        SAXReader reader = new SAXReader();  
        Document document = reader.read(inputStream);  
        // �õ�xml��Ԫ��  
        Element root = document.getRootElement();  
        // �õ���Ԫ�ص������ӽڵ�  
          
        @SuppressWarnings("unchecked")  
        List<Element> elementList = root.elements();  
  
        // ���������ӽڵ�  
        for (Element e : elementList) { 
            map.put(e.getName(), e.getText());  
        }
       
        inputStream.close();  
        inputStream = null;  
  
        return map;  
    }  
  
  
    public static String MessageToXml(TextMessage textMessage) {  
        xstream.alias("xml", textMessage.getClass());  
        return xstream.toXML(textMessage);  
    }  
  
   
    private static XStream xstream = new XStream(new XppDriver() {  
        public HierarchicalStreamWriter createWriter(Writer out) {  
            return new PrettyPrintWriter(out) {  
              
                boolean cdata = true;  
                protected void writeText(QuickWriter writer, String text) {  
                    if (cdata) {  
                        writer.write("<![CDATA[");  
                        writer.write(text);  
                        writer.write("]]>");  
                    } else {  
                        writer.write(text);  
                    }  
                }  
            };  
        }  
    });  
      
      
}  

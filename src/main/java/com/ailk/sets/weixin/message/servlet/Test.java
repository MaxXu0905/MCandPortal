package com.ailk.sets.weixin.message.servlet;

import java.io.File;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.bind.Unmarshaller;

import com.ailk.sets.weixin.message.req.TextMessage;

public class Test {
	public Object unmarshalXml(String path, Class... className) {
		Object result = null;
		try {
			File file = new File(path);
			JAXBContext jaxbContext = JAXBContext.newInstance(className);
			// jaxbContext.newInstance(classesToBeBound)
			Unmarshaller jaxbUnmarshaller = jaxbContext.createUnmarshaller();
			result = jaxbUnmarshaller.unmarshal(file);
		} catch (JAXBException e) {
			e.printStackTrace();
		}
		return result;
	}

	public void marshalToXml(Object root, String filePath, Class... className) {
		try {
			File file = new File(filePath);
			JAXBContext jaxbContext = JAXBContext.newInstance(className);
			// jaxbContext.
			Marshaller jaxbMarshaller = jaxbContext.createMarshaller();
			jaxbMarshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
			jaxbMarshaller.marshal(root, file);
		} catch (JAXBException e) {
			e.printStackTrace();
		}
	}

	public static void main(String[] args) {
		System.out.println("00000000000000000000");
		Test util = new Test();
		TextMessage document = (TextMessage) util.unmarshalXml("E:/basemsg.xml", TextMessage.class);
		// System.out.println(document.getToUserName());
		// System.out.println(document.getContent());
		 System.out.println(document.getMsgId());
		System.out.println(document);
		System.out.println("00000000000000000000");
	}
}

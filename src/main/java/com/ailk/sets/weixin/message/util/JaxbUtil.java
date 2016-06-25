package com.ailk.sets.weixin.message.util;

import java.io.InputStream;
import java.io.OutputStream;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.bind.Unmarshaller;

public class JaxbUtil {

	@SuppressWarnings("unchecked")
	public static <T> T unmarshal(InputStream is, Class<T> cls) {
		Object result = null;
		try {
			JAXBContext jaxbContext = JAXBContext.newInstance(cls);
			Unmarshaller jaxbUnmarshaller = jaxbContext.createUnmarshaller();
			result = jaxbUnmarshaller.unmarshal(is);
		} catch (JAXBException e) {
			e.printStackTrace();
		}
		return (T) result;
	}

	public static void marshal(Object root, OutputStream os, Class<?> className) {
		try {
			JAXBContext jaxbContext = JAXBContext.newInstance(className);
			Marshaller jaxbMarshaller = jaxbContext.createMarshaller();
			jaxbMarshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
			jaxbMarshaller.marshal(root, os);
		} catch (JAXBException e) {
			e.printStackTrace();
		}
	}
}

package com.ailk.sets.weixin.message.req;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name = "xml")
public class ImageMessage extends BaseMessage {
	// // 图片链接
	// private String PicUrl;
	//
	// public String getPicUrl() {
	// return PicUrl;
	// }
	//
	// public void setPicUrl(String picUrl) {
	// PicUrl = picUrl;
	// }
	@XmlElement(name = "MediaId", required = true)
	private long MediaId; // 消息id，64位整型

	public long getMediaId() {
		return MediaId;
	}

	public void setMediaId(long mediaId) {
		MediaId = mediaId;
	}

}

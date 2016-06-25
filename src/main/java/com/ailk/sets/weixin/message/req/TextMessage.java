package com.ailk.sets.weixin.message.req;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name = "xml")
public class TextMessage extends BaseMessage {

	@XmlElement(name = "Content")
	private String Content;// 消息内容

	@XmlElement(name = "MsgId")
	private long MsgId; // 消息id，64位整型

	public String getContent() {
		return Content;
	}

	public void setContent(String content) {
		Content = content;
	}

	public long getMsgId() {
		return MsgId;
	}

	public void setMsgId(long MsgId) {
		this.MsgId = MsgId;
	}

}

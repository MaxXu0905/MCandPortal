package com.ailk.sets.weixin.message.event;

public class BaseEvent {
	private String ToUserName;// 	������΢�ź�
	private String FromUserName;// 	���ͷ��ʺţ�һ��OpenID��
	private String CreateTime;// 	��Ϣ����ʱ�� �����ͣ�
	private String MsgType; //	��Ϣ���ͣ�event
	private String Event;
	public String getToUserName() {
		return ToUserName;
	}
	public void setToUserName(String toUserName) {
		ToUserName = toUserName;
	}
	public String getFromUserName() {
		return FromUserName;
	}
	public void setFromUserName(String fromUserName) {
		FromUserName = fromUserName;
	}
	public String getCreateTime() {
		return CreateTime;
	}
	public void setCreateTime(String createTime) {
		CreateTime = createTime;
	}
	public String getMsgType() {
		return MsgType;
	}
	public void setMsgType(String msgType) {
		MsgType = msgType;
	}
	public String getEvent() {
		return Event;
	}
	public void setEvent(String event) {
		Event = event;
	} 
}

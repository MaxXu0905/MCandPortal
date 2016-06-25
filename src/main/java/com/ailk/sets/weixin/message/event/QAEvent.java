package com.ailk.sets.weixin.message.event;




//ɨ���ά��?
public class QAEvent extends BaseEvent {
	private String EventKey;//ɨ���¼�
	private String Ticket;//���ڻ�ȡ��ά��ͼƬ
	public String getEventKey() {
		return EventKey;
	}
	public void setEventKey(String eventKey) {
		EventKey = eventKey;
	}
	public String getTicket() {
		return Ticket;
	}
	public void setTicket(String ticket) {
		Ticket = ticket;
	}
}	

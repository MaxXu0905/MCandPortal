package com.ailk.sets.weixin.message.event;



//�Զ���˵��¼�?
public class MenuEvent extends BaseEvent {
	private String EventKey;
//�¼�KEYֵ ���Զ���˵�����е�KEYֵ��Ӧ
	public String getEventKey() {
		return EventKey;
	}

	public void setEventKey(String eventKey) {
		EventKey = eventKey;
	}
	
}

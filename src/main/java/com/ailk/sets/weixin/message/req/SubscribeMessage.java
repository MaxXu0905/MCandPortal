package com.ailk.sets.weixin.message.req;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name = "xml")
public class SubscribeMessage extends BaseMessage {

	@XmlElement(name = "Event")
	private String Event;
	@XmlElement(name = "EventKey")
	private String EventKey;
	@XmlElement(name = "Ticket")
	private String Ticket;

	public String getEvent() {
		return Event;
	}

	public void setEvent(String event) {
		Event = event;
	}

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

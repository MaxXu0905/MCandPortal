package com.ailk.sets.weixin.message.req;

import java.io.InputStream;

import org.dom4j.Document;
import org.dom4j.io.SAXReader;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.ailk.sets.common.Constant;
import com.ailk.sets.platform.intf.cand.service.IWXCandService;
import com.ailk.sets.platform.intf.empl.domain.CandidateTest;
import com.ailk.sets.weixin.message.IWXExcuter;
import com.ailk.sets.weixin.message.excuter.DefaultExcuter;
import com.ailk.sets.weixin.message.excuter.SubscribeExcuter;
import com.ailk.sets.weixin.message.util.JaxbUtil;

public class ReqFactory {
	private Logger logger = LoggerFactory.getLogger(ReqFactory.class);
	private Document document;
	private InputStream is;
	private IWXCandService wxCandService;
	private CandidateTest candidateSession;

	public ReqFactory(InputStream is, IWXCandService wxCandService, CandidateTest candidateSession) {
		try {
			SAXReader reader = new SAXReader();
			document = reader.read(is);
			this.is = is;
			this.wxCandService = wxCandService;
			this.candidateSession = candidateSession;
		} catch (Exception e) {
			logger.error("error new ReqFactory ", e);
		}
	}

	public String getReq() {
		String msgType = getElementText(Constant.MSGTYPE_TAG);
		IWXExcuter wxExcuter;
//		BaseMessage baseMessage;
		if (msgType.equals(Constant.MSGTYPE_EVENT)) {
			wxExcuter = getEventReq(getElementText(Constant.MSGTYPE_EVENT_TAG));
		} else {
			wxExcuter = new DefaultExcuter();
//			baseMessage = new BaseMessage();
		}
		return wxExcuter.execute();
	}

	private IWXExcuter getEventReq(String subType) {
		if (subType.equals(Constant.MSGTYPE_EVENT_SUBSCRIBE)) {
			return new SubscribeExcuter(wxCandService, JaxbUtil.unmarshal(is, SubscribeMessage.class), candidateSession);
		} else if (subType.equals(Constant.MSGTYPE_EVENT_UNSUBSCRIBE)) {
			return null;
		} else if (subType.equals(Constant.MSGTYPE_EVENT_SCAN)) {
			return null;
		}
		return null;
	}

	private String getElementText(String eleName) {
		return document.getRootElement().elementText(eleName);
	}

}

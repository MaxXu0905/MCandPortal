package com.ailk.sets.weixin.message.excuter;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.ailk.sets.platform.intf.cand.service.IWXCandService;
import com.ailk.sets.platform.intf.empl.domain.CandidateTest;
import com.ailk.sets.platform.intf.exception.PFServiceException;
import com.ailk.sets.weixin.message.IWXExcuter;
import com.ailk.sets.weixin.message.req.SubscribeMessage;

public class SubscribeExcuter implements IWXExcuter {
	private Logger logger = LoggerFactory.getLogger(SubscribeExcuter.class);
	private IWXCandService wxCandService;
	private SubscribeMessage subscribeMessage;
	private CandidateTest candidateSession;

	public SubscribeExcuter(IWXCandService wxCandService, SubscribeMessage subscribeMessage, CandidateTest candidateSession) {
		this.wxCandService = wxCandService;
		this.subscribeMessage = subscribeMessage;
		this.candidateSession = candidateSession;
	}

	@Override
	public String execute() {
		try {
			wxCandService.bindingCandidate(candidateSession.getTestId(), subscribeMessage.getFromUserName());
			return "";
		} catch (PFServiceException e) {
			logger.error("call SubscribeExcuter error", e);
		}
		return null;
	}
}

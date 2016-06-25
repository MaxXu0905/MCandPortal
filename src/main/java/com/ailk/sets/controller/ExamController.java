package com.ailk.sets.controller;

import java.sql.Timestamp;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ailk.sets.common.CPResponse;
import com.ailk.sets.common.Constant;
import com.ailk.sets.common.SysBaseResponse;
import com.ailk.sets.grade.intf.IGradeService;
import com.ailk.sets.platform.intf.cand.service.ICandidateTest;
import com.ailk.sets.platform.intf.cand.service.IExamineService;
import com.ailk.sets.platform.intf.common.PFResponse;
import com.ailk.sets.platform.intf.empl.domain.CandidateTest;
import com.ailk.sets.platform.intf.empl.service.IInvite;
import com.ailk.sets.platform.intf.exception.PFServiceException;
import com.ailk.sets.platform.intf.model.candidateTest.CandidateTestSwitchPage;
import com.ailk.sets.platform.intf.model.candidateTest.CandidateTestSwitchPageId;
import com.ailk.sets.platform.intf.model.monitor.MonitorInfo;

/**
 * 正式答题控制器
 * 
 * @author 
 * 
 */
@Controller
@RequestMapping("exam")
public class ExamController {
	
	private static Logger logger = LoggerFactory
			.getLogger(ExamController.class);

	@Autowired
	private IGradeService gradeService;
	
	@Autowired
	private IExamineService examineService;
	
	@Autowired
	private ICandidateTest candidateTestService;
	@Autowired
	private IInvite invite;

	/**
	 * 获取切换次数配置信息
	 * 
	 * @return
	 */
	@RequestMapping(value = "/getSwitchTimesConfig")
	public @ResponseBody
	CPResponse<MonitorInfo> getSwitchTimesConfig(HttpSession session) {
		CPResponse<MonitorInfo> cpResponse = new CPResponse<MonitorInfo>();
		try {
			CandidateTest candidateSession = (CandidateTest) session
					.getAttribute(Constant.CANDIDATE);
			cpResponse.setData(examineService.getMonitorInfo(candidateSession
					.getTestId()));
			cpResponse.setCode(SysBaseResponse.SUCCESS);
		} catch (PFServiceException e) {
			cpResponse.setCode(SysBaseResponse.ESYSTEM);
			logger.error("call getSwitchTimesConfig error ", e);
		}
		return cpResponse;
	}

	/**
	 * 更新切换次数+1
	 * 
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/updateSwitchTimes", method = RequestMethod.POST)
	public @ResponseBody
	CPResponse<PFResponse> updateSwitchTimes(HttpSession session,
			@RequestBody CandidateTestSwitchPage candidateTestSwitchPage) {
		CPResponse<PFResponse> cpResponse = new CPResponse<PFResponse>();
		try {
			CandidateTest candidateSession = (CandidateTest) session
					.getAttribute(Constant.CANDIDATE);
			CandidateTestSwitchPageId id = new CandidateTestSwitchPageId();
			id.setTestId(candidateSession.getTestId());
			id.setSwitchTime(new Timestamp(System.currentTimeMillis()));
			candidateTestSwitchPage.setId(id);
			cpResponse.setData(candidateTestService
					.updateSwitchTimes(candidateTestSwitchPage));
			cpResponse.setCode(SysBaseResponse.SUCCESS);
		} catch (PFServiceException e) {
			cpResponse.setCode(SysBaseResponse.ESYSTEM);
			logger.error("call updateSwitchTimes error ", e);
		}
		return cpResponse;
	}
}

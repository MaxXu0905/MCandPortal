package com.ailk.sets.controller;

import java.util.Collection;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.ailk.sets.common.CPResponse;
import com.ailk.sets.common.SysBaseResponse;
import com.ailk.sets.interceptor.IFlowControlService;
import com.ailk.sets.interceptor.IFlowControlService.FlowStat;
import com.ailk.sets.platform.intf.cand.domain.ReqInfo;
import com.ailk.sets.platform.intf.cand.domain.ReqInfoKey;
import com.ailk.sets.platform.intf.cand.service.IReqQueueManagerService;
import com.ailk.sets.platform.intf.common.PFResponse;

/**
 * 队列控制器
 * 
 * @author panyl
 * 
 */
@RestController
@RequestMapping("wx/schoolQueue")
public class SchoolReqQueueController {
	private Logger logger = LoggerFactory
			.getLogger(SchoolReqQueueController.class);
	@Autowired
	private IReqQueueManagerService reqQueueManagerService;

	@Autowired
	private IFlowControlService flowControlService;

	private static int enableFlag = 1;

	public static int getEnableFlag() {
		return enableFlag;
	}

	/**
	 * 获取所有队列
	 * 
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/getAllReqQueue")
	public @ResponseBody
	CPResponse<Collection<ReqInfo>> getAllReqQueue(HttpSession session) {
		CPResponse<Collection<ReqInfo>> cpResponse = new CPResponse<Collection<ReqInfo>>();
		try {
			Collection<ReqInfo> col = reqQueueManagerService.getAllReqQueue();
			cpResponse.setData(col);
			cpResponse.setCode(SysBaseResponse.SUCCESS);
		} catch (Exception e) {
			cpResponse.setCode(SysBaseResponse.ESYSTEM);
			cpResponse.setMessage(e.getMessage());
			logger.error("call startExam error", e);
		}
		return cpResponse;
	}

	/**
	 * delete
	 * 
	 * @param session
	 * @param qId
	 */
	@RequestMapping(value = "/delFromReqQueue", method = RequestMethod.POST)
	public @ResponseBody
	CPResponse<PFResponse> delFromReqQueue(@RequestBody ReqInfoKey key) {
		CPResponse<PFResponse> cpResponse = new CPResponse<PFResponse>();
		try {
			logger.debug("delFromReqQueue .... for key  {}", key);
			PFResponse result = reqQueueManagerService.delFromReqQueue(key);
			cpResponse.setCode(SysBaseResponse.SUCCESS);
			cpResponse.setData(result);
		} catch (Exception e) {
			cpResponse.setCode(SysBaseResponse.ESYSTEM);
			cpResponse.setMessage(e.getMessage());
			logger.error("handIn paper error   ", e);
		}
		return cpResponse;
	}

	/**
	 * delete
	 * 
	 * @param session
	 * @param qId
	 */
	@RequestMapping(value = "/delAllReqQueue")
	public @ResponseBody
	CPResponse<PFResponse> delAllReqQueue() {
		CPResponse<PFResponse> cpResponse = new CPResponse<PFResponse>();
		try {
			logger.debug("delFromReqQueue .... all ");
			PFResponse result = reqQueueManagerService.delAllReqQueue();
			cpResponse.setCode(SysBaseResponse.SUCCESS);
			cpResponse.setData(result);
		} catch (Exception e) {
			cpResponse.setCode(SysBaseResponse.ESYSTEM);
			cpResponse.setMessage(e.getMessage());
			logger.error("handIn paper error   ", e);
		}
		return cpResponse;
	}

	/**
	 * updateMaxWaitNumber
	 * 
	 * @param session
	 * @param qId
	 */
	@RequestMapping(value = "/updateMaxWaitNumber/{maxWaitNumber}")
	public @ResponseBody
	CPResponse<PFResponse> updateMaxWaitNumber(@PathVariable int maxWaitNumber) {
		CPResponse<PFResponse> cpResponse = new CPResponse<PFResponse>();
		try {
			logger.debug("updateMaxWaitNumber ....  {}", maxWaitNumber);
			PFResponse result = reqQueueManagerService
					.updateMaxWaitNumber(maxWaitNumber);
			cpResponse.setCode(SysBaseResponse.SUCCESS);
			cpResponse.setData(result);
		} catch (Exception e) {
			cpResponse.setCode(SysBaseResponse.ESYSTEM);
			cpResponse.setMessage(e.getMessage());
			logger.error("handIn paper error   ", e);
		}
		return cpResponse;
	}

	/**
	 * updateMaxWaitNumber
	 * 
	 * @param session
	 * @param qId
	 */
	@RequestMapping(value = "/updateMaxWaitTime/{maxWaitTime}")
	public @ResponseBody
	CPResponse<PFResponse> updateMaxWaitTime(@PathVariable int maxWaitTime) {
		CPResponse<PFResponse> cpResponse = new CPResponse<PFResponse>();
		try {
			logger.debug("updateMaxWaitTime ....  {} ", maxWaitTime);
			PFResponse result = reqQueueManagerService
					.updateMaxWaitTime(maxWaitTime);
			cpResponse.setCode(SysBaseResponse.SUCCESS);
			cpResponse.setData(result);
		} catch (Exception e) {
			cpResponse.setCode(SysBaseResponse.ESYSTEM);
			cpResponse.setMessage(e.getMessage());
			logger.error("handIn paper error   ", e);
		}
		return cpResponse;
	}

	/**
	 * getMaxWaitNumber
	 * 
	 * @param session
	 * @param qId
	 */
	@RequestMapping(value = "/getMaxWaitNumber")
	public @ResponseBody
	CPResponse<Integer> getMaxWaitNumber() {
		CPResponse<Integer> cpResponse = new CPResponse<Integer>();
		try {
			logger.debug("getMaxWaitNumber ....  ");
			Integer result = reqQueueManagerService.getMaxWaitNumber();
			cpResponse.setCode(SysBaseResponse.SUCCESS);
			cpResponse.setData(result);
		} catch (Exception e) {
			cpResponse.setCode(SysBaseResponse.ESYSTEM);
			cpResponse.setMessage(e.getMessage());
			logger.error("handIn paper error   ", e);
		}
		return cpResponse;
	}

	/**
	 * getMaxWaitNumber
	 * 
	 * @param session
	 * @param qId
	 */
	@RequestMapping(value = "/getMaxWaitTime")
	public @ResponseBody
	CPResponse<Integer> getMaxWaitTime() {
		CPResponse<Integer> cpResponse = new CPResponse<Integer>();
		try {
			logger.debug("getMaxWaitTime ....  ");
			Integer result = reqQueueManagerService.getMaxWaitTime();
			cpResponse.setCode(SysBaseResponse.SUCCESS);
			cpResponse.setData(result);
		} catch (Exception e) {
			cpResponse.setCode(SysBaseResponse.ESYSTEM);
			cpResponse.setMessage(e.getMessage());
			logger.error("getMaxWaitTime error   ", e);
		}
		return cpResponse;
	}

	/**
	 * updateFlag
	 * 
	 * @param session
	 * @param qId
	 */
	@RequestMapping(value = "/updateFlag/{flag}")
	public @ResponseBody
	CPResponse<Integer> updateFlag(@PathVariable int flag) {
		CPResponse<Integer> cpResponse = new CPResponse<Integer>();
		try {
			logger.debug("updateFlag ....  {} ", flag);
			SchoolReqQueueController.enableFlag = flag;
			cpResponse.setCode(SysBaseResponse.SUCCESS);
			cpResponse.setData(flag);
		} catch (Exception e) {
			cpResponse.setCode(SysBaseResponse.ESYSTEM);
			cpResponse.setMessage(e.getMessage());
			logger.error("updateFlag error   ", e);
		}
		return cpResponse;
	}

	/**
	 * getFlag
	 * 
	 * @param session
	 * @param qId
	 */
	@RequestMapping(value = "/getFlag")
	public @ResponseBody
	CPResponse<Integer> getFlag() {
		CPResponse<Integer> cpResponse = new CPResponse<Integer>();
		try {
			cpResponse.setCode(SysBaseResponse.SUCCESS);
			cpResponse.setData(enableFlag);
		} catch (Exception e) {
			cpResponse.setCode(SysBaseResponse.ESYSTEM);
			cpResponse.setMessage(e.getMessage());
			logger.error("getFlag error   ", e);
		}
		return cpResponse;
	}

	/**
	 * 获取所有队列
	 * 
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/getFlowStatMap")
	public @ResponseBody
	CPResponse<Map<String, FlowStat>> getFlowStatMap(HttpSession session) {
		CPResponse<Map<String, FlowStat>> cpResponse = new CPResponse<Map<String, FlowStat>>();
		try {
			Map<String, FlowStat> col = flowControlService.getFlowStatMap();
			cpResponse.setData(col);
			cpResponse.setCode(SysBaseResponse.SUCCESS);
		} catch (Exception e) {
			cpResponse.setCode(SysBaseResponse.ESYSTEM);
			cpResponse.setMessage(e.getMessage());
			logger.error("call getFlowStatMap error", e);
		}
		return cpResponse;
	}

}

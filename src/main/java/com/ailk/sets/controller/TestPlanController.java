package com.ailk.sets.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ailk.sets.grade.intf.GetTestPlanRequest;
import com.ailk.sets.grade.intf.GetTestPlanResponse;
import com.ailk.sets.grade.intf.ILoadService;

/**
 * 获取测试执行计划
 * 
 * @author xugq
 * 
 */
@Controller
@RequestMapping("config")
public class TestPlanController {

	@Autowired
	private ILoadService loadService;

	/**
	 * 获取测试执行计划
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/getTestPlan", method = RequestMethod.POST)
	@ResponseBody
	public GetTestPlanResponse getTestPlan(HttpServletRequest httpServletRequest,
			@RequestBody GetTestPlanRequest request) {
		request.setIpAddress(httpServletRequest.getRemoteAddr());
		return loadService.getTestPlan(request);
	}

}

package com.ailk.sets.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ailk.sets.common.Constant;
import com.ailk.sets.platform.intf.cand.service.IWXCandService;
import com.ailk.sets.platform.intf.empl.domain.CandidateTest;
import com.ailk.sets.weixin.message.req.ReqFactory;
import com.ailk.sets.weixin.message.util.SignUtil;

@Controller
@RequestMapping("/wx")
public class WxController {
	private Logger logger = LoggerFactory.getLogger(WxController.class);

	@Autowired
	@Qualifier("wxCandService")
	private static IWXCandService wxCandService;

	@RequestMapping(method = RequestMethod.GET)
	public void getMethod(HttpServletRequest request, HttpServletResponse response) {
		try {
			String signature = request.getParameter("signature");// 时间戳
			String timestamp = request.getParameter("timestamp");// 随机数
			String nonce = request.getParameter("nonce");// 随机字符串
			String echostr = request.getParameter("echostr");
			PrintWriter out = response.getWriter();
			logger.info("微信Get请求数据：{signature ="+signature+",timestamp="+timestamp+",nonce="+nonce+",echostr="+echostr+"}");
			// 通过检验signature对请求进行校验，若校验成功则原样返回echostr，表示接入成功，否则接入失败
			if (SignUtil.checkSignature(signature, timestamp, nonce)) {
			    logger.info("微信TOKEN验证通过");
				out.print(echostr);
			}
			out.close();
		} catch (IOException e) {
			logger.error("error call wx get ", e);
		}
	}

	@RequestMapping(method = RequestMethod.POST)
	public void postMethod(HttpServletRequest request, HttpServletResponse response) {
		try {
			// 将请求、响应的编码均设置为UTF-8（防止中文乱码）
			request.setCharacterEncoding("UTF-8");
			response.setCharacterEncoding("UTF-8");
			HttpSession session = request.getSession();
			CandidateTest candidateSession = (CandidateTest) session.getAttribute(Constant.CANDIDATE);
			logger.info("微信POST请求_");
			ReqFactory reqFactory = new ReqFactory(request.getInputStream(), wxCandService, candidateSession);
			response.getWriter().print(reqFactory.getReq());
		} catch (Exception e) {
			logger.error("error call wx post ", e);
		}
	}
}

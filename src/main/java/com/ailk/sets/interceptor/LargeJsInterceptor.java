package com.ailk.sets.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.ailk.sets.common.Constant;
import com.ailk.sets.grade.intf.IRouteService;

public class LargeJsInterceptor extends HandlerInterceptorAdapter {

	private static final Logger logger = LoggerFactory
			.getLogger(LargeJsInterceptor.class);

	@Autowired
	private IFlowControlService flowControlService;

	@Autowired
	private IRouteService routeService;

	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		HttpSession session = request.getSession();
		String url = request.getRequestURL().toString();
		logger.info("large js w1,{},{}," + System.currentTimeMillis(), url,
				session.getId());

		String netName = (String) session.getAttribute(Constant.NET_NAME);
		if (netName == null) {
			String ip = request.getHeader("X-Forwarded-For");
			if (ip == null || ip.length() == 0
					|| ip.equalsIgnoreCase("unknown"))
				ip = request.getHeader("Proxy-Client-IP");
			if (ip == null || ip.length() == 0
					|| ip.equalsIgnoreCase("unknown"))
				ip = request.getHeader("WL-Proxy-Client-IP");
			if (ip == null || ip.length() == 0
					|| ip.equalsIgnoreCase("unknown"))
				ip = request.getRemoteAddr();

			netName = routeService.getNetName(ip);
			session.setAttribute(Constant.NET_NAME, netName);
		}

		boolean result = flowControlService.preHandle(session.getId(), url,
				netName);
		if (!result) {// 只有wx/index或者wx/verificationInfo才有可能跳转到simpleInfo页面
			String sessionUrl = null;
			String path = request.getContextPath();
			String basePath = request.getScheme() + "://"
					+ request.getServerName() + ":" + request.getServerPort()
					+ path + "/";
			// session.setAttribute("SESSION_BASE_PATH", basePath);
			if (url.contains("verificationInfo")) {
				logger.debug("go verificationInfo for sessionId {} ,url {} ",
						session.getId(), url);
				sessionUrl = basePath + "wx/verificationInfo";
				// session.setAttribute("DIRECT_TYPE", "verificationInfo");
			} else {
				logger.debug("go index for sessionId {} ,url {} ",
						session.getId(), url);
				// session.setAttribute("DIRECT_TYPE", "index");
				String weixinId = url.substring(url.lastIndexOf("/") + 1,
						url.length());
				sessionUrl = basePath + "wx/index/" + weixinId;
				// session.setAttribute("companyWeixinId", weixinId);
			}
			session.setAttribute("SESSION_BASE_URL", sessionUrl);
			session.setAttribute("SESSION_WAIT_TIME",
					flowControlService.getWaitTime(session.getId(), netName));
			response.sendRedirect(request.getContextPath()
					+ "/wx/weixinapp/simpleInfo");
			return false;
		}
		return result;
	}

	@Override
	public void postHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		/*
		 * HttpSession session = request.getSession();
		 * logger.info("large js w2,{},{}," + System.currentTimeMillis(),
		 * request.getRequestURL(), session.getId());//url,sessionId,time,ip
		 */super.postHandle(request, response, handler, modelAndView);
	}

	@Override
	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		logger.info("large js w3,{},{}," + System.currentTimeMillis(),
				request.getRequestURL(), request.getSession().getId());

		HttpSession session = request.getSession();
		String netName = (String) session.getAttribute(Constant.NET_NAME);

		flowControlService.afterCompletion(session.getId(), request
				.getRequestURL().toString(), netName);
	}
}

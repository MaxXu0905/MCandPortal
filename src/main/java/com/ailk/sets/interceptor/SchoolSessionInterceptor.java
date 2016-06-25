package com.ailk.sets.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.ailk.sets.common.Constant;
import com.ailk.sets.common.SchoolCondition;
import com.ailk.sets.common.SysBaseResponse;
import com.ailk.sets.platform.intf.cand.service.ISchoolExamService;
import com.ailk.sets.platform.intf.empl.service.IInvite;

public class SchoolSessionInterceptor extends HandlerInterceptorAdapter {
	@Autowired
	@Qualifier("iInviteService")
	private IInvite iInvite;
	@Autowired
	private ISchoolExamService examineService;
	private static Logger logger = LoggerFactory.getLogger(SchoolSessionInterceptor.class);
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		HttpSession session = request.getSession();
		String type = request.getHeader(Constant.X_REQUEST_TYPE);
//		CandidateExam candidateSession = (CandidateExam) session.getAttribute(Constant.CANDIDATE);
		SchoolCondition schoolCondition = (SchoolCondition) session.getAttribute(Constant.SCHOOL_WEIXIN_SESSION);
		if (schoolCondition == null) {
			if (StringUtils.isNotEmpty(type) && type.equals(Constant.X_REQUEST_VALUE)) {
				// 这是一个 ajax 请求
				JSONObject jo = new JSONObject();
				jo.put("code", SysBaseResponse.ETIME);
				response.getWriter().write(jo.toString());
			    logger.debug("ajax SchoolSessionInterceptor is called ..., status is {}  ",SysBaseResponse.ETIME);
				session.setAttribute(Constant.STATUS, SysBaseResponse.ETIME);
				return false;
			} else {
				session.setAttribute(Constant.STATUS, SysBaseResponse.ETIME);
				 logger.debug("SchoolSessionInterceptor is called ..., status is {} , return error ",SysBaseResponse.ETIME);
				response.sendRedirect(request.getContextPath() + "/wx/weixinapp/directError");
				return false;
			}
		} 
		//取消微信的返回按钮，所以不需要每一步判断是否已经交卷了。。。
		/*SchoolInvitationInfo info = examineService.getSchoolInvitationInfo(schoolCondition.getWeixinId(), schoolCondition.getActivityId());
		if(info != null && info.getCandidateTest() != null){//活动状态只需要在进入时拦截，已经开始答题后活动状态不需要判断。
//			Invitation invitation = info.getInvitation();
			CandidateTest test = info.getCandidateTest();
			if(test.getTestState() != null){
				if(test.getTestState() != 0 && test.getTestState() != 1){
					if (StringUtils.isNotEmpty(type) && type.equals(Constant.X_REQUEST_VALUE)) {
						JSONObject jo = new JSONObject();
						jo.put("code", SysBaseResponse.ANSWERED);
						response.getWriter().write(jo.toString());
						session.setAttribute(Constant.STATUS, SysBaseResponse.ANSWERED);
						logger.error("ajax the invitation {}  has finished  , the state is {}  ", test.getTestId(),test.getTestState());
						return false;
					}else{
						logger.debug("the invitation {}  has finished  , the state is {}  ", test.getTestId(),test.getTestState());
						response.sendRedirect(request.getContextPath() + "/wx/weixinapp/handInPaper");
						return false;
					}
				}
			}
		}*/
		
		/*else {
//			System.out.println(candidateSession.getSessionTicket());
			// 验证session的ticket有效性
			PFResponse info = iInvite.certify(candidateSession.getInvitationId(), candidateSession.getPassport(), candidateSession.getSessionTicket());
			session.setAttribute(Constant.STATUS, info.getCode());
			session.setAttribute(Constant.MESSAGE, info.getMessage());
		}

		String status = (String) session.getAttribute(Constant.STATUS);
		if (!status.equals(FuncBaseResponse.ACCESSABLE)) {
			if (StringUtils.isNotEmpty(type) && type.equals(Constant.X_REQUEST_VALUE)) {
				// 这是一个 ajax 请求
				JSONObject jo = new JSONObject();
				jo.put("code", SysBaseResponse.ETIME);
				response.getWriter().write(jo.toString());
				 logger.debug("SchoolSessionInterceptor is called ..., status is {} , return false ",SysBaseResponse.ETIME);
				return false;
			} else {
				logger.debug("SchoolSessionInterceptor is called ..., status is {} , return error ",SysBaseResponse.ETIME);
				response.sendRedirect(request.getContextPath() + "/error");
				return false;
			}
		}*/
		return super.preHandle(request, response, handler);
	}

}

package com.ailk.sets.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.ailk.sets.common.Constant;
import com.ailk.sets.common.SchoolCondition;
import com.ailk.sets.platform.intf.cand.domain.Invitation;
import com.ailk.sets.platform.intf.cand.service.ISchoolExamService;
import com.ailk.sets.platform.intf.common.FuncBaseResponse;
import com.ailk.sets.platform.intf.domain.CompanyRecruitActivity;
import com.ailk.sets.platform.intf.empl.service.IInvite;
import com.ailk.sets.platform.intf.model.invatition.SchoolInvitationInfo;

public class SchoolLoginInterceptor extends HandlerInterceptorAdapter {
	private static Logger logger = LoggerFactory.getLogger(SchoolLoginInterceptor.class);
	@Autowired
	@Qualifier("iInviteService")
	private IInvite iInvite;
	@Autowired
	private ISchoolExamService examineService;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		HttpSession session = request.getSession();
		SchoolCondition schoolCondition = (SchoolCondition) session.getAttribute(Constant.SCHOOL_WEIXIN_SESSION);
		logger.debug("begin SchoolLoginInterceptor is called, schoolCondition is {}", schoolCondition);
		StringBuffer url = request.getRequestURL();
		String activityIdStri = url.substring(url.lastIndexOf("/") + 1, url.length());
		url = new StringBuffer(url.substring(0, url.lastIndexOf("/")));
		String weixinId = url.substring(url.lastIndexOf("/") + 1, url.length());
		try {
			SchoolInvitationInfo info = null;
			if (schoolCondition == null) {
				// 进行登录验证
				int activityId = Integer.parseInt(activityIdStri);
				schoolCondition = new SchoolCondition();
				schoolCondition.setActivityId(activityId);
				schoolCondition.setWeixinId(weixinId);
				session.setAttribute(Constant.SCHOOL_WEIXIN_SESSION, schoolCondition);
//			    info = examineService.getSchoolInvitationInfo(weixinId, activityId);
//				InvitationInfo info = examineService.getInvitationInfo(weixinId, activityId);//以前是否考试过
				
			}else{
				int activityId = Integer.parseInt(activityIdStri);
				logger.warn("change session info , the oldCondition is {}, new weixinId is {} , activityId is " +activityId ,schoolCondition,weixinId);
				schoolCondition.setActivityId(activityId);
				schoolCondition.setWeixinId(weixinId);
				session.setAttribute(Constant.SCHOOL_WEIXIN_SESSION, schoolCondition);
			}
			/*else if ((!activityIdStri.equals(schoolCondition.getActivityId() + "")) || (!schoolCondition.getWeixinId().equals(weixinId))) {
				session.setAttribute(Constant.STATUS, SysBaseResponse.EPERM);
				response.sendRedirect(request.getContextPath() + "/wx/weixinapp/error");
				return false;
			} else {*/
				 info = examineService.getSchoolInvitationInfo(schoolCondition.getWeixinId(), schoolCondition.getActivityId());
//			}
			if(info != null && info.getActivity() != null){
				CompanyRecruitActivity acti = info.getActivity();
				if(acti.getTestState() != null){
					if(acti.getTestState() == 2){
						logger.debug("the activity has not start or fineshed {}  ", acti.getActivityId());
						session.removeAttribute(Constant.STATUS);
						session.setAttribute(Constant.MESSAGE, "您好，您所参加的招聘活动已经结束");
						response.sendRedirect(request.getContextPath() + "/wx/weixinapp/directError");
						return false;
					}
				}
			}
			
			if(info != null && info.getInvitation() != null){
				Invitation invitation = info.getInvitation();
				if(invitation.getInvitationState() != null){
					if(invitation.getInvitationState() != 1){
						logger.debug("the invitation {}  has finished  , the state is {}  ", invitation.getTestId(),invitation.getInvitationState());
						session.setAttribute(Constant.MESSAGE, "您已经交卷,请不要重复参加考试");
						response.sendRedirect(request.getContextPath() + "/wx/weixinapp/handInPaper");
						return false;
					}
				}
			}
			
			if(info != null && info.getCandidateTest() != null && info.getCandidateTest().getSessionState() != null && info.getCandidateTest().getSessionState() == Constant.SCHOOL_EXAM_PAGE_ANSWERING){
				logger.debug("the exam has been start for invitation {} ", info.getCandidateTest().getTestId());
				session.setAttribute(Constant.CANDIDATE, info.getCandidateTest());
				response.sendRedirect(request.getContextPath() + "/wx/weixinapp/startPaper");
				return false;
			}
			
			logger.debug("end schoolCondition activityId is {}, weixinId is {}  ", schoolCondition.getActivityId(),schoolCondition.getWeixinId());
			/*if (candidateSession != null && candidateSession.getState() != null && candidateSession.getState() != Constant.EXAM_PAGE_REGIST) {
				// 从后台获取访问历史
				response.sendRedirect(request.getContextPath() + "/" + RequestOrder.getController(candidateSession.getState()));
				return false;
			}*/
		} catch (Exception e) {
			logger.error("login exception ", e);
			session.setAttribute(Constant.STATUS, FuncBaseResponse.EXCEPTION);
		}
		return super.preHandle(request, response, handler);
	}

}

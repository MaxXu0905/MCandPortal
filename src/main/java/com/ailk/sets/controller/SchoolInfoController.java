package com.ailk.sets.controller;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.ailk.sets.common.CPResponse;
import com.ailk.sets.common.Constant;
import com.ailk.sets.common.SchoolCondition;
import com.ailk.sets.common.SchoolPageState;
import com.ailk.sets.common.SetsUtils;
import com.ailk.sets.common.SysBaseResponse;
import com.ailk.sets.grade.intf.BaseResponse;
import com.ailk.sets.platform.intf.cand.domain.CandidateInfoExt;
import com.ailk.sets.platform.intf.cand.domain.InfoNeeded;
import com.ailk.sets.platform.intf.cand.domain.SchoolInfoData;
import com.ailk.sets.platform.intf.cand.service.ISchoolExamService;
import com.ailk.sets.platform.intf.cand.service.ISchoolInfoService;
import com.ailk.sets.platform.intf.domain.CompanyRecruitActivity;
import com.ailk.sets.platform.intf.empl.domain.CandidateTest;
import com.ailk.sets.platform.intf.exception.PFServiceException;
import com.ailk.sets.platform.intf.model.invatition.SchoolInvitationInfo;
import com.google.gson.Gson;

/**
 * 校招信息填写控制器
 * @author panyl
 *
 */
@RestController
@RequestMapping("wx/schoolInfo")
public class SchoolInfoController {
	@Autowired
	@Qualifier("schoolInfoService")
	private ISchoolInfoService schoolInfoService;
	
	@Autowired
	private ISchoolExamService examineService;
	
	
	private Logger logger = LoggerFactory.getLogger(SchoolInfoController.class);

	
	/**
	 * 校招提交应聘者信息
	 * 
	 * @param param
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value = "/commitBasicInfo/{companyWeixinId}/{longitude}/{latitude}/{accuracy}", method = RequestMethod.POST)
	public CPResponse<SchoolPageState> commitBasicInfo(HttpServletRequest request,HttpSession session,
                                            	        @PathVariable String companyWeixinId,
                                            	        @PathVariable String longitude,
                                            	        @PathVariable String latitude,
                                            	        @PathVariable String accuracy,
                                            	        @RequestBody List<CandidateInfoExt> list) throws IOException {
		String name = null;
		String email = null;
		for(CandidateInfoExt info : list){
			if(Constant.FULL_NAME.equals(info.getId().getInfoId())){
				name = info.getValue();
			}
			if(Constant.EMAIL.equals(info.getId().getInfoId())){
				email = info.getValue();
			}
		}
		CPResponse<SchoolPageState> cpResponse = new CPResponse<SchoolPageState>();
		try{
			if(StringUtils.isEmpty(name) || StringUtils.isEmpty(email)){
				logger.error("the name or email can not be null , name is {}, email is {}", name,email);
				throw new RuntimeException("the name or email can not be null ");
			}
	        
			// 如果没有经纬度信息，加上ip地址...
			if("-1".equals(longitude))
			{
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
			    longitude = ip;
			}
			// 位置信息
			String locationInfo = longitude.substring(0, 20)+"|"+latitude+"|"+accuracy;
	        session.setAttribute(Constant.LOCATION, locationInfo); // 位置信息放入session中
			logger.debug(" get user location info:{"+locationInfo+"}");
			
			logger.debug("logger watcher3,{},{},"+System.currentTimeMillis()+"," + SetsUtils.getIpAddr(request),email,session.getId());
			session.setAttribute(Constant.SESSION_NAME, name);//姓名邮箱放到session，前台回显使用
			session.setAttribute(Constant.SESSION_MAIL, email);
			String weixinId = name + "_" + email;
			SchoolCondition schoolCondition = new SchoolCondition();
			schoolCondition.setWeixinId(weixinId);
			cpResponse.setCode(SysBaseResponse.SUCCESS);
			List<CompanyRecruitActivity> actis = schoolInfoService.getCompanyRecruitActivitysActive(companyWeixinId);
			if(actis.size() > 1){
				logger.warn("have more than one activity for companyWeixinNo {},please check ", companyWeixinId);
			}
			CompanyRecruitActivity c = actis.get(0);
			schoolCondition.setActivityId(c.getActivityId());
			SchoolInfoData schoolInfo = schoolInfoService.getCompanyByPositionEntry(companyWeixinId);
			if(null == schoolInfo)
			{
			    schoolInfo = new SchoolInfoData();
			}
			schoolInfo.setActivityId(c.getActivityId()); // 活动id
			session.setAttribute(Constant.SCHOOL_INFO, new Gson().toJson(schoolInfo));
			
			logger.debug("enter the activityId {} of companyWeixinId {} ", c.getActivityId() , companyWeixinId );
			session.setAttribute(Constant.SCHOOL_WEIXIN_SESSION, schoolCondition);
			
			SchoolInvitationInfo  info = examineService.getSchoolInvitationInfo(schoolCondition.getWeixinId(), schoolCondition.getActivityId());
			SchoolPageState state = new SchoolPageState();
			if(info != null && info.getCandidateTest() != null){
				CandidateTest test = info.getCandidateTest();
				if(test.getTestState() != null){
					if(test.getTestState() != 0 && test.getTestState() != 1){//已经交卷或者出报告
						logger.debug("the invitation {}  has finished  , the state is {}  ", test.getTestId(),test.getTestState());
						state.setPageState(32); //跳转到 wx/weixinapp/handInPaper
						cpResponse.setData(state);
						return cpResponse;
					}
				}
			}
			
			if(info != null && info.getCandidateTest() != null && info.getCandidateTest().getSessionState() != null && info.getCandidateTest().getSessionState() == Constant.SCHOOL_EXAM_PAGE_ANSWERING){
				logger.debug("the exam has been start for invitation {} ", info.getCandidateTest().getTestId());
				session.setAttribute(Constant.CANDIDATE, info.getCandidateTest());
//				response.sendRedirect(request.getContextPath() + "/wx/weixinapp/startPaper");
				state.setPageState(31);
				cpResponse.setData(state);
				return cpResponse;
			}
			
			// openId
			String openId = (String)session.getAttribute(Constant.OPEN_ID);
			boolean result = schoolInfoService.saveCandidateInfo(openId, weixinId, list);
			if(result == false){
				logger.error("saveCandidateInfo error ");
				cpResponse.setCode(SysBaseResponse.ESYSTEM);
				cpResponse.setMessage("保存参数异常");
				return cpResponse;
			}
			
			state.setPageState(30);
			cpResponse.setData(state);
		}catch(Exception e){
			cpResponse.setCode(SysBaseResponse.ESYSTEM);
			cpResponse.setMessage(e.getMessage());
			logger.error("commit info or checkEnv error ", e);
		}
		return cpResponse;
	}
	 
	/**
	 * 获取输入控件信息
	 * 
	 * @param session
	 * @return
	 */
	@RequestMapping(value="/getInput" , method = RequestMethod.POST)
	public @ResponseBody
	CPResponse<List<InfoNeeded>> getInputInfo(HttpSession session) {
		SchoolCondition schoolCondition = (SchoolCondition) session.getAttribute(Constant.SCHOOL_WEIXIN_SESSION);
	    logger.debug("start getInput the weixinId is {}, activityId is {}", schoolCondition.getWeixinId(), schoolCondition.getActivityId());
		CPResponse<List<InfoNeeded>> cpResponse = new CPResponse<List<InfoNeeded>>();
		try{
			List<InfoNeeded> list = schoolInfoService.getCandConfigInfoExts(schoolCondition.getWeixinId(), schoolCondition.getActivityId());
			logger.debug("list InfoNeed size is {}", list.size());
			cpResponse.setData(list);
			cpResponse.setCode(SysBaseResponse.SUCCESS);
		}catch(Exception e){
			logger.error("get input info error ",e);
			cpResponse.setMessage(e.getMessage());
			cpResponse.setCode(SysBaseResponse.ESYSTEM);
		}
		logger.debug("end getInput the weixinId is {}, activityId is {}", schoolCondition.getWeixinId(), schoolCondition.getActivityId());
		return cpResponse;
	}
	
	
	/**
	 * 校招提交应聘者信息
	 * 
	 * @param param
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value = "/commitInfo", method = RequestMethod.POST)
	public CPResponse<BaseResponse> commitInfo(HttpSession session,@RequestBody List<CandidateInfoExt> list) throws IOException {
		SchoolCondition schoolCondition = (SchoolCondition) session.getAttribute(Constant.SCHOOL_WEIXIN_SESSION);
		String weixinId = schoolCondition.getWeixinId();
		logger.debug("commit info start ... for weixinId {}", weixinId);
		CPResponse<BaseResponse> cpResponse = new CPResponse<BaseResponse>();
		try{
		    String openId = (String)session.getAttribute(Constant.OPEN_ID);
			boolean result = schoolInfoService.saveCandidateInfo(openId , weixinId, list);
			logger.debug("commit info end ... for weixinId {}", weixinId);
			if(result == false){
				logger.error("saveCandidateInfo error ");
				cpResponse.setCode(SysBaseResponse.ESYSTEM);
				cpResponse.setMessage("保存参数异常");
				return cpResponse;
			}
			cpResponse.setCode(SysBaseResponse.SUCCESS);
		}catch(Exception e){
			cpResponse.setCode(SysBaseResponse.ESYSTEM);
			cpResponse.setMessage(e.getMessage());
			logger.error("commit info or checkEnv error ", e);
		}
		return cpResponse;
	}
	
	/**
	 * 获取输入控件信息
	 * 
	 * @param session
	 * @return
	 */
/*	@RequestMapping(value="/getActivityId/{companyWeixinId}" , method = RequestMethod.POST)
	public @ResponseBody
	CPResponse<ActivityState> getActivityId(@PathVariable String companyWeixinId,@RequestBody Passcode condition) {
		logger.debug("getActivityId for companyWeixinId {}, passcode {}",companyWeixinId,condition.getPasscode());
		CPResponse<ActivityState> cpResponse = new CPResponse<ActivityState>();
		try{
			CompanyRecruitActivity c = schoolInfoService.getCompanyRecruitActivity(companyWeixinId, condition.getPasscode());
			ActivityState state = new ActivityState();
			state.setActivityId(c.getActivityId());
			cpResponse.setData(state);
			cpResponse.setCode(SysBaseResponse.SUCCESS);
		}catch(Exception e){
			logger.error("get getActivityId info error ", e);
			cpResponse.setMessage(e.getMessage());
			cpResponse.setCode(SysBaseResponse.ESYSTEM);
		}
		return cpResponse;
	}*/
	/**
	 * 获取输入控件信息
	 * 
	 * @param session
	 * @return
	 */
	@RequestMapping(value="/isCanExam" , method = RequestMethod.POST)
	public @ResponseBody
	CPResponse<ActivityState> isCanExam(HttpSession session) {
		SchoolCondition schoolCondition = (SchoolCondition) session.getAttribute(Constant.SCHOOL_WEIXIN_SESSION);
		logger.debug("isCanExam for getActivityId {}, weixinId {}",schoolCondition.getActivityId(),schoolCondition.getWeixinId());
		CPResponse<ActivityState> cpResponse = new CPResponse<ActivityState>();
		try{
			SchoolInvitationInfo s = examineService.getSchoolInvitationInfo(schoolCondition.getWeixinId(), schoolCondition.getActivityId());
			ActivityState state = new ActivityState();
			state.setState(s.getActivity().getTestState());
			cpResponse.setData(state);
			cpResponse.setCode(SysBaseResponse.SUCCESS);
		}catch(Exception e){
			logger.error("get input info error ", e);
			cpResponse.setMessage(e.getMessage());
			cpResponse.setCode(SysBaseResponse.ESYSTEM);
		}
		return cpResponse;
	}
	
	/**
	 * 前台页面加载完成后的相应事件
	 * @param param
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value = "/clearQueueInfo" )
	public CPResponse<BaseResponse> clearQueueInfo(HttpSession session,HttpServletRequest request){
		logger.debug("clearQueueInfo start ... ");
		CPResponse<BaseResponse> cpResponse = new CPResponse<BaseResponse>();
		cpResponse.setCode(SysBaseResponse.SUCCESS);
		return cpResponse;
	}
	
	/**
	 * 使用passport获得测评信息 entry
	 * @param session
	 * @param passport
	 * 
	 */
	@RequestMapping(value = "/getPositionByPassport/{passport}" )
	public CPResponse<String> getPositionByPassport(HttpSession session, @PathVariable String passport){
	    logger.debug("getPositionByPassport start ... ");
	    CPResponse<String> cpResponse = new CPResponse<String>();
	    try
        {
            cpResponse.setData(schoolInfoService.queryCampusByPassport(passport));
            cpResponse.setCode(SysBaseResponse.SUCCESS);
        } catch (PFServiceException e)
        {
            logger.error("getPositionByPassport error ", e);
            cpResponse.setMessage(e.getMessage());
            cpResponse.setCode(SysBaseResponse.ESYSTEM);
        }
	    return cpResponse;
	}
	
	/**
	 * 使用activityId获得测评信息
	 * @param session
	 * @param passport
	 * 
	 */
//	@RequestMapping(value = "/getPositionByAId/{activityId}" )
//	public CPResponse<SchoolInfoData> get(HttpSession session, @PathVariable Integer activityId){
//	    logger.debug("getPositionByAId start ... ");
//	    CPResponse<SchoolInfoData> cpResponse = new CPResponse<SchoolInfoData>();
//	    try
//	    {
//	        cpResponse.setData(schoolInfoService.getSchoolInfoByAId(activityId));
//	        cpResponse.setCode(SysBaseResponse.SUCCESS);
//	    } catch (PFServiceException e)
//	    {
//	        logger.error("getPositionByAId error ", e);
//	        cpResponse.setMessage(e.getMessage());
//	        cpResponse.setCode(SysBaseResponse.ESYSTEM);
//	    }
//	    return cpResponse;
//	}
	
	class ActivityState{
		private Integer state;
		private Integer activityId;

		public Integer getActivityId() {
			return activityId;
		}

		public void setActivityId(Integer activityId) {
			this.activityId = activityId;
		}

		public Integer getState() {
			return state;
		}

		public void setState(Integer state) {
			this.state = state;
		}
	}
}

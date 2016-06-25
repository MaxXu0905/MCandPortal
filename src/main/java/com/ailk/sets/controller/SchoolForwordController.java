package com.ailk.sets.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ailk.sets.common.CPResponse;
import com.ailk.sets.common.Constant;
import com.ailk.sets.common.SysBaseResponse;
import com.ailk.sets.platform.intf.cand.domain.SchoolInfoData;
import com.ailk.sets.platform.intf.cand.service.ICandidateInfoService;
import com.ailk.sets.platform.intf.cand.service.ISchoolInfoService;
import com.ailk.sets.platform.intf.common.FuncBaseResponse;
import com.ailk.sets.platform.intf.domain.Candidate;
import com.ailk.sets.platform.intf.domain.CompanyRecruitActivity;
import com.ailk.sets.platform.intf.empl.domain.CandidateTest;
import com.ailk.sets.platform.intf.model.wx.model.WXAuthInfo;
import com.ailk.sets.platform.intf.wx.service.IWeixinService;
import com.google.gson.Gson;

/**
 * 
 * sets
 * 
 * @Description 页面跳转
 * @author zengjie
 * @Date 2014年2月19日
 * @version
 * 
 */
@Controller
@RequestMapping("wx")
public class SchoolForwordController {

	@Autowired
	@Qualifier("schoolInfoService")
	private ISchoolInfoService schoolInfoService;

	@Autowired
	@Qualifier("iWeixinService")
	private IWeixinService iWeixinService;
	@Autowired
	private ICandidateInfoService candidateInfo;
	
	private Logger logger = LoggerFactory
			.getLogger(SchoolForwordController.class);

	/**
	 * 获取输入控件信息
	 * 
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/index/{companyWeixinId}", method = RequestMethod.GET)
	public String index(HttpServletRequest request, HttpSession session,
			@PathVariable String companyWeixinId) {
		logger.debug("index for companyWeixinId {}", companyWeixinId);
		try {
			List<CompanyRecruitActivity> list = schoolInfoService
					.getCompanyRecruitActivitysActive(companyWeixinId);
			if (list.size() == 0) {
				logger.debug("=============, no activity for {} ",
						companyWeixinId);
				session.removeAttribute(Constant.STATUS);
				session.setAttribute(Constant.MESSAGE, "亲爱的，现在暂时没有宣讲会考试。敬请期待哦！");
				return "weixinapp/error";
			}
			if (list.size() > 1) {
				logger.warn(
						"have more than one activity for companyWeixinNo ,please check ",
						companyWeixinId);
			}
			SchoolInfoData schoolInfo = schoolInfoService.getCompanyByPositionEntry(companyWeixinId);
			if(schoolInfo != null)
			session.setAttribute(Constant.SCHOOL_INFO, new Gson().toJson(schoolInfo));
		} catch (Exception e) {
			logger.error("index error ", e);
			session.setAttribute(Constant.STATUS, FuncBaseResponse.EXCEPTION);
			return "weixinapp/error";
		}
		session.setAttribute("companyWeixinId", companyWeixinId);
		return "weixinapp/improveInfo";
	}

	@RequestMapping("schoolLogin/{weixinId}/{activityId}")
	public String schoolLogin(HttpSession session,
			@PathVariable String weixinId, @PathVariable int activityId) {
		return "weixinapp/improveInfo";
	}

	@RequestMapping("weixinapp/getPaper")
	public String getPaper() {
		return "weixinapp/getPaper";
	}

	@RequestMapping("weixinapp/improveInfo")
	public String improveInfo() {
		return "weixinapp/improveInfo";
	}

	@RequestMapping("weixinapp/simpleInfo")
	public String simpleInfo() {
		return "weixinapp/simpleInfo";
	}

	@RequestMapping("weixinapp/startPaper")
	public String startPaper() {
		return "weixinapp/startPaper";
	}

	@RequestMapping("weixinapp/handInPaper")
	public String handInPaper() {
		return "weixinapp/handInPaper";
	}
	@RequestMapping("weixinapp/handInPaperModel")
	public String handInPaperModel() {
		return "weixinapp/handInPaperModel";
	}

    @RequestMapping("verificationInfo")
    public String verificationInfo(HttpSession session , HttpServletRequest request ,
            @RequestParam(required=false) String code) {
        logger.info(" weixin auth paramString:{"+ request.getQueryString()+"}");
        logger.info(" weixin auth param {code:"+code+"} ");
        
        String openId = ""; // openId
        // 通过微信授权之后得到换取access_token的票据code
        if(!StringUtils.isBlank(code))
        {
            // 使用OAuth2.0授权后的得到的code获得授权信息(用户openId token等...)
            try
            {
                WXAuthInfo info = iWeixinService.getAuthInfoByCode(code);
                if(StringUtils.isBlank(info.getErrcode())) // 非异常情况
                {
                    openId = StringUtils.stripToEmpty(info.getOpenid());
                    if(StringUtils.isNotEmpty(openId)){
                    	logger.debug("begin get candidte for openId {} ", openId);
                    	Candidate candidate = candidateInfo.getCandidateByOpenId(openId);
                    	if(candidate != null){
							logger.debug("get candidate name is {} email is {} for openId " + openId,
									candidate.getCandidateName(), candidate.getCandidateEmail());
                    		session.setAttribute(Constant.SESSION_NAME, candidate.getCandidateName());//姓名邮箱放到session，前台这样可以自动跳转
                			session.setAttribute(Constant.SESSION_MAIL, candidate.getCandidateEmail());
                    	}
                    }
                }
            } catch (Exception e)
            {
                logger.error(" get weixin OAuth info error ", e);
            }
        }
        session.setAttribute(Constant.OPEN_ID, openId);
        logger.info(" get weixin OAuth info:{openid= "+openId+"}");
        return "weixinapp/verificationInfo";
    }

	@RequestMapping("weixinapp/error")
	public String schoolError(HttpSession session) {
		session.setAttribute(Constant.STATUS, FuncBaseResponse.EXCEPTION);
		return "weixinapp/error";
	}

	@RequestMapping("weixinapp/directError")
	public String directError(HttpSession session) {
		return "weixinapp/error";
	}
	
	/**
	 * 给前台手动调用清理session
	 * 
	 * @param session
	 * @return
	 */
	@RequestMapping("clearSession")
	public @ResponseBody
	CPResponse<Long> clearSession(HttpSession session) {
		CPResponse<Long> cpResponse = new CPResponse<Long>();
		try {
			session.removeAttribute(Constant.SESSION_NAME);
			session.removeAttribute(Constant.SESSION_MAIL);
			session.removeAttribute(Constant.SCHOOL_WEIXIN_SESSION);
			session.removeAttribute(Constant.CANDIDATE);
		} catch (Exception e) {
			cpResponse.setCode(SysBaseResponse.ESYSTEM);
			logger.error("call clearSession error ", e);
		}
		return cpResponse;
	}
}

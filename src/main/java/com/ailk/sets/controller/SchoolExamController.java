package com.ailk.sets.controller;

import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;
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
import com.ailk.sets.common.Constant;
import com.ailk.sets.common.GetQInfoResponseExt;
import com.ailk.sets.common.SchoolAnswerInfo;
import com.ailk.sets.common.SchoolAnswerQuestion;
import com.ailk.sets.common.SchoolCondition;
import com.ailk.sets.common.SysBaseResponse;
import com.ailk.sets.grade.intf.BaseResponse;
import com.ailk.sets.grade.intf.GetQInfoResponse;
import com.ailk.sets.grade.intf.IGradeService;
import com.ailk.sets.grade.intf.report.GetReportSummaryResponse;
import com.ailk.sets.platform.intf.cand.domain.QuestionExt;
import com.ailk.sets.platform.intf.cand.domain.SchoolExamCondition;
import com.ailk.sets.platform.intf.cand.domain.SchoolPaperData;
import com.ailk.sets.platform.intf.cand.service.IExamineService;
import com.ailk.sets.platform.intf.cand.service.ISchoolExamService;
import com.ailk.sets.platform.intf.common.FuncBaseResponse;
import com.ailk.sets.platform.intf.common.PFResponse;
import com.ailk.sets.platform.intf.common.PaperInstancePartStateEnum;
import com.ailk.sets.platform.intf.empl.domain.CandidateTest;
import com.ailk.sets.platform.intf.empl.service.IInvite;
import com.ailk.sets.platform.intf.model.candidateTest.CandidateInfo;

/**
 * 校招考试控制器
 * 
 * @author panyl
 * 
 */
@RestController
@RequestMapping("wx/schoolExam")
public class SchoolExamController {
	private Logger logger = LoggerFactory.getLogger(SchoolExamController.class);
	@Autowired
	private IExamineService examineService;

	@Autowired
	private ISchoolExamService schoolExamineService;

	@Autowired
	private IInvite iInvite;

	@Autowired
	private IGradeService gradeService;

	/**
	 * 开始考试
	 * 
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/startPaper")
	public @ResponseBody
	CPResponse<PFResponse> startPaper(HttpSession session) {
		CandidateTest candidateSession = (CandidateTest) session
				.getAttribute(Constant.CANDIDATE);
		logger.debug("school start exam for invitationId {}",
				candidateSession.getTestId());
		CPResponse<PFResponse> cpResponse = new CPResponse<PFResponse>();
		try {
		/*	examineService.updatePaperInstancePartStatus(
					candidateSession.getTestId(), 1,
					PaperInstancePartStateEnum.ANSWERING.getValue());
			examineService.updatePaperInstancePartStatus(//临时方案 校招只有智力或者选择题两部分二选一
					candidateSession.getTestId(), 8,
					PaperInstancePartStateEnum.ANSWERING.getValue());*/
			PFResponse pfResponse = examineService
					.startExamPaper(candidateSession.getTestId());
			examineService.updateCandidateExamStatus(
					candidateSession.getTestId(),
					Constant.SCHOOL_EXAM_PAGE_ANSWERING);// 更新考试状态,正式开始考试
			cpResponse.setData(pfResponse);
			cpResponse.setCode(SysBaseResponse.SUCCESS);
		} catch (Exception e) {
			cpResponse.setCode(SysBaseResponse.ESYSTEM);
			cpResponse.setMessage(e.getMessage());
			logger.error("call startExam error", e);
		}
		return cpResponse;
	}

	/**
	 * 提交试卷
	 * 
	 * @param session
	 * @param qId
	 */
	@RequestMapping(value = "/handInPaper")
	public @ResponseBody
	CPResponse<PFResponse> handInPaper(HttpSession session) {
		CPResponse<PFResponse> cpResponse = new CPResponse<PFResponse>();
		try {
			CandidateTest candidateSession = (CandidateTest) session
					.getAttribute(Constant.CANDIDATE);
			logger.debug("school handInPaper .... for inviId  {}",
					candidateSession.getTestId());
			PFResponse result = examineService.updatePaperInstancePartStatus(
					candidateSession.getTestId(), 1,
					PaperInstancePartStateEnum.COMMIT_MANUAL.getValue());
			result = examineService.updatePaperInstance(
					candidateSession.getTestId(), 2);// 更新试卷状态，交卷
		/*	session.removeAttribute(Constant.SESSION_NAME);
			session.removeAttribute(Constant.SESSION_MAIL);
			session.removeAttribute(Constant.SCHOOL_WEIXIN_SESSION);
			session.removeAttribute(Constant.CANDIDATE);*/
			// session.removeAttribute(Constant.SESSION_COMPANY_NAME);
			if (FuncBaseResponse.SUCCESS.equals(result.getCode())) {
				cpResponse.setData(result);
				cpResponse.setCode(SysBaseResponse.SUCCESS);
				return cpResponse;
			}
			cpResponse.setData(result);
			cpResponse.setCode(result.getCode());
			cpResponse.setMessage(result.getMessage());
		} catch (Exception e) {
			cpResponse.setCode(SysBaseResponse.ESYSTEM);
			cpResponse.setMessage(e.getMessage());
			logger.error("handIn paper error   ", e);
		}

		return cpResponse;
	}

	
	/**
	 * 开始试卷部分考试
	 * 
	 * @param session
	 * @param qId
	 */
	@RequestMapping(value = "/startPaperPart/{partSeq}")
	public @ResponseBody
	CPResponse<PFResponse> startPaperPart(HttpSession session,
			@PathVariable int partSeq) {
		CPResponse<PFResponse> cpResponse = new CPResponse<PFResponse>();
		try {
			CandidateTest candidateSession = (CandidateTest) session
					.getAttribute(Constant.CANDIDATE);
			logger.debug("goPaperPart for testId {}, partSeq {} ",
					candidateSession.getTestId(), partSeq);
			PFResponse result = examineService.updatePaperInstancePartStatus(
					candidateSession.getTestId(), partSeq,
					PaperInstancePartStateEnum.ANSWERING.getValue());
			if (FuncBaseResponse.SUCCESS.equals(result.getCode())) {
				cpResponse.setData(result);
				cpResponse.setCode(SysBaseResponse.SUCCESS);
				return cpResponse;
			}
			logger.warn("startPaperPart for testId {}, partSeq {} , code is  "
					+ result.getCode() + ", message is" + result.getMessage(),
					candidateSession.getTestId(), partSeq);
			cpResponse.setData(result);
			cpResponse.setCode(result.getCode());
			cpResponse.setMessage(result.getMessage());
		} catch (Exception e) {
			cpResponse.setCode(SysBaseResponse.ESYSTEM);
			cpResponse.setMessage(e.getMessage());
			logger.error("startPaperPart error for partSeq  " + partSeq, e);
		}

		return cpResponse;
	}

	/**
	 * 提交试卷部分
	 * 
	 * @param session
	 * @param qId
	 */
	@RequestMapping(value = "/handInPaperPart/{partSeq}")
	public @ResponseBody
	CPResponse<PFResponse> handInPaperPart(HttpSession session,
			@PathVariable int partSeq) {
		CPResponse<PFResponse> cpResponse = new CPResponse<PFResponse>();
		try {
			CandidateTest candidateSession = (CandidateTest) session
					.getAttribute(Constant.CANDIDATE);
			logger.debug("handInPaperPart for testId {}, partSeq {} ",
					candidateSession.getTestId(), partSeq);
			PFResponse result = examineService.updatePaperInstancePartStatus(
					candidateSession.getTestId(), partSeq,
					PaperInstancePartStateEnum.COMMIT_MANUAL.getValue());
			if (FuncBaseResponse.SUCCESS.equals(result.getCode())) {
				cpResponse.setData(result);
				cpResponse.setCode(SysBaseResponse.SUCCESS);
				return cpResponse;
			}
			logger.warn("handInPaperPart for testId {}, partSeq {} , code is  "
					+ result.getCode() + ", message is" + result.getMessage(),
					candidateSession.getTestId(), partSeq);
			cpResponse.setData(result);
			cpResponse.setCode(result.getCode());
			cpResponse.setMessage(result.getMessage());
		} catch (Exception e) {
			cpResponse.setCode(SysBaseResponse.ESYSTEM);
			cpResponse.setMessage(e.getMessage());
			logger.error("handInPaperPart error for partSeq  " + partSeq, e);
		}

		return cpResponse;
	}
	/**
	 * 提交试卷
	 * 
	 * @param session
	 * @param qId
	 */
	@RequestMapping(value = "/generatePaper")
	public @ResponseBody
	CPResponse<SchoolPaperData> generatePaper(HttpSession session) {
		CPResponse<SchoolPaperData> cpResponse = new CPResponse<SchoolPaperData>();
		try {
			SchoolExamCondition condition = new SchoolExamCondition();
			SchoolCondition schoolCondition = (SchoolCondition) session
					.getAttribute(Constant.SCHOOL_WEIXIN_SESSION);
			condition.setWeixinId(schoolCondition.getWeixinId());
			condition.setActivityId(schoolCondition.getActivityId());
			logger.debug("start school generatePaper .... for condition  {}",
					condition);

			// add by lipan 2014年7月29日16:04:03 添加考试时的位置信息
			condition.setLocationInfo((String) session
					.getAttribute(Constant.LOCATION));

			SchoolPaperData result = schoolExamineService
					.generatePaper(condition);
			String openId = (String) session.getAttribute(Constant.OPEN_ID);
			CandidateInfo info = iInvite.certifyWithWeixin(openId,
					result.getTestId(), result.getPassport(),
					schoolCondition.getWeixinId());
			session.setAttribute(Constant.STATUS, info.getCode());
			if (info.getCode().equals(FuncBaseResponse.ACCESSABLE)) {
				session.setAttribute(Constant.CANDIDATE,
						info.getCandidateTest());
				session.setAttribute(Constant.CANDIDATE_NAME,
						info.getCandidateName());
				session.setAttribute(Constant.CANDIDATE_DESC,
						info.getCandidateDesc());
			} else {
				logger.error("error to certiry inviation {} , weixinId {}",
						result.getTestId(), schoolCondition.getWeixinId());
				session.setAttribute(Constant.STATUS, info.getCode());
				session.setAttribute(Constant.MESSAGE, info.getMessage());
				cpResponse.setMessage("error to certify invitation");
				cpResponse.setCode(SysBaseResponse.ESYSTEM);
				return cpResponse;
			}
			cpResponse.setData(result);
			cpResponse.setCode(SysBaseResponse.SUCCESS);
			logger.debug(
					"end school generatePaper .... the invitationId {}, passport {} ",
					result.getTestId(), result.getPassport());
		} catch (Exception e) {
			cpResponse.setCode(SysBaseResponse.ESYSTEM);
			cpResponse.setMessage(e.getMessage());
			logger.error("generate paper error   ", e);
		}
		return cpResponse;
	}

	/**
	 * 获取试卷结构
	 * 
	 * @param session
	 * @param qId
	 */
	@RequestMapping(value = "/getPaper")
	public @ResponseBody
	CPResponse<SchoolPaperData> getPaper(HttpSession session) {
		CPResponse<SchoolPaperData> cpResponse = new CPResponse<SchoolPaperData>();
		try {
			CandidateTest candidateSession = (CandidateTest) session
					.getAttribute(Constant.CANDIDATE);
			logger.debug("school getPaper .... for inviId  {}",
					candidateSession.getTestId());
			SchoolPaperData result = schoolExamineService
					.getPaperByInvitationId(candidateSession.getTestId());//
			cpResponse.setData(result);
			cpResponse.setCode(SysBaseResponse.SUCCESS);
			return cpResponse;
		} catch (Exception e) {
			cpResponse.setCode(SysBaseResponse.ESYSTEM);
			cpResponse.setMessage(e.getMessage());
			logger.error("getPaper paper error   ", e.getMessage());
		}

		return cpResponse;
	}

	/**
	 * 查询某试题，可以带上上一题的答案
	 * 
	 * @param param
	 * @return
	 */
	@RequestMapping(value = "/commitAnswerOrGetNext", method = RequestMethod.POST)
	public @ResponseBody
	CPResponse<GetQInfoResponseExt> commitAnswerOrGetNext(HttpSession session,
			@RequestBody SchoolAnswerQuestion condidtion) {
		CPResponse<GetQInfoResponseExt> cpResponse = new CPResponse<GetQInfoResponseExt>();
		try {
			CandidateTest candidateSession = (CandidateTest) session
					.getAttribute(Constant.CANDIDATE);
			long qId = -1;
			int partSeq = -1;
			if (condidtion.getQuestion_id() != null) {
				qId = condidtion.getQuestion_id();
			}
			if (condidtion.getPartSeq() != null) {
				partSeq = condidtion.getPartSeq();
			}
			if (condidtion.getAnswer() != null) {
				SchoolAnswerInfo answer = condidtion.getAnswer();// answer =
																	// jo.getJSONObject("answer");
				long id = answer.getId();
				String choice = answer.getChoice();
				logger.debug("the qid is {}, the choice is {}, desc " + answer.getChoiceDesc(), id, choice);
				BaseResponse res2 = gradeService.commitChoice(
						candidateSession.getTestId(), id, choice, answer.getChoiceDesc());
				if (res2.getErrorCode() != BaseResponse.SUCCESS) {
					cpResponse.setMessage(res2.getErrorDesc());
					cpResponse.setCode(res2.getErrorCode() + "");
					logger.error(
							"commitChoice error for InvitationId {} , id {} "
									+ res2.getErrorDesc(),
							candidateSession.getTestId(), id);
					return cpResponse;
				}
				if (answer.getAnswerTime() != null) {
					int answerTime = answer.getAnswerTime();
					if (answerTime > 1) {
						examineService.addTimeToPaperInstanceQuestion(
								candidateSession.getTestId(), id, answerTime);
					} else {
						logger.debug(
								"not need to add answerTime to PaperInstanceQuestion for id {}, answerTime {} ",
								id, answerTime);
					}
					examineService.updatePaperInstanceQuestionInfo(
							candidateSession.getTestId(), partSeq, id, 2);// 更新结束答题时间
				}
			}
			logger.debug("start get next question id {} ", qId);
			if (qId != -1) {// 取下一题
				if (qId != -1 && partSeq != -1) {
					examineService.updatePartSeqAndQuesitonId(
							candidateSession.getTestId(), partSeq, qId, -1, -1);// 校招partIndex
																				// questionIndex设置为-1
				}
				GetQInfoResponse res = gradeService.getQInfo(
						candidateSession.getTestId(), qId);
				GetQInfoResponseExt resExt = new GetQInfoResponseExt();
				BeanUtils.copyProperties(resExt, res);
				QuestionExt ext = examineService.getQuestionExt(
						candidateSession.getTestId(), qId);
				logger.debug("the extra left time is for qId {}  is {} ",
						ext.getLeftTime(), qId);
				resExt.setSuggestTime(ext.getLeftTime());
				examineService.updatePaperInstanceQuestionInfo(
						candidateSession.getTestId(), partSeq, qId, 1);// 更新开始答题时间
				cpResponse.setData(resExt);
				cpResponse.setCode(res.getErrorCode() + "");
				cpResponse.setMessage(res.getErrorDesc());
				logger.debug("end get question for id {} ", qId);
				return cpResponse;
			}
			cpResponse.setCode(BaseResponse.SUCCESS + "");
			cpResponse.setMessage("commit part");
		} catch (Exception e) {
			logger.error("save or get question error ", e);
			cpResponse.setCode(SysBaseResponse.ESYSTEM);
			cpResponse.setMessage(e.getMessage());
		}
		return cpResponse;
	}

	/**
	 * 查询某试题，可以带上上一题的答案
	 * 
	 * @param param
	 * @return
	 */
	@RequestMapping(value = "/gradeReport", method = RequestMethod.POST)
	public @ResponseBody
	CPResponse<GetReportSummaryResponse> gradeReport(HttpSession session) {
		CPResponse<GetReportSummaryResponse> cpResponse = new CPResponse<GetReportSummaryResponse>();
		try {
			CandidateTest candidateTest = (CandidateTest) session
					.getAttribute(Constant.CANDIDATE);
			cpResponse.setData(gradeService.gradeReport(candidateTest
					.getTestId()));
			return cpResponse;
		} catch (Exception e) {
			logger.error("getReportSummary error ", e);
			cpResponse.setCode(SysBaseResponse.ESYSTEM);
			cpResponse.setMessage(e.getMessage());
		}
		return cpResponse;
	}

}

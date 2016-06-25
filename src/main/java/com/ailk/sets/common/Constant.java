package com.ailk.sets.common;

public class Constant {
	public static final String CANDIDATE = "candidate";
	public static final String STATUS = "status";
	public static final String MESSAGE = "message";
	public static final String CANDIDATE_NAME = "CandidateName";
	public static final String CANDIDATE_DESC = "CandidateDesc";
	public static final int SEARCH_SIZE = 10;

	// session拦截请求分类
	public static final String X_REQUEST_TYPE = "X-Requested-With";
	public static final String X_REQUEST_VALUE = "XMLHttpRequest";

	// 应聘者页面
	public static final int EXAM_PAGE_REGIST = 1;// 填写资料
	public static final int EXAM_PAGE_TEST = 2;// 试答
	public static final int EXAM_PAGE_ANSWERING = 3;// 正式答题

	public static final String SCHOOL_WEIXIN_SESSION = "SCHOOL_WEIXIN_SESSION";
	public static final int SCHOOL_EXAM_PAGE_ANSWERING = 33;// 校招开始考试

	public static final String EMAIL = "EMAIL";
	public static final String FULL_NAME = "FULL_NAME";
	public static final String SESSION_NAME = "SESSION_NAME";
	public static final String SESSION_MAIL = "SESSION_MAIL";
//	public static final String SCHOOL_ACTIVITY_ID = "SCHOOL_ACTIVITY_ID";// 校招活动id
//	public static final String SESSION_COMPANY_NAME = "SESSION_COMPANY_NAME";
	public static final String SCHOOL_INFO = "SCHOOL_INFO"; // 校招活动信息
	public static final String OPEN_ID = "OPEN_ID"; // 授权后或得到的OPEN_ID
	public static final String LOCATION = "LOCATION"; // 用户位置信息
	public static final String NET_NAME = "NET_NAME"; // IP地址网络名称
	
	//微信消息类型
	public static final String MSGTYPE_TAG = "MsgType";
	public static final String MSGTYPE_EVENT_TAG = "Event";
	public static final String MSGTYPE_TEXT = "text";
	public static final String MSGTYPE_IMAGE = "image";
	public static final String MSGTYPE_VOICE = "voice";
	public static final String MSGTYPE_VIDEO = "video";
	public static final String MSGTYPE_LOACTION = "loaction";
	public static final String MSGTYPE_LINK = "link";
	public static final String MSGTYPE_EVENT = "event";
	public static final String MSGTYPE_EVENT_SUBSCRIBE = "subscribe";
	public static final String MSGTYPE_EVENT_UNSUBSCRIBE = "unsubscribe";
	public static final String MSGTYPE_EVENT_SCAN = "SCAN";
	public static final String MSGTYPE_EVENT_LOCATION = "LOCATION";
	public static final String MSGTYPE_EVENT_CLICK = "CLICK";
	public static final String MSGTYPE_EVENT_VIEW = "VIEW";
}

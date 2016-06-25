package com.ailk.sets.common;

public class SchoolCondition {
	@Override
	public String toString() {
		return "SchoolCondition [weixinId=" + weixinId + ", activityId="
				+ activityId + "]";
	}

	private String weixinId;
	private Integer activityId;

	public String getWeixinId() {
		return weixinId;
	}

	public void setWeixinId(String weixinId) {
		this.weixinId = weixinId;
	}

	public Integer getActivityId() {
		return activityId;
	}

	public void setActivityId(Integer activityId) {
		this.activityId = activityId;
	}
}

package com.ailk.sets.interceptor;

import java.util.HashMap;
import java.util.Map;

import com.ailk.sets.common.SessionInfo;

public interface IFlowControlService {

	public boolean preHandle(String sessionId, String url, String netName);

	public void afterCompletion(String sessionId, String url, String netName);

	public int getWaitTime(String sessionId, String netName);

	public Map<String, FlowStat> getFlowStatMap();

	public void doSessionExpires();

	public void doWaitingExpires();

	public void doReadyExpires();

	public static final int ACCEPTABLE_DELAY = 3000; // 可接受的首页延时
	public static final double MISS_RATE = 0.5; // 延时请求率
	public static final int MAX_EXPIRES = 30000; // 超时
	public static final int MAX_READY_EXPIRES = 7200000; // ready数据的超时
	public static final int MAX_WAIT_TIME = 30000; // 最大等待时间
	public static final int MAX_WAITING_EXPIRES = MAX_WAIT_TIME + 5000; // waiting数据的超时
	public static final int SAMPLE_RATE = 5000; // 采样间隔
	public static final int DFLT_CONCURRENCY = 60; // 默认并发度
	public static final int MIN_CONCURRENCY = 10; // 最小并发度

	public static class WaitingInfo {
		private long timestamp;
		private int waitTime;

		public long getTimestamp() {
			return timestamp;
		}

		public void setTimestamp(long timestamp) {
			this.timestamp = timestamp;
		}

		public int getWaitTime() {
			return waitTime;
		}

		public void setWaitTime(int waitTime) {
			this.waitTime = waitTime;
		}
	}

	public static class FlowStat {
		private long expireAt; // 统计超时时间
		private int totalProcessed; // 已处理总共记录数
		private int sessionExpired; // 会话内超时总计记录数
		private int waitingExpired; // 等待的超时总计记录数
		private int processed; // 已处理记录数
		private int maxConcurrency; // 最大并发数
		private Map<String, SessionInfo> sessionMap; // 会话映射
		private Map<String, WaitingInfo> waitingMap; // 等待映射

		public FlowStat() {
			expireAt = 0L;
			totalProcessed = 0;
			sessionExpired = 0;
			waitingExpired = 0;
			processed = 0;
			maxConcurrency = DFLT_CONCURRENCY;
			sessionMap = new HashMap<String, SessionInfo>();
			waitingMap = new HashMap<String, WaitingInfo>();
		}

		public long getExpireAt() {
			return expireAt;
		}

		public void setExpireAt(long expireAt) {
			this.expireAt = expireAt;
		}

		public int getTotalProcessed() {
			return totalProcessed;
		}

		public void setTotalProcessed(int totalProcessed) {
			this.totalProcessed = totalProcessed;
		}

		public int getSessionExpired() {
			return sessionExpired;
		}

		public void setSessionExpired(int sessionExpired) {
			this.sessionExpired = sessionExpired;
		}

		public int getWaitingExpired() {
			return waitingExpired;
		}

		public void setWaitingExpired(int waitingExpired) {
			this.waitingExpired = waitingExpired;
		}

		public int getProcessed() {
			return processed;
		}

		public void setProcessed(int processed) {
			this.processed = processed;
		}

		public int getMaxConcurrency() {
			return maxConcurrency;
		}

		public void setMaxConcurrency(int maxConcurrency) {
			this.maxConcurrency = maxConcurrency;
		}

		public Map<String, SessionInfo> getSessionMap() {
			return sessionMap;
		}

		public void setSessionMap(Map<String, SessionInfo> sessionMap) {
			this.sessionMap = sessionMap;
		}

		public Map<String, WaitingInfo> getWaitingMap() {
			return waitingMap;
		}

		public void setWaitingMap(Map<String, WaitingInfo> waitingMap) {
			this.waitingMap = waitingMap;
		}
	}

}

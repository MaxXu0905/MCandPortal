package com.ailk.sets.interceptor;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.PostConstruct;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.ailk.sets.common.SessionInfo;

@Service
public class FlowControlService implements IFlowControlService {

	private static final Logger logger = LoggerFactory
			.getLogger(FlowControlService.class);

	private Map<String, FlowStat> flowStatMap;
	private Map<String, Long> readyMap;

	@PostConstruct
	public void postInit() {
		flowStatMap = new HashMap<String, FlowStat>();
		readyMap = new HashMap<String, Long>();
	}

	@Override
	public synchronized boolean preHandle(String sessionId, String url,
			String netName) {
		// 如果已在ready集合中，则允许处理
		if (readyMap.containsKey(sessionId))
			return true;

		// 查询流量统计数据
		FlowStat flowStat = flowStatMap.get(netName);
		if (flowStat == null) {
			flowStat = new FlowStat();
			flowStatMap.put(netName, flowStat);
		}

		Map<String, SessionInfo> sessionMap = flowStat.getSessionMap();
		Map<String, WaitingInfo> waitingMap = flowStat.getWaitingMap();
		long timestamp = System.currentTimeMillis();

		// 如果未注册过，而且并发数达到上限，则不允许处理 只有首页拦截跳转可能返回false 下载js不能返回false
		if ((url.contains("/wx/index") || url.contains("/wx/verificationInfo"))
				&& sessionMap.size() >= flowStat.getMaxConcurrency()
				&& !sessionMap.containsKey(sessionId)) {
			// 计算等待时间
			int waitTime = (int) (waitingMap.size() / ((1 + MISS_RATE)
					* flowStat.getMaxConcurrency() * 1000.0 / ACCEPTABLE_DELAY));
			if (waitTime < ACCEPTABLE_DELAY)
				waitTime = ACCEPTABLE_DELAY;
			else if (waitTime > MAX_WAIT_TIME)
				waitTime = MAX_WAIT_TIME;

			WaitingInfo waitingInfo = new WaitingInfo();
			waitingInfo.setTimestamp(timestamp);
			waitingInfo.setWaitTime(waitTime);
			waitingMap.put(sessionId, waitingInfo);
			return false;
		}

		// 检查特殊的URL 下载js
		if (!url.contains("/wx/") || url.contains("/wx/verificationInfo")
				|| url.contains("/wx/index")) {
			SessionInfo sessionInfo = sessionMap.get(sessionId);
			if (sessionInfo == null) {
				sessionInfo = new SessionInfo();
				sessionInfo.setTimestamp(0);
				sessionInfo.setPending(1);
				sessionMap.put(sessionId, sessionInfo);
			} else {
				sessionInfo.setTimestamp(0);
				sessionInfo.setPending(sessionInfo.getPending() + 1);
			}

			waitingMap.remove(sessionId);
			return true;
		}

		// 其他调用请求，表示客户端环境已具备
		sessionMap.remove(sessionId);
		readyMap.put(sessionId, timestamp);

		// 添加统计数据
		flowStat.setTotalProcessed(flowStat.getTotalProcessed() + 1);
		if (flowStat.getProcessed() == 0) {
			// 时间段统计开始
			flowStat.setExpireAt(timestamp + SAMPLE_RATE);
			flowStat.setProcessed(1);
		} else if (timestamp < flowStat.getExpireAt()) {
			// 处于统计时间段内
			flowStat.setProcessed(flowStat.getProcessed() + 1);
		} else {
			// 超过统计时间段，需要调整并发度
			int elapsed = (int) (timestamp - flowStat.getExpireAt() + SAMPLE_RATE);
			int concurrency = flowStat.getProcessed() * ACCEPTABLE_DELAY
					/ elapsed;
			if (concurrency < MIN_CONCURRENCY)
				concurrency = MIN_CONCURRENCY;

			flowStat.setMaxConcurrency(concurrency);

			logger.info("netName=" + netName + ", concurrency="
					+ flowStat.getMaxConcurrency() + ", waiting="
					+ flowStat.getWaitingMap().size() + ", totalProcessed="
					+ flowStat.getTotalProcessed() + ", processRate="
					+ ((flowStat.getProcessed() * 1000.0) / elapsed));

			// 重新开始统计
			flowStat.setExpireAt(timestamp + SAMPLE_RATE);
			flowStat.setProcessed(1);
		}

		return true;
	}

	@Override
	public synchronized void afterCompletion(String sessionId, String url,
			String netName) {
		// 查询流量统计数据
		FlowStat flowStat = flowStatMap.get(netName);
		if (flowStat == null)
			return;

		Map<String, SessionInfo> sessionMap = flowStat.getSessionMap();

		SessionInfo sessionInfo = sessionMap.get(sessionId);
		if (sessionInfo == null)
			return;

		sessionInfo.setPending(sessionInfo.getPending() - 1);
		if (sessionInfo.getPending() == 0) {
			// 启用超时
			sessionInfo.setTimestamp(System.currentTimeMillis());
		}
	}

	@Override
	public synchronized int getWaitTime(String sessionId, String netName) {
		FlowStat flowStat = flowStatMap.get(netName);
		if (flowStat == null)
			return ACCEPTABLE_DELAY / 1000;

		WaitingInfo waitingInfo = flowStat.getWaitingMap().get(sessionId);
		if (waitingInfo == null)
			return ACCEPTABLE_DELAY / 1000;

		return waitingInfo.getWaitTime() / 1000;
	}

	@Override
	public Map<String, FlowStat> getFlowStatMap() {
		return flowStatMap;
	}

	@Scheduled(fixedDelay = MAX_EXPIRES, initialDelay = MAX_EXPIRES)
	@Override
	public synchronized void doSessionExpires() {
		long expires = System.currentTimeMillis() - MAX_EXPIRES;

		for (FlowStat flowStat : flowStatMap.values()) {
			Map<String, SessionInfo> sessionMap = flowStat.getSessionMap();
			Iterator<Entry<String, SessionInfo>> iter = sessionMap.entrySet()
					.iterator();
			while (iter.hasNext()) {
				Entry<String, SessionInfo> entry = iter.next();
				SessionInfo sessionInfo = entry.getValue();
				if (sessionInfo.getTimestamp() > 0
						&& sessionInfo.getTimestamp() <= expires) {
					logger.debug(
							"the session has been removed by sessionId {} from sessionMap",
							entry.getKey());
					iter.remove();
					flowStat.setSessionExpired(flowStat.getSessionExpired() + 1);
				}
			}
		}
	}

	@Scheduled(fixedDelay = MAX_WAITING_EXPIRES, initialDelay = MAX_WAITING_EXPIRES)
	@Override
	public synchronized void doWaitingExpires() {
		long expires = System.currentTimeMillis() - MAX_WAITING_EXPIRES;

		for (FlowStat flowStat : flowStatMap.values()) {
			Map<String, WaitingInfo> waitingMap = flowStat.getWaitingMap();
			Iterator<Entry<String, WaitingInfo>> iter = waitingMap.entrySet()
					.iterator();
			while (iter.hasNext()) {
				Entry<String, WaitingInfo> entry = iter.next();
				if (entry.getValue().getTimestamp() <= expires) {
					logger.debug(
							"the session has been removed by sessionId {} from waitingMap",
							entry.getKey());
					iter.remove();
					flowStat.setWaitingExpired(flowStat.getWaitingExpired() + 1);
				}
			}

			if (flowStat.getWaitingMap().isEmpty()
					&& flowStat.getExpireAt() > 0
					&& flowStat.getExpireAt() <= System.currentTimeMillis()) {
				flowStat.setExpireAt(0);
				flowStat.setProcessed(0);
				flowStat.setMaxConcurrency(DFLT_CONCURRENCY);
			}
		}
	}

	@Scheduled(fixedDelay = MAX_READY_EXPIRES, initialDelay = MAX_READY_EXPIRES)
	@Override
	public synchronized void doReadyExpires() {
		long expires = System.currentTimeMillis() - MAX_READY_EXPIRES;
		Iterator<Entry<String, Long>> iter = readyMap.entrySet().iterator();
		while (iter.hasNext()) {
			Entry<String, Long> entry = iter.next();
			if (entry.getValue() <= expires) {
				logger.debug(
						"the session has been removed by sessionId {} from readyMap",
						entry.getKey());
				iter.remove();
			}
		}
	}

}

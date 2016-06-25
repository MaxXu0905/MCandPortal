package com.ailk.sets.common;

import java.io.Serializable;

public class SchoolAnswerQuestion implements Serializable {
	private static final long serialVersionUID = -6549252464671565699L;
	private Long question_id;
	  private Integer partSeq;
	  private SchoolAnswerInfo answer;
   public Long getQuestion_id() {
		return question_id;
	}

	public void setQuestion_id(Long question_id) {
		this.question_id = question_id;
	}

	public Integer getPartSeq() {
		return partSeq;
	}

	public void setPartSeq(Integer partSeq) {
		this.partSeq = partSeq;
	}

	public SchoolAnswerInfo getAnswer() {
		return answer;
	}

	public void setAnswer(SchoolAnswerInfo answer) {
		this.answer = answer;
	}

}

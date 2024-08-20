package com.ssafy.shinhanflow.entity;

import java.lang.reflect.Member;
import java.util.concurrent.Flow;

import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.ManyToOne;
import jakarta.validation.constraints.NotNull;

public class MemberFlowEntity {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@ManyToOne
	@NotNull
	@JoinColumn(name = "flow_id")
	private FlowEntity flowId;


	@ManyToOne
	@NotNull
	@JoinColumn(name = "user_id")
	private MemberEntity memberId;
}

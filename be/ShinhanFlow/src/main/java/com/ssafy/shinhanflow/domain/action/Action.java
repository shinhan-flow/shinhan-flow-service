package com.ssafy.shinhanflow.domain.action;

/**
 * Action interface
 * 모든 Action 클래스는 이 인터페이스를 구현해야 한다.
 * Action 클래스는 execute 메소드를 구현해야 한다.
 */
public interface Action {
	/**
	 * Action을 실행하는 메소드
	 * @return Action이 성공적으로 실행되었는지 여부
	 */
	boolean execute();
}

package com.ssafy.shinhanflow.trigger;

/**
 * Trigger interface
 * 모든 Trigger 클래스는 이 인터페이스를 구현해야 한다.
 * Trigger 클래스는 isTriggered 메소드를 구현해야 한다.
 */
public interface Trigger {
    /**
     * Trigger가 발생했는지 확인하는 메소드
     * @return Trigger가 발생했는지 여부
     */
    boolean isTriggered();
}

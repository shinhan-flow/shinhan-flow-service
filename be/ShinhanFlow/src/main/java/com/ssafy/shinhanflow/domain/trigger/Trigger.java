package com.ssafy.shinhanflow.domain.trigger;

import java.lang.reflect.Field;

import com.ssafy.shinhanflow.config.error.exception.BadRequestException;

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

	// 공통 toString() 로직을 인터페이스에 포함
	default String toJson() {
		StringBuilder jsonBuilder = new StringBuilder();
		jsonBuilder.append("{");

		Field[] fields = this.getClass().getDeclaredFields();
		for (int i = 0; i < fields.length; i++) {
			fields[i].setAccessible(true); // private 필드 접근 가능하도록 설정
			try {
				String key = fields[i].getName();
				Object value = fields[i].get(this);

				jsonBuilder.append("\"").append(key).append("\": ");

				if (value instanceof String) {
					jsonBuilder.append("\"").append(value).append("\"");
				} else {
					jsonBuilder.append(value);
				}

				if (i < fields.length - 1) {
					jsonBuilder.append(", ");
				}
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			}
		}
		jsonBuilder.append("}");
		return jsonBuilder.toString();
	}

}


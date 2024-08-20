package com.ssafy.shinhanflow.entity;

import java.time.LocalDateTime;

import org.hibernate.annotations.ColumnDefault;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotNull;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Table(name = "member")
@Entity
public class MemberEntity {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@NotNull
	@Column(name = "email", length = 50, unique = true)
	private String email;

	@NotNull
	@Column(name = "password", length = 255)
	private String password;

	@NotNull
	@Column(name = "name", length = 15)
	private String name;

	@NotNull
	@Column(name = "user_key", length = 100, unique = true)
	private String userKey;

	@ColumnDefault("00100")
	@NotNull
	@Column(name = "institution_code", length = 20, insertable = false)
	private String institutionCode;

	@ColumnDefault("CURRENT_TIMESTAMP")
	@NotNull
	@Column(name = "created_at", insertable = false, updatable = false, columnDefinition = "TIMESTAMP")
	private LocalDateTime createdAt;

	@ColumnDefault("CURRENT_TIMESTAMP")
	@NotNull
	@Column(name = "updated_at", insertable = false, columnDefinition = "TIMESTAMP")
	private LocalDateTime updatedAt;

	@ColumnDefault("NULL")
	@Column(name = "deleted_at", insertable = false)
	private LocalDateTime deletedAt;

	@Builder
	public MemberEntity(String email, String password, String name, String userKey) {
		this.email = email;
		this.password = password;
		this.name = name;
		this.userKey = userKey;
	}

}

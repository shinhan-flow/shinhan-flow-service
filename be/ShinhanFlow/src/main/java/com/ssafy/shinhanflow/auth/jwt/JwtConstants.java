package com.ssafy.shinhanflow.auth.jwt;

public class JwtConstants {

    // Access Token 만료 시간
    public static final long ACCESS_TOKEN_EXPIRE_TIME = 300 * 1000L; // 30초

    // Refresh Token 만료 시간
    public static final long REFRESH_TOKEN_EXPIRE_TIME = 6000 * 1000L; // 1분
}

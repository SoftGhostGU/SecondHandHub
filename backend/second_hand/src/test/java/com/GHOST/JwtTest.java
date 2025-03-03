package com.GHOST;

import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.interfaces.Claim;
import com.auth0.jwt.interfaces.DecodedJWT;
import org.junit.jupiter.api.Test;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

public class JwtTest {

//    @Test
    public void testGen() {
        Map<String, Object> claims = new HashMap<>();
        claims.put("id", 1);
        claims.put("name", "Jack");
        // 生成jwt
        String token = JWT.create()
                .withClaim("user", claims) // 添加载荷
                .withExpiresAt(new Date(System.currentTimeMillis() + 1000 * 60 * 60 * 12)) // 设置过期时间
                .sign(Algorithm.HMAC256("GHOST")); // 指定算法，配置密钥
        System.out.println(token);
    }

//    @Test
    public void testParse() {
        // 定义字符串，模拟用户传来的token
        String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9" +
                ".eyJ1c2VyIjp7Im5hbWUiOiJKYWNrIiwiaWQiOjF9LCJleHAiOjE3NDA4ODg0ODR9" +
                ".axJFksdAykDXeCVqDCygIXuw0q9QOVXJk5sIoUwKQpk";
        JWTVerifier jwtVerifier = JWT.require(Algorithm.HMAC256("GHOST")).build();

        // 验证token
        DecodedJWT decodedJWT = jwtVerifier.verify(token); // 生成一个解析后的token对象
        Map<String, Claim> claims = decodedJWT.getClaims();
        System.out.println(claims.get("user"));
        // 如果篡改了token，验证会失败，抛出异常
        // 如果篡改了密钥，验证会失败，抛出异常
        // 如果token过期，验证会失败，抛出异常
    }
}

package com.GHOST.controller;

import com.GHOST.pojo.Result;
import com.GHOST.pojo.User;
import com.GHOST.service.UserService;
import jakarta.validation.constraints.Pattern;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/user")
@Validated
public class UserController {

    @Autowired
    private UserService userService;

    @PostMapping("/register")
    public Result register(@Pattern(regexp = "^\\S{5,20}$") String username, @Pattern(regexp = "^\\S{5,32}$") String password){
        // 查询用户
        User u = userService.findByUsername(username);
        if (u == null) {
            // 注册用户
            userService.register(username, password);
            return Result.success();
        } else {
            return Result.error("用户名已存在");
        }
    }
}

package com.GHOST.controller;

import com.GHOST.pojo.Result;
import com.GHOST.pojo.User;
import com.GHOST.service.UserService;
import com.GHOST.utils.JwtUtil;
import com.GHOST.utils.MD5Utils;
import com.GHOST.utils.ThreadLocalUtil;
import jakarta.validation.constraints.Pattern;
import org.hibernate.validator.constraints.URL;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

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

    @PostMapping("/login")
    public Result<String> login(@Pattern(regexp = "^\\S{5,20}$") String username, @Pattern(regexp = "^\\S{5,32}$") String password) {
        // 登录用户
        User u = userService.findByUsername(username);
        if (u == null) {
            return Result.error("用户不存在");
        } else if (MD5Utils.passwordIsTrue(password, u.getPassword())) {
            Map<String, Object> claims = new HashMap<>();
            claims.put("id", u.getId());
            claims.put("username", u.getUsername());
            String token = JwtUtil.genToken(claims);
            return Result.success(token);
        } else {
            return Result.error("密码错误");
        }
    }

    @GetMapping("/userInfo")
    public Result<User> userInfo() {
        // 获取用户信息
        Map<String, Object> map = ThreadLocalUtil.get();
        String username = (String) map.get("username");

        User user = userService.findByUsername(username);
        return Result.success(user);
    }

    @PutMapping("/update")
    public Result update(@RequestBody @Validated User user) {
        // 更新用户信息
        userService.update(user);
        return Result.success();
    }

    @PatchMapping("/updateAvatar")
    public Result updateAvatar(@RequestParam @URL String avatarUrl) {
        userService.updateAvatar(avatarUrl);
        return Result.success();
    }

    @PatchMapping("/updatePwd")
    public Result updatePwd(@RequestBody Map<String, String> params) {
        String oldPwd = params.get("old_pwd");
        String newPwd = params.get("new_pwd");
        String rePwd = params.get("re_pwd");

        // 验证没有缺少参数
        if (!StringUtils.hasLength(oldPwd) || !StringUtils.hasLength(newPwd) || !StringUtils.hasLength(rePwd)) {
            return Result.error("缺少必要参数");
        }

        // 验证原密码是否正确
        Map<String, Object> map = ThreadLocalUtil.get();
        String username = (String) map.get("username");
        User loginUser = userService.findByUsername(username);

        if (!loginUser.getPassword().equals(MD5Utils.string2MD5(oldPwd))) {
            return Result.error("原密码错误");
        }

        // 验证新密码是否符合要求
        if (!rePwd.equals(newPwd)) {
            return Result.error("两次密码输入不一致");
        }

        // 更新密码
        userService.updatePwd(newPwd);
        return Result.success();
    }
}

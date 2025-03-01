package com.GHOST.service.impl;

import com.GHOST.mapper.UserMapper;
import com.GHOST.pojo.User;
import com.GHOST.service.UserService;
import com.GHOST.utils.MD5Utils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    @Override
    public User findByUsername(String username) {
        User u = userMapper.findByUsername(username);
        return u;
    }

    @Override
    public void register(String username, String password) {
        // 加密处理
        String md5String = MD5Utils.string2MD5(password);
        // 添加
        userMapper.add(username, md5String);
    }
}

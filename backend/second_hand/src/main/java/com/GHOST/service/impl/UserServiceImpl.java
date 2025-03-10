package com.GHOST.service.impl;

import com.GHOST.mapper.UserMapper;
import com.GHOST.pojo.User;
import com.GHOST.service.UserService;
import com.GHOST.utils.MD5Utils;
import com.GHOST.utils.ThreadLocalUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.Map;

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
    public void register(String username, String password, String email) {
        // 加密处理
        String md5String = MD5Utils.string2MD5(password);
        // 添加
        userMapper.add(username, md5String, email);
    }

    @Override
    public void update(User user) {
        user.setUpdateTime(LocalDateTime.now());
        userMapper.update(user);
    }

    @Override
    public void updateAvatar(String avatarUrl) {
        Map<String, Object> map = ThreadLocalUtil.get();
        Integer id = (Integer) map.get("id");
        userMapper.updateAvatar(avatarUrl, id);
    }

    @Override
    public void updatePwd(String newPwd) {
        Map<String, Object> map = ThreadLocalUtil.get();
        Integer id = (Integer) map.get("id");
        userMapper.updatePwd(MD5Utils.string2MD5(newPwd), id);
    }

    @Override
    public User findById(Integer id) {
        return userMapper.findById(id);
    }
}

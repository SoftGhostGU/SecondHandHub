package com.GHOST.service;

import com.GHOST.pojo.User;

public interface UserService {
    User findByUsername(String username);

    void register(String username, String password, String email);

    void update(User user);

    void updateAvatar(String avatarUrl);

    void updatePwd(String newPwd);

    User findById(Integer id);
}

package com.GHOST.service;

import com.GHOST.pojo.User;

public interface UserService {
    User findByUsername(String username);

    void register(String username, String password);
}

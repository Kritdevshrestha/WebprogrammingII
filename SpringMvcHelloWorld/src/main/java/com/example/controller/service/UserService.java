package com.example.controller.service;

import com.example.controller.model.User;

public interface UserService {
    void registerUser(User user);
    User login(String name, String password);
}

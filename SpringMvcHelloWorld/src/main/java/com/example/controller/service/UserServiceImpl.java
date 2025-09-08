package com.example.controller.service;

import com.example.controller.model.User;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    private final List<User> users = new ArrayList<>();

    @Override
    public void registerUser(User user) {
        users.add(user);
    }

    @Override
    public User login(String name, String password) {
        return users.stream()
                .filter(u -> u.getName().equals(name) && u.getPassword().equals(password))
                .findFirst()
                .orElse(null);
    }
}

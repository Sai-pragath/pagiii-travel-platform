package com.pagiii.service;

import org.springframework.web.servlet.ModelAndView;

import com.pagiii.entity.User;


public interface UserService {
    ModelAndView saveUser(User user);
    User authenticate(String userName, String password);
}

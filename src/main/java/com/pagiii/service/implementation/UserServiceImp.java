package com.pagiii.service.implementation;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.pagiii.entity.User;
import com.pagiii.repository.UserRepository;
import com.pagiii.service.UserService;

@Service
public class UserServiceImp implements UserService {

    @Autowired
    private UserRepository userRepository;

    @Override
    public ModelAndView saveUser(User user) {
        userRepository.save(user);
        return new ModelAndView("redirect:/login");
    }

    @Override
    public User authenticate(String userName, String password) {
        return userRepository.findByUserNameAndPassword(userName, password);
    }
    
}

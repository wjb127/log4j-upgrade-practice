package com.example.controller;

import com.example.service.UserService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    private static final Logger logger = Logger.getLogger(HomeController.class);

    @Autowired
    private UserService userService;

    @GetMapping("/")
    public String home(Model model) {
        logger.info("홈 페이지 요청");
        
        long totalUsers = userService.getTotalCount();
        model.addAttribute("totalUsers", totalUsers);
        
        logger.debug("홈 페이지 데이터 준비 완료 - 전체 사용자: " + totalUsers);
        return "home";
    }

    @GetMapping("/about")
    public String about() {
        logger.info("소개 페이지 요청");
        return "about";
    }
} 
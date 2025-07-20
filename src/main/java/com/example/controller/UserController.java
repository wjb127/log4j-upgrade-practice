package com.example.controller;

import com.example.model.User;
import com.example.service.UserService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/users")
public class UserController {

    private static final Logger logger = Logger.getLogger(UserController.class);

    @Autowired
    private UserService userService;

    @GetMapping
    public String listUsers(Model model) {
        logger.info("사용자 목록 페이지 요청");
        
        List<User> users = userService.findAll();
        long totalCount = userService.getTotalCount();
        
        model.addAttribute("users", users);
        model.addAttribute("totalCount", totalCount);
        
        logger.debug("사용자 목록 페이지 데이터 준비 완료: " + users.size() + "명");
        return "users/list";
    }

    @GetMapping("/new")
    public String newUserForm(Model model) {
        logger.info("새 사용자 등록 폼 요청");
        model.addAttribute("user", new User());
        return "users/form";
    }

    @PostMapping
    public String createUser(@ModelAttribute User user, RedirectAttributes redirectAttributes) {
        logger.info("새 사용자 생성 요청: " + user.getUsername());
        
        try {
            User savedUser = userService.save(user);
            redirectAttributes.addFlashAttribute("successMessage", 
                "사용자가 성공적으로 생성되었습니다: " + savedUser.getUsername());
            logger.info("사용자 생성 성공: " + savedUser.getId());
            return "redirect:/users";
        } catch (Exception e) {
            logger.error("사용자 생성 실패: " + e.getMessage(), e);
            redirectAttributes.addFlashAttribute("errorMessage", 
                "사용자 생성에 실패했습니다: " + e.getMessage());
            return "redirect:/users/new";
        }
    }

    @GetMapping("/{id}")
    public String viewUser(@PathVariable Long id, Model model) {
        logger.info("사용자 상세 보기 요청: ID=" + id);
        
        User user = userService.findById(id);
        if (user == null) {
            logger.warn("사용자를 찾을 수 없음: ID=" + id);
            return "redirect:/users";
        }
        
        model.addAttribute("user", user);
        return "users/view";
    }

    @GetMapping("/{id}/edit")
    public String editUserForm(@PathVariable Long id, Model model) {
        logger.info("사용자 수정 폼 요청: ID=" + id);
        
        User user = userService.findById(id);
        if (user == null) {
            logger.warn("수정할 사용자를 찾을 수 없음: ID=" + id);
            return "redirect:/users";
        }
        
        model.addAttribute("user", user);
        return "users/edit";
    }

    @PostMapping("/{id}")
    public String updateUser(@PathVariable Long id, @ModelAttribute User user, 
                           RedirectAttributes redirectAttributes) {
        logger.info("사용자 정보 업데이트 요청: ID=" + id);
        
        try {
            User updatedUser = userService.updateUser(id, user);
            redirectAttributes.addFlashAttribute("successMessage", 
                "사용자 정보가 성공적으로 업데이트되었습니다: " + updatedUser.getUsername());
            logger.info("사용자 업데이트 성공: " + updatedUser.getId());
            return "redirect:/users/" + id;
        } catch (Exception e) {
            logger.error("사용자 업데이트 실패: " + e.getMessage(), e);
            redirectAttributes.addFlashAttribute("errorMessage", 
                "사용자 정보 업데이트에 실패했습니다: " + e.getMessage());
            return "redirect:/users/" + id + "/edit";
        }
    }

    @PostMapping("/{id}/delete")
    public String deleteUser(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        logger.info("사용자 삭제 요청: ID=" + id);
        
        try {
            userService.deleteById(id);
            redirectAttributes.addFlashAttribute("successMessage", 
                "사용자가 성공적으로 삭제되었습니다.");
            logger.info("사용자 삭제 성공: ID=" + id);
        } catch (Exception e) {
            logger.error("사용자 삭제 실패: " + e.getMessage(), e);
            redirectAttributes.addFlashAttribute("errorMessage", 
                "사용자 삭제에 실패했습니다: " + e.getMessage());
        }
        
        return "redirect:/users";
    }
} 
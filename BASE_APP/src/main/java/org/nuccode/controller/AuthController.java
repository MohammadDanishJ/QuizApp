package org.nuccode.controller;

import org.nuccode.dao.entity.User;
import org.nuccode.dao.entity.UserRole;
import org.nuccode.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;


@EnableTransactionManagement
@Transactional
@Controller
public class AuthController {
    @Autowired
    UserService userService;

    @GetMapping("/login")
    public String showLoginForm(Model model) {
        model.addAttribute("employee", new User());
        return "login";
    }

    @GetMapping("/register")
    public String showRegisterForm(Model model) {
        model.addAttribute("employee", new User());
        return "register";
    }

    @PostMapping("/register")
    public String registerUser(@ModelAttribute("employee") User user) {
        user.setRole(new UserRole(user, "ROLE_CANDIDATE"));
        userService.registerUser(user);
        return "register";
    }

    @RequestMapping("/accessDenied")
    public String accessDenied() {
        return "accessDenied";
    }

    @GetMapping("/createAdmin")
    @ResponseBody
    public User createAdmins() {
        User admin = new User();
        admin.setUsername("admin");
        admin.setPassword("admin123");
        admin.setEnabled(true);
        admin.setRole(new UserRole(admin, "ROLE_ADMIN"));

        userService.registerUser(admin);
        return admin;
    }

    @GetMapping("/createCandidate")
    @ResponseBody
    public List<User> createCandidate() {
        List<User> users = new ArrayList<>();

        for (int i = 1; i <= 10; i++) {
            User user = new User();
            user.setUsername("user"+i);
            user.setPassword("user123");
            user.setEnabled(true);
            user.setRole(new UserRole(user, "ROLE_CANDIDATE"));

            userService.registerUser(user);
            users.add(user);
        }

        return users;
    }

    @GetMapping("/logout")
    public String logout() {
        SecurityContextHolder.getContext().setAuthentication(null);
        return "redirect:/login?logout";
    }

}

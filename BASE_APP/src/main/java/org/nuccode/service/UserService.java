package org.nuccode.service;

import org.nuccode.dao.entity.User;
import org.nuccode.dao.layers.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService implements UserDetailsService {
    @Autowired
    UserRepository userRepository;

    @Autowired
    PasswordEncoder passwordEncoder;

    @Override
    public UserDetails loadUserByUsername(String s) throws UsernameNotFoundException {
        User user = userRepository.findByUsername(s);
        if (user == null) throw new UsernameNotFoundException("Invalid user or Password");
        return user;
    }

    public void registerUser(User user) {
        if (userRepository.findByUsername(user.getUsername()) != null)
            throw new IllegalArgumentException("Username Already exists");

        /*
        * Encode password
        * MANDATORY
        * */
        user.setPassword(passwordEncoder.encode(user.getPassword()));

        /* ROLE IS HARD CODED, MUST BE DYNAMIC */
        user.setRole(user.getRole());
        user.setEnabled(true);

//        employee.setEnabled(true);
        userRepository.save(user);
    }

    public List<User> getAllUsers(){
        return userRepository.getAllUsers();
    }

    public List<User> getUsersByIds(List<Long> ids){
        return userRepository.getUsersByIds(ids);
    }

    public void update(User user){
        userRepository.update(user);
    }
}

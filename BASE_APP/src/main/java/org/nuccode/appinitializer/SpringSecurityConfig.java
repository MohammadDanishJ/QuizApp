package org.nuccode.appinitializer;

import org.nuccode.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import javax.sql.DataSource;

@Component
@EnableWebSecurity
public class SpringSecurityConfig extends WebSecurityConfigurerAdapter {

    @Autowired
    DataSource dataSource;

    @Autowired
    SuccessHandler successHandler;

    @Autowired
    UserService userService;

    @Override
    public void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.jdbcAuthentication()
                .dataSource(dataSource)
                .usersByUsernameQuery("SELECT e.username, e.password, e.enabled FROM org_nucCode_user e WHERE e.username=?")
                .authoritiesByUsernameQuery("SELECT e.username, er.role FROM org_nucCode_user e JOIN org_nucCode_user_roles er ON e.user_id = er.user_id WHERE e.username=?")
                .passwordEncoder(passwordEncoder());
                /*.and()
                .inMemoryAuthentication()
                .withUser("admin").password("{noop}admin123").roles("ADMIN")
                .and()
                .withUser("user").password("{noop}user123").roles("CANDIDATE")*/;
    }

    /*@Bean
    @Override
    public UserDetailsService userDetailsServiceBean() throws Exception {
        InMemoryUserDetailsManager manager = new InMemoryUserDetailsManager();
        manager.createUser(User.withUsername("admin").password("{noop}admin123").roles("ADMIN").build());
        manager.createUser(User.withUsername("user1").password("{noop}user123").roles("CANDIDATE").build());
        manager.createUser(User.withUsername("user2").password("{noop}user123").roles("CANDIDATE").build());

//        manager.createUser(User.withUsername("admin2").password(passwordEncoder().encode("admin123")).roles("ADMIN").build());
        return manager;
    }*/

    @Override
    public void configure(HttpSecurity http) throws Exception {
        http.authorizeRequests()
                .antMatchers("/register").permitAll()
                .antMatchers("/a/**").hasRole("ADMIN") /* a => Admin*/
                .antMatchers("/c/**").hasRole("CANDIDATE") /* c => Candidate*/
                .and()
                .formLogin().loginPage("/login").successHandler(successHandler)
                .and()
                .logout().logoutSuccessUrl("/").invalidateHttpSession(true)
                .and()
                .exceptionHandling().accessDeniedPage(
                        "/accessDenied");
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}



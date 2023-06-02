package org.nuccode.dao.layers;

import org.nuccode.dao.entity.User;
import org.springframework.data.repository.Repository;

import java.util.List;

public interface UserRepository extends Repository<User, Long> {
    User findByUsername(String username);
    void save(User user);
    User findById(Long id);
    void delete(User user);
    void update(User user);
    List<User> getAllUsers();
    List<User> getUsersByIds(List<Long> ids);
}

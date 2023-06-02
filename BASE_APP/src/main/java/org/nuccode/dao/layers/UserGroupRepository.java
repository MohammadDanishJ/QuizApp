package org.nuccode.dao.layers;

import org.nuccode.dao.entity.User;
import org.nuccode.dao.entity.UserGroup;
import org.springframework.data.repository.Repository;

import java.util.List;

public interface UserGroupRepository {
    void createGroup(UserGroup group);
    List<UserGroup> getAllGroups();
}

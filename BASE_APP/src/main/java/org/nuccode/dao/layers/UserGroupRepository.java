package org.nuccode.dao.layers;

import org.nuccode.dao.entity.UserGroup;

import java.util.List;

public interface UserGroupRepository {
    void createGroup(UserGroup group);
    List<UserGroup> getAllGroups();
}

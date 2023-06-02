package org.nuccode.service;

import org.nuccode.dao.entity.UserGroup;
import org.nuccode.dao.layers.UserGroupRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserGroupService {
    @Autowired
    UserGroupRepository userGroupRepository;

    public void createGroup(UserGroup group){
        userGroupRepository.createGroup(group);
    }

    public List<UserGroup> getAllGroups(){
        return userGroupRepository.getAllGroups();
    }
}

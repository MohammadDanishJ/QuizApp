package org.nuccode.dao.implementations;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.nuccode.dao.entity.User;
import org.nuccode.dao.entity.UserGroup;
import org.nuccode.dao.layers.UserGroupRepository;
import org.nuccode.dao.layers.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class UserGroupRepositoryImpl implements UserGroupRepository {

    private final SessionFactory sessionFactory;

    @Autowired
    public UserGroupRepositoryImpl(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    private Session getSession() {
        return sessionFactory.getCurrentSession();
    }


    @Override
    public void createGroup(UserGroup group) {
        getSession().save(group);
    }

    @Override
    public List<UserGroup> getAllGroups() {
        return getSession().createQuery("from UserGroup", UserGroup.class).getResultList();
    }
}

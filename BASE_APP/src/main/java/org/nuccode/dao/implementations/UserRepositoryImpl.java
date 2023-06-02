package org.nuccode.dao.implementations;

import org.hibernate.SessionFactory;
import org.nuccode.dao.entity.User;
import org.nuccode.dao.layers.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import org.hibernate.Session;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.util.List;

@Repository
public class UserRepositoryImpl implements UserRepository {

    private final SessionFactory sessionFactory;

    @Autowired
    public UserRepositoryImpl(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    private Session getSession() {
        return sessionFactory.getCurrentSession();
    }

    @Override
    public User findByUsername(String username) {
        return getSession().createQuery("FROM User WHERE username = :username", User.class)
                .setParameter("username", username)
                .uniqueResult();
    }

    @Override
    public void save(User user) {
        getSession().save(user);
    }

    @Override
    public User findById(Long id) {
        return getSession().get(User.class, id);
    }

    @Override
    public void delete(User user) {
        getSession().delete(user);
    }

    @Override
    public void update(User user) {
        getSession().update(user);
    }

    @Override
    public List<User> getAllUsers() {
        return getSession().createQuery("from User", User.class).getResultList();
    }

    @Override
    public List<User> getUsersByIds(List<Long> ids) {
        // Create a Hibernate Session
        Session session = sessionFactory.getCurrentSession();

        // Create a CriteriaBuilder
        CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();

        // Create a CriteriaQuery for the User entity
        CriteriaQuery<User> criteriaQuery = criteriaBuilder.createQuery(User.class);

        // Specify the root entity and join to any related entities if needed
        Root<User> root = criteriaQuery.from(User.class);

        // Create a Predicate to filter by user IDs
        Predicate predicate = root.get("id").in(ids);

        // Add the Predicate to the CriteriaQuery
        criteriaQuery.where(predicate);

        // Execute the query and return the result as a list of users
        List<User> users = session.createQuery(criteriaQuery).getResultList();
        return users;
    }
}

package org.nuccode.dao.implementations;

import org.hibernate.SessionFactory;
import org.nuccode.dao.entity.TestSubmission;
import org.nuccode.dao.layers.TestSubmissionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class TestSubmissionRepositoryImpl implements TestSubmissionRepository {
    @Autowired
    SessionFactory sessionFactory;
    @Override
    public TestSubmission getTestSubmissionById(Long id) {
        System.out.println("Inside repository: "+id);
        System.out.println(sessionFactory.getCurrentSession().get(TestSubmission.class, id));
        return sessionFactory.getCurrentSession().get(TestSubmission.class, id);
    }

    @Override
    public List<TestSubmission> getAllTestSubmissionsByTestId(Long id) {
        return sessionFactory.getCurrentSession().createQuery("from TestSubmission WHERE testDetails.id=:testId", TestSubmission.class).setParameter("testId", id).getResultList();
    }
}

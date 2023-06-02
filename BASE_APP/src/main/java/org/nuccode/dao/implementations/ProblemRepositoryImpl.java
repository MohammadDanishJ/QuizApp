package org.nuccode.dao.implementations;

import org.hibernate.SessionFactory;
import org.nuccode.dao.entity.*;
import org.nuccode.dao.layers.ProblemRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ProblemRepositoryImpl implements ProblemRepository {
    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public Problem getProblemById(Long problemId) {
        return sessionFactory.getCurrentSession().get(Problem.class, problemId);
    }

    @Override
    public void createProblem(Problem problem) {
        sessionFactory.getCurrentSession().save(problem);
    }

    @Override
    public void submitSolution(ProblemSubmission problemSubmission) {
        sessionFactory.getCurrentSession().save(problemSubmission);
    }

    @Override
    public void createTest(TestDetails testDetails) {
        sessionFactory.getCurrentSession().save(testDetails);
    }

    @Override
    public List<TestDetails> getAllTestDetails() {
        return sessionFactory.getCurrentSession().createQuery("from TestDetails", TestDetails.class).getResultList();
    }

    @Override
    public List<TestDetails> getAllUnattemptedTestDetails(User e) {
        String query = "SELECT td FROM TestDetails td WHERE td.id NOT IN (SELECT ts.testDetails.id FROM TestSubmission ts WHERE ts.user.id = :userId )";
        return sessionFactory.getCurrentSession().createQuery(query, TestDetails.class).setParameter("userId", e.getId()).getResultList();
    }

    @Override
    public List<TestDetails> getAllAttemptedTestDetails(User e) {
        String query = "SELECT td FROM TestDetails td WHERE td.id IN (SELECT ts.testDetails.id FROM TestSubmission ts WHERE ts.user.id = :userId )";
        return sessionFactory.getCurrentSession().createQuery(query, TestDetails.class).setParameter("userId", e.getId()).getResultList();

    }

    @Override
    public TestDetails getTestDetailsById(Long id) {
        return sessionFactory.getCurrentSession().get(TestDetails.class, id);
    }

    @Override
    public Long uploadTestSubmission(TestSubmission testSubmission) {
        return (Long) sessionFactory.getCurrentSession().save(testSubmission);
    }

}

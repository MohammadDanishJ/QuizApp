package org.nuccode.dao.implementations;

import org.hibernate.SessionFactory;
import org.nuccode.dao.entity.Problem;
import org.nuccode.dao.entity.ProblemSubmission;
import org.nuccode.dao.layers.ProblemRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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
}

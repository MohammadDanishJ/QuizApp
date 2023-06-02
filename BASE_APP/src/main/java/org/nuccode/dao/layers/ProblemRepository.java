package org.nuccode.dao.layers;

import org.nuccode.dao.entity.*;

import java.util.List;

public interface ProblemRepository {
    Problem getProblemById(Long problemId);
    void createProblem(Problem problem);
    void submitSolution(ProblemSubmission problemSubmission);
    void createTest(TestDetails testDetails);
    List<TestDetails> getAllTestDetails();
    List<TestDetails> getAllUnattemptedTestDetails(User e);
    List<TestDetails> getAllAttemptedTestDetails(User e);
    TestDetails getTestDetailsById(Long id);
    Long uploadTestSubmission(TestSubmission testSubmission);
}

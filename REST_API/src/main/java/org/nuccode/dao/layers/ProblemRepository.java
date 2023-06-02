package org.nuccode.dao.layers;

import org.nuccode.dao.entity.Problem;
import org.nuccode.dao.entity.ProblemSubmission;

public interface ProblemRepository {
    Problem getProblemById(Long problemId);
    void createProblem(Problem problem);
    void submitSolution(ProblemSubmission problemSubmission);
}

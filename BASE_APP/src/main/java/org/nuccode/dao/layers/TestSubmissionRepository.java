package org.nuccode.dao.layers;

import org.nuccode.dao.entity.*;

import java.util.List;

public interface TestSubmissionRepository {
    TestSubmission getTestSubmissionById(Long id);
    List<TestSubmission> getAllTestSubmissionsByTestId(Long id);
}

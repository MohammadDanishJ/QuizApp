package org.nuccode.service;

import org.nuccode.dao.entity.TestSubmission;
import org.nuccode.dao.layers.TestSubmissionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class TestSubmissionService {
    @Autowired
    TestSubmissionRepository testSubmissionRepository;
    public TestSubmission getTestSubmissionById(Long id){
        System.out.println("inside Test service: "+id);
        return testSubmissionRepository.getTestSubmissionById(id);
    }

    public List<TestSubmission> getAllTestSubmissionsByTestId(Long id){
        return testSubmissionRepository.getAllTestSubmissionsByTestId(id);
    }
}

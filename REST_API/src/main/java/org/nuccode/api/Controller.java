package org.nuccode.api;

import org.nuccode.dao.entity.Problem;
import org.nuccode.dao.entity.ProblemSubmission;
import org.nuccode.dao.entity.TestCase;
import org.nuccode.dao.entity.TestDetails;
import org.nuccode.dao.layers.ProblemRepository;
import org.nuccode.service.CodeMatcherService;
import org.nuccode.service.Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@EnableTransactionManagement
@Transactional
@RestController
@RequestMapping("/api")
@CrossOrigin(origins = "http://localhost:8013")
public class Controller {
    @Autowired
    Service service;
    @Autowired
    CodeMatcherService codeMatcherService;
    @Autowired
    ProblemRepository problemRepository;

    /* Test Route */
    @ResponseBody
    @GetMapping("/test")
    public String test() {
        return "API is Up";
    }

    @ResponseBody
    @PostMapping("/codeCapture")
    public String handleCodeCaptureEvent(@ModelAttribute ProblemSubmission problemSubmission) {
        if(problemSubmission.getCodeSnippet() == null || problemSubmission.getCodeSnippet().trim().isEmpty())
            return "No Code Provided";

        /*if (codeMatcherService.matchTestCases(problemSubmission))
            return "success";*/

        return codeMatcherService.executeProblem(problemSubmission);
    }

    @ResponseBody
    @GetMapping("/uploadQuestion")
    public boolean uploadQuestion() {
        /* Generate Problem sets */
        Problem problem = new Problem();

        problem.setTitle("Hello World");
        problem.setDescription("Sample Problem");

        List<TestCase> testCases = new ArrayList<>();

        TestCase testCase1 = new TestCase();
        testCase1.setOutput("Hello World");
        testCase1.setProblem(problem);

        TestCase testCase2 = new TestCase();
        testCase2.setOutput("Hello World1");
        testCase2.setProblem(problem);

        testCases.add(testCase1);
        testCases.add(testCase2);

        problem.setTestCases(testCases);




        /**/
        /**/
        /**/
        /* Generate Problem sets */
        Problem problem2 = new Problem();

        problem2.setTitle("Hello World 1");
        problem2.setDescription("Sample Problem 1");

        List<TestCase> testCases1 = new ArrayList<>();

        TestCase testCase3 = new TestCase();
        testCase3.setOutput("Hello World 1");
        testCase3.setProblem(problem2);

        TestCase testCase4 = new TestCase();
        testCase4.setOutput("Hello World 2");
        testCase4.setProblem(problem2);

        testCases1.add(testCase3);
        testCases1.add(testCase4);

        problem2.setTestCases(testCases1);

        try {

            problemRepository.createProblem(problem);
            problemRepository.createProblem(problem2);
            return true;
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return false;
        }

    }

    @ResponseBody
    @PostMapping("/addProblem")
    public boolean addProblem(@ModelAttribute Problem problem) {
        /* Map problem with each test case */
        problem.getTestCases().forEach(testCase -> testCase.setProblem(problem));

        try{
            /* add problem along with test cases to DB*/
            problemRepository.createProblem(problem);
            return true;
        }  catch (Exception e){
            System.out.println(e.getMessage());
            return false;
        }
    }

    @ResponseBody
    @PostMapping("/addTest")
    public boolean addTest(@ModelAttribute TestDetails testDetails) {
        System.out.println(testDetails);
        return true;
    }
}

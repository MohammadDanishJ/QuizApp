package org.nuccode.controller;

import org.nuccode.dao.entity.*;
import org.nuccode.dao.layers.ProblemRepository;
import org.nuccode.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

@EnableTransactionManagement
@Transactional
@Controller
public class RequestHandlerController {
    @Autowired
    Service service;
    @Autowired
    CodeMatcherService codeMatcherService;
    @Autowired
    ProblemRepository problemRepository;
    @Autowired
    UserService userService;
    @Autowired
    TestSubmissionService testSubmissionService;
    @Autowired
    UserGroupService userGroupService;

    @PostMapping("/c/codeCapture")
    public @ResponseBody String handleCodeCaptureEvent(@ModelAttribute ProblemSubmission problemSubmission) {
        if (problemSubmission.getCodeSnippet() == null || problemSubmission.getCodeSnippet().trim().isEmpty())
            return "No Code Provided";

        /*if (codeMatcherService.matchTestCases(problemSubmission))
            return "success";*/

        return codeMatcherService.executeProblem(problemSubmission);
    }

    /*
    * Handler for testSubmission by Candidate
    * */
    @PostMapping("/c/testSubmission")
    public String handleTestSubmissionEvent(@ModelAttribute TestSubmission testSubmission, Model model, RedirectAttributes redirectAttributes, Principal principal) {
        System.out.println(testSubmission);
        testSubmission.getProblemSubmissions().forEach(problemSubmission -> problemSubmission.setTestSubmission(testSubmission));
//        testSubmission.setTestDetails(testSubmission.getTestDetails());
        testSubmission.setUser((User) userService.loadUserByUsername(principal.getName()));

        try{
            redirectAttributes.addFlashAttribute("message", "Test Submitted Successfully");
            Long submissionId = codeMatcherService.validateTestSubmission(testSubmission);
            System.out.println("\n\n****\n");
            System.out.println(submissionId);
            System.out.println("\n\n****\n");
            return "redirect:/c/viewResult/"+submissionId;
        } catch (Exception e){
            model.addAttribute("error", e.getMessage());
            return "/viewTest/"+testSubmission.getTestDetails().getId();
        }
    }

    @GetMapping({"/c/viewResult/{submissionId}", "/a/viewResult/{submissionId}"})
    public String viewResult(@PathVariable("submissionId") Long submissionId, Model model){
        System.out.println("inside handler to open: "+submissionId);
        TestSubmission testSubmission = testSubmissionService.getTestSubmissionById(submissionId);
        System.out.println(testSubmission);
        System.out.println(testSubmission.getTestDetails());
        System.out.println(testSubmission.getTestDetails().getId());
        model.addAttribute("testDetails", problemRepository.getTestDetailsById(testSubmission.getTestDetails().getId()));
        model.addAttribute("testSubmission", testSubmission);
        return "viewResult";
    }

    @GetMapping("/a/uploadQuestion")
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

    @PostMapping("/a/addProblem")
    public boolean addProblem(@ModelAttribute Problem problem) {
        /* Map problem with each test case */
        problem.getTestCases().forEach(testCase -> testCase.setProblem(problem));

        try {
            /* add problem along with test cases to DB*/
            problemRepository.createProblem(problem);
            return true;
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return false;
        }
    }

    @PostMapping("/a/addTest")
    public String addTest(@ModelAttribute TestDetails testDetails, Model model, RedirectAttributes redirectAttributes) {
        System.out.println("*************");
        System.out.println(testDetails);
        System.out.println("*************\n\n\n\n");

        testDetails.getProblems().forEach(problem -> {
            /*
            * This filter should be more optimised
            *
            * This filter should remove invalid Problems or Testcases
            * */
            /* filter problems for null problems*/
            if (problem.getTitle() != null) {
                problem.setTestDetails(testDetails);
                problem.getTestCases().forEach(testCase -> {
                    /* filter testCases for null testCases*/
                    if (testCase.getOutput() != null)
                        testCase.setProblem(problem);
                });
            }
        });

        System.out.println("*************");
        System.out.println(testDetails);
        System.out.println("*************\n\n\n\n");

        try {
            /* add problem along with test cases to DB*/
            problemRepository.createTest(testDetails);
            redirectAttributes.addFlashAttribute("message", "Test Added Successfully");
            return "redirect:/a/dashboard";
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            return "addTest";
        }
    }

/*    @PostMapping("/a/groups/create")
    public String createGroup(@ModelAttribute("groupForm") org.nuccode.models.UserGroup groupForm) {
        // Create a new Group entity and populate it with form data
        UserGroup group = new UserGroup();
        group.setGroupName(groupForm.getGroupName());
        group.setGroupCode(groupForm.getGroupCode());

        // Retrieve the selected users and assign them to the group
        List<User> users = userService.getUsersByIds(groupForm.getUserIds());
        group.setUsers(users);

        // Save the group to the database
        userGroupService.createGroup(group);

        return "redirect:/a/groups"; // Redirect to the group list page
    }*/

    @PostMapping("/a/groups/create")
    public String createGroup(@ModelAttribute("groupForm") org.nuccode.models.UserGroup groupForm) {
        // Create a new Group entity and populate it with form data
        UserGroup group = new UserGroup();
        group.setGroupName(groupForm.getGroupName());
        group.setGroupCode(groupForm.getGroupCode());

        // Retrieve the selected users and assign them to the group
        List<User> users = userService.getUsersByIds(groupForm.getUserIds());
        System.out.println("users before add"+users);
        System.out.println("groups before add"+group);
        /*for (User user : users) {
            user.getGroups().add(group);
        }*/

        // Set the group for each user bidirectionally

        users.forEach(user -> {

            List<UserGroup> userGroups = user.getGroups();
            if(userGroups==null)
                userGroups = new ArrayList<>();

            userGroups.add(group);

            user.setGroups(user.getGroups());

            userService.update(user);
        });

        group.setUsers(users);

//        System.out.println("users after add"+users);
        System.out.println("groups after add"+group);

        // Save the group to the database
        userGroupService.createGroup(group);

        return "redirect:/a/groups"; // Redirect to the group list page
    }



}

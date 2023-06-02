package org.nuccode.controller;

import org.nuccode.dao.entity.User;
import org.nuccode.dao.layers.ProblemRepository;
import org.nuccode.models.Problem;
import org.nuccode.models.ProblemSubmission;
import org.nuccode.models.TestDetails;
import org.nuccode.models.UserGroup;
import org.nuccode.service.UserGroupService;
import org.nuccode.service.UserService;
import org.nuccode.service.TestSubmissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.security.Principal;
import java.util.List;

@EnableTransactionManagement
@Transactional
@org.springframework.stereotype.Controller
public class PageRedirectController {
    @Autowired
    ProblemRepository problemRepository;

    @Autowired
    UserService userService;

    @Autowired
    TestSubmissionService testSubmissionService;
    @Autowired
    UserGroupService userGroupService;

    @RequestMapping("/c/code-test")
    public String openCodeTestPage(Model model){
        model.addAttribute("codeCapture", new ProblemSubmission());
        return "codeTest";
    }

    @RequestMapping("/a/addProblem")
    public String openAddProblemPage(Model model){
        model.addAttribute("problem", new Problem());

        return "addProblem";
    }

    @RequestMapping("/a/addTest")
    public String openAddTestPage(Model model){
        model.addAttribute("testDetails", new TestDetails());

        return "addTest";
    }

    @RequestMapping("/a/dashboard")
    public String openAdminDashboard(Model model){
        model.addAttribute("testDetails", problemRepository.getAllTestDetails());

        return "adminDashboard";
    }
    @RequestMapping("/c/dashboard")
    public String openCandidateDashboard(Model model, Principal principal){
        model.addAttribute("testDetails", problemRepository.getAllUnattemptedTestDetails((User) userService.loadUserByUsername(principal.getName())));
        model.addAttribute("submittedTests", problemRepository.getAllAttemptedTestDetails((User) userService.loadUserByUsername(principal.getName())));
        return "candidateDashboard";
    }

    @RequestMapping("/c/test/{testId}")
    public ModelAndView openTestDetailsPage(@PathVariable("testId") Long testDetailsId){
        ModelAndView model = new ModelAndView("viewTest");
        org.nuccode.dao.entity.TestDetails testDetails = problemRepository.getTestDetailsById(testDetailsId);
        model.addObject("testDetails", testDetails);

        org.nuccode.dao.entity.TestSubmission testSubmission = new org.nuccode.dao.entity.TestSubmission();
        testSubmission.setTestDetails(testDetails);

        model.addObject("testSubmission", testSubmission);

        return model;
    }

    @RequestMapping("/a/test/{testId}")
    public ModelAndView openTestDetailsPageForAdmin(@PathVariable("testId") Long testDetailsId){
        ModelAndView model = new ModelAndView("adminPreviewTest");
        model.addObject("testSubmissions", testSubmissionService.getAllTestSubmissionsByTestId(testDetailsId));
        return model;
    }
    @GetMapping("/a/groups")
    public ModelAndView userGroups() {
        ModelAndView modelAndView = new ModelAndView("userGroups");
        modelAndView.addObject("userGroups", userGroupService.getAllGroups());

        return modelAndView;
    }

    @GetMapping("/a/groups/create")
    public ModelAndView createGroupForm() {
        ModelAndView modelAndView = new ModelAndView("createGroupForm");

        // Prepare data for the form
        List<User> users = userService.getAllUsers();

        modelAndView.addObject("users", users);
        modelAndView.addObject("userGroup", new UserGroup());

        return modelAndView;
    }
}

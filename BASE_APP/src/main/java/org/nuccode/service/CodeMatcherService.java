package org.nuccode.service;

import org.hibernate.HibernateException;
import org.nuccode.dao.entity.Problem;
import org.nuccode.dao.entity.ProblemSubmission;
import org.nuccode.dao.entity.TestCase;
import org.nuccode.dao.entity.TestSubmission;
import org.nuccode.dao.layers.ProblemRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.transaction.annotation.Transactional;

import javax.tools.JavaCompiler;
import javax.tools.JavaFileObject;
import javax.tools.StandardJavaFileManager;
import javax.tools.ToolProvider;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@EnableTransactionManagement
@Transactional
@Service
public class CodeMatcherService {

    @Autowired
    org.nuccode.service.Service service;
    @Autowired
    ProblemRepository problemRepository;

    @Deprecated
    public boolean matchTestCases(ProblemSubmission problemSubmission) {
        System.out.println("Inside Match Test Case " + problemSubmission);
        try {
            Problem problem = problemRepository.getProblemById(problemSubmission.getProblemId());
            if (problem == null) {
                System.out.println("Problem is null");
                return false;
            }
            List<TestCase> testCases = problem.getTestCases();
            int numberOfTestCasesMatched = 0;
            for (TestCase testCase : testCases) {
                String input = testCase.getInput();
                String expectedOutput = testCase.getOutput();
                String actualOutput = executeUserCode(problemSubmission.getCodeSnippet(), input);

                boolean isMatched = expectedOutput.equals(actualOutput);


                System.out.println("Matching Test case.....................");
                if (isMatched) {
                    numberOfTestCasesMatched++;
                    System.out.println("Test Case Matched");
                }
            }

            problemSubmission.setNumberOfTestCasesPassed(numberOfTestCasesMatched);

            problemRepository.submitSolution(problemSubmission);
            return true;
        } catch (IOException | HibernateException e) {
            System.out.println(e.getMessage());
            return false;
        }
    }

    @Deprecated
    private String executeUserCode(String code, String input) throws IOException {
        File tempFile = service.createTempJavaFile(code);

        String javaCommand = "java";
        String[] command = {javaCommand, "-cp", tempFile.getParent(), tempFile.getName()};

        ProcessBuilder processBuilder = new ProcessBuilder(command);
        processBuilder.directory(tempFile.getParentFile());

        processBuilder.redirectInput(ProcessBuilder.Redirect.PIPE);
        processBuilder.redirectOutput(ProcessBuilder.Redirect.PIPE);

        Process process = processBuilder.start();


        OutputStream outputStream = process.getOutputStream();
        outputStream.write(input.getBytes());
        outputStream.flush();
        outputStream.close();


        InputStream inputStream = process.getInputStream();
        String output = new String(inputStream.readAllBytes());
        inputStream.close();

        return output.trim();
    }

    public String executeProblem(ProblemSubmission problemSubmission) {
        try {
            System.out.println("inside execute problem");

            String userCode = problemSubmission.getCodeSnippet();
            Problem problem = problemRepository.getProblemById(problemSubmission.getProblemId());
            List<TestCase> testCases = problem.getTestCases();

            StringBuilder result = new StringBuilder();

            int numberOfTestCasesPassed = 0;

            for (TestCase testCase : testCases) {
                System.out.println("iterating test cases");
                String input = testCase.getInput();
                String expectedOutput = testCase.getOutput();

                List<String> inputs;
                if (input == null)
                    inputs = new ArrayList<>();
                else
                    inputs = Arrays.asList(input.split("[\\n\\s]+"));

                System.out.println("Just to execute code");
                String output = executeCode(userCode, inputs);
                System.out.println("code executed");

                if (output.trim().equals(expectedOutput.trim())) {
                    result.append("Test Case Passed: ").append(problem.getDescription()).append("Input: ").append(input).append(", Expected Output: ").append(expectedOutput).append(", Actual Output: ").append(output).append("<br/>");
                    numberOfTestCasesPassed++;
                } else {
                    result.append("Test Case Failed: ").append(problem.getDescription()).append("Input: ").append(input).append(", Expected Output: ").append(expectedOutput).append(", Actual Output: ").append(output).append("<br/>");
                }

            }

            problemSubmission.setNumberOfTestCasesPassed(numberOfTestCasesPassed);

            return result.toString();
        } catch (Exception e) {
            return "Error executing the problem: " + e.getMessage();
        }
    }

    private String executeCode(String userCode, List<String> inputs) throws IOException {
        System.out.println("inside execute code");
        String result = "";
        try {
            // Compile the code
            JavaCompiler compiler = ToolProvider.getSystemJavaCompiler();
            StandardJavaFileManager fileManager = compiler.getStandardFileManager(null, null, null);
            String fileName = "Main.java";

            File sourceFile = new File(fileName);

            try (BufferedWriter writer = new BufferedWriter(new FileWriter(sourceFile, StandardCharsets.UTF_8))) {
                writer.write(userCode);
            }

            Iterable<? extends JavaFileObject> compilationUnits = fileManager.getJavaFileObjectsFromFiles(List.of(sourceFile));
            compiler.getTask(null, fileManager, null, null, null, compilationUnits).call();
            fileManager.close();


            Process process = Runtime.getRuntime().exec("java Main");
            BufferedWriter processWriter = new BufferedWriter(new OutputStreamWriter(process.getOutputStream()));
            BufferedReader processReader = new BufferedReader(new InputStreamReader(process.getInputStream()));


            for (String input : inputs) {
                if (input != null) {
                    processWriter.write(input);
                    processWriter.newLine();
                    processWriter.flush();
                }
            }

            processWriter.close();

            StringBuilder output = new StringBuilder();
            String line;
            while ((line = processReader.readLine()) != null) {
                output.append(line);
                output.append(System.lineSeparator());
            }

            processReader.close();

            result = output.toString();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    public Long validateTestSubmission(TestSubmission testSubmission) {
        testSubmission.getProblemSubmissions().forEach(this::executeProblem);

        System.out.println("\n\n\n***********\n"+testSubmission+"\n*************\n\n\n");
        return problemRepository.uploadTestSubmission(testSubmission);
    }
}

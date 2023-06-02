package org.nuccode.dao.entity;

import javax.persistence.*;

@Entity
@Table(name = "org_nucCode_problemSubmission")
public class ProblemSubmission {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private Long problemId;
    private String codeSnippet;
    private int numberOfTestCasesPassed;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getProblemId() {
        return problemId;
    }

    public void setProblemId(Long problemId) {
        this.problemId = problemId;
    }

    public String getCodeSnippet() {
        return codeSnippet;
    }

    public void setCodeSnippet(String codeSnippet) {
        this.codeSnippet = codeSnippet;
    }

    public int getNumberOfTestCasesPassed() {
        return numberOfTestCasesPassed;
    }

    public void setNumberOfTestCasesPassed(int numberOfTestCasesPassed) {
        this.numberOfTestCasesPassed = numberOfTestCasesPassed;
    }

    @Override
    public String toString() {
        return "ProblemSubmission{" +
                "id=" + id +
                ", problemId=" + problemId +
                ", submission='" + codeSnippet + '\'' +
                ", numberOfTestCasesPassed=" + numberOfTestCasesPassed +
                '}';
    }
}

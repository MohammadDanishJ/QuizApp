package org.nuccode.models;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "org_nucCode_test_submission")
public class TestSubmission {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "test_submission_id")
    private Long id;
    /* Multiple Submissions can belong to one test*/
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "testDetailId")
    private TestDetails testDetails;
    @OneToMany(mappedBy = "testSubmission", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    List<ProblemSubmission> problemSubmissions;
    /*Multiple employees can submit solution for single problem*/
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "employee_id")
    private User user;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public TestDetails getTestDetails() {
        return testDetails;
    }

    public void setTestDetails(TestDetails testDetails) {
        this.testDetails = testDetails;
    }

    public List<ProblemSubmission> getProblemSubmissions() {
        return problemSubmissions;
    }

    public void setProblemSubmissions(List<ProblemSubmission> problemSubmissions) {
        this.problemSubmissions = problemSubmissions;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    @Override
    public String toString() {
        return "TestSubmission{" +
                "id=" + id +
                ", testDetails=" + (testDetails != null ? testDetails.getId() : null)+
                ", problemSubmissions=" + problemSubmissions +
                ", user=" +  (user != null ? user.getId() : null) +
                '}';
    }
}

package org.nuccode.models;

import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "org_nucCode_testDetails")
public class TestDetails {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "testDetailId")
    private Long id;
    private String testName;
    private String description;
    private int testTimer;

    @OneToMany(mappedBy = "testDetails", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    @Fetch(FetchMode.SUBSELECT) /* https://stackoverflow.com/a/43948615 */
    private List<Problem> problems;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTestName() {
        return testName;
    }

    public void setTestName(String testName) {
        this.testName = testName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getTestTimer() {
        return testTimer;
    }

    public void setTestTimer(int testTimer) {
        this.testTimer = testTimer;
    }

    public List<Problem> getProblems() {
        return problems;
    }

    public void setProblems(List<Problem> problems) {
        this.problems = problems;
    }

    @Override
    public String toString() {
        return "TestDetails{" +
                "id=" + id +
                ", testName='" + testName + '\'' +
                ", description='" + description + '\'' +
                ", testTimer=" + testTimer +
                ", problems=" + problems +
                '}';
    }
}


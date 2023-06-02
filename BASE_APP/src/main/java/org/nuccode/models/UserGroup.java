package org.nuccode.models;

import javax.persistence.*;
import java.util.List;

@Entity
public class UserGroup {
    private String groupCode;
    private String groupName;
    private List<Long> userIds;


    public String getGroupCode() {
        return groupCode;
    }

    public void setGroupCode(String groupCode) {
        this.groupCode = groupCode;
    }

    public String getGroupName() {
        return groupName;
    }


    public void setGroupName(String groupName) {
        this.groupName = groupName;
    }

    public List<Long> getUserIds() {
        return userIds;
    }

    public void setUserIds(List<Long> userIds) {
        this.userIds = userIds;
    }

    @Override
    public String toString() {
        return "UserGroup{" +
                "groupCode='" + groupCode + '\'' +
                ", groupName='" + groupName + '\'' +
                ", userIds=" + userIds +
                '}';
    }
}

package com.pojo;

import java.util.Date;

public class Topic {
    private Integer id;
    private String topicId;
    private String topicName;
    private String topicYear;
    private String demand;
    private Integer numberLimit;
    private Integer numberNow;//已经选择该课题的人数
    private String majorLimit;
    private Date deadline;
    private Character releaseSingal;
    private String userId;
    private String userName;
    private String deadlineString;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTopicId() {
        return topicId;
    }

    public void setTopicId(String topicId) {
        this.topicId = topicId;
    }

    public String getTopicName() {
        return topicName;
    }

    public void setTopicName(String topicName) {
        this.topicName = topicName;
    }

    public String getTopicYear() {
        return topicYear;
    }

    public void setTopicYear(String topicYear) {
        this.topicYear = topicYear;
    }

    public String getDemand() {
        return demand;
    }

    public void setDemand(String demand) {
        this.demand = demand;
    }

    public Integer getNumberLimit() {
        return numberLimit;
    }

    public void setNumberLimit(Integer numberLimit) {
        this.numberLimit = numberLimit;
    }

    public String getMajorLimit() {
        return majorLimit;
    }

    public void setMajorLimit(String majorLimit) {
        this.majorLimit = majorLimit;
    }

    public Date getDeadline() {
        return deadline;
    }

    public void setDeadline(Date deadline) {
        this.deadline = deadline;
    }

    public Character getReleaseSingal() {
        return releaseSingal;
    }

    public void setReleaseSingal(Character releaseSingal) {
        this.releaseSingal = releaseSingal;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getDeadlineString() {
        return deadlineString;
    }

    public void setDeadlineString(String deadlineString) {
        this.deadlineString = deadlineString;
    }

    public Integer getNumberNow() {
        return numberNow;
    }

    public void setNumberNow(Integer numberNow) {
        this.numberNow = numberNow;
    }
}

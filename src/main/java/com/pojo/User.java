package com.pojo;

public class User {
    private Integer id;
    private String userId;
    private String userName;
    private Character gender;
    private String enterYear;
    private String className;
    private String majorIn;
    private Character selectedSignal;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
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

    public Character getGender() {
        return gender;
    }

    public void setGender(Character gender) {
        this.gender = gender;
    }

    public String getEnterYear() {
        return enterYear;
    }

    public void setEnterYear(String enterYear) {
        this.enterYear = enterYear;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public String getMajorIn() {
        return majorIn;
    }

    public void setMajorIn(String majorIn) {
        this.majorIn = majorIn;
    }

    public Character getSelectedSignal() {
        return selectedSignal;
    }

    public void setSelectedSignal(Character selectedSignal) {
        this.selectedSignal = selectedSignal;
    }
}

package com.service;


import com.pojo.Login;

public interface LoginService {
    public Login findLoginUser(String userId, String password,String userState);
    public int updateRemarks(String remarks, String userId);
}

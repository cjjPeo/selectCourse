package com.service.impl;

import com.dao.LoginDao;
import com.pojo.Login;
import com.service.LoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("loginService")
@Transactional
public class LoginServiceImpl implements LoginService {
    @Autowired
    private LoginDao loginDao;
    //获取登陆表中对应的用户信息
    public Login findLoginUser(String userId, String password,String userState){
        return this.loginDao.findLoginUser(userId,password,userState);
    }
    //更新登录的状态标识为,登录和注销的时候使用
    public int updateRemarks(String remarks, String userId){
        return this.loginDao.updateRemarks(remarks,userId);
    }
}

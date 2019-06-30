package com.dao;

import com.pojo.Login;
import com.pojo.Topic;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface LoginDao {
    //获取登陆表中对应的用户信息
    public Login findLoginUser(@Param("userId")String userId, @Param("password")String password,@Param("userState")String userState);
    //更新登录的状态标识为,登录和注销的时候使用
    public int updateRemarks(@Param("remarks")String remarks,@Param("userId") String userId);
    //更改密码
    public int updatePassword(@Param("password")String password,@Param("userId")String userId);



}

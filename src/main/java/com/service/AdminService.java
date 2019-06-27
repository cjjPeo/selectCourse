package com.service;

import com.pojo.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AdminService {
    public List<User> findTeacherList();
    Integer findTeacherExist(String userId);
    Integer insertTeacher(String userId,String userName,String gender);
    Integer deleteTeacher(String userId);
    Integer updateTeacherUsers(String gender,String userName,String userId);
    Integer updateTeacherPassword(String userId);

}

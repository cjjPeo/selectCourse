package com.dao;

import com.pojo.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AdminDao {
    //关于教师的操作
    public List<User> findTeacherList();
    Integer findTeacherExist(@Param("userId")String userId);
    Integer insertTeacherInUsers(@Param("userId")String userId,@Param("userName")String userName,@Param("gender")String gender);
    Integer insertTeacherInLogin(@Param("useId")String userId);
    Integer deleteTeacherFromUsers(@Param("userId")String userId);
    Integer deleteTeacherFromLogin(@Param("userId")String userId);
    Integer updateTeacherUsers(@Param("gender")String gender,@Param("userName")String userName,@Param("userId")String userId);
    Integer updateTeacherPassword(@Param("userId")String userId);
}

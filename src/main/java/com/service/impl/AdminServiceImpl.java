package com.service.impl;

import com.dao.AdminDao;
import com.pojo.User;
import com.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service("adminService")
@Transactional
public class AdminServiceImpl implements AdminService {
    @Autowired
    private AdminDao adminDao;

    @Override
    public List<User> findTeacherList() {
        return this.adminDao.findTeacherList();
    }

    @Override
    public Integer findTeacherExist(String userId) {
        return this.adminDao.findTeacherExist(userId);
    }

    @Override
    public Integer insertTeacher(String userId, String userName, String gender) {
        Integer s=this.adminDao.insertTeacherInLogin(userId);
        Integer s1=this.adminDao.insertTeacherInUsers(userId,userName,gender);
        if (s>0&&s1>0){
            return 1;
        }
        return 0;
    }

    @Override
    public Integer deleteTeacher(String userId) {
        Integer s=this.adminDao.deleteTeacherFromLogin(userId);
        Integer s1=this.adminDao.deleteTeacherFromUsers(userId);
        if (s>0&&s1>0){
            return 1;
        }
        return 0;
    }

    @Override
    public Integer updateTeacherPassword(String userId) {
        return this.adminDao.updateTeacherPassword(userId);
    }

    @Override
    public Integer updateTeacherUsers(String gender, String userName, String userId) {
        return this.adminDao.updateTeacherUsers(gender,userName,userId);
    }
}

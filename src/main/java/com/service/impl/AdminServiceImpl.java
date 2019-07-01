package com.service.impl;

import com.dao.AdminDao;
import com.pojo.Topic;
import com.pojo.User;
import com.service.AdminService;
import org.apache.commons.lang.StringUtils;
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

    @Override
    public List<Topic> findCourses(String topicId) {
        return this.adminDao.findCourses(topicId);
    }

    @Override
    public Integer deleteCourseAt(String topicId) {
        return this.adminDao.deleteCourseAt(topicId );
    }

    @Override
    public Integer updateCourses(Topic topic) {
        return this.adminDao.updateCourses(topic);
    }

    @Override
    public int deleteStu(String userId) {
        return adminDao.deleteStu(userId);
    }

    @Override
    public int addStu(User user) {
        return adminDao.addStu(user);
    }

    @Override
    public User toeditStu(String userId) {
        return adminDao.toeditStu(userId);
    }

    @Override
    public int editStu(User user) {
        return adminDao.editStu(user);
    }

    @Override
    public int ManaAddTopic(Topic topic) {
        return adminDao.ManaAddTopic(topic);
    }

    @Override
    public List<User> findStudentList(String userId, String userName, Character gender, String enterYear,
                                      String className, String majorIn, Character selectedSignal) {
        User user=new User();
        if (StringUtils.isNotBlank(userId)) {
            user.setUserId(userId);
        }
        if (StringUtils.isNotBlank(userName)) {
            user.setUserName(userName);
        }
        if (StringUtils.isNotBlank(gender+"")) {
            user.setGender(gender);
        }
        if (StringUtils.isNotBlank(enterYear)) {
            user.setEnterYear(enterYear);
        }
        if (StringUtils.isNotBlank(className)) {
            user.setClassName(className);
        }
        if (StringUtils.isNotBlank(majorIn)) {
            user.setMajorIn(majorIn);
        }
        if (StringUtils.isNotBlank(selectedSignal+"")) {
            user.setSelectedSignal(selectedSignal);
        }
        List<User> students = adminDao.findStudentList(userId, userName, gender, className, majorIn, enterYear, selectedSignal);
        return students;
    }

    @Override
    public Integer startAllCourse() {
        return this.adminDao.startAllCourse();
    }

    @Override
    public Integer stopAllCourse() {
        return this.adminDao.stopAllCourse();
    }
}

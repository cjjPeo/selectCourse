package com.service;

import com.pojo.Topic;
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
    List<Topic> findCourses(String topicId);
    Integer updateCourses(Topic topic);

    public int deleteStu(String userId);

    public int addStu(User user);

    public User toeditStu(String userId);

    public int editStu(User user);

    public int ManaAddTopic(Topic topic);
    Integer deleteCourseAt(String topicId);
    public List<User> findStudentList(String userId,String userName,Character gender,String enterYear,String className,String majorIn,Character selectedSignal);
    Integer stopAllCourse();
    Integer startAllCourse();
}

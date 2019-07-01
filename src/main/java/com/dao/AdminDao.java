package com.dao;

import com.pojo.Topic;
import com.pojo.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AdminDao {
    //关于教师的操作
    public List<User> findTeacherList();
    Integer findTeacherExist(@Param("userId")String userId);
    Integer insertTeacherInUsers(@Param("userId")String userId,@Param("userName")String userName,@Param("gender")String gender);
    Integer insertTeacherInLogin(@Param("userId")String userId);
    Integer deleteTeacherFromUsers(@Param("userId")String userId);
    Integer deleteTeacherFromLogin(@Param("userId")String userId);
    Integer updateTeacherUsers(@Param("gender")String gender,@Param("userName")String userName,@Param("userId")String userId);
    Integer updateTeacherPassword(@Param("userId")String userId);
    List<Topic> findCourses(@Param("topicId")String topicId);
    Integer updateCourses(@Param("topic")Topic topic);

    Integer deleteCourseAt(@Param("topicId")String topicId);
    public int deleteStu(@Param("userId")String userId);

    public int addStu(@Param("user")User user);

    public User toeditStu(@Param("userId")String userId);

    public int editStu(@Param("user")User user);

    public int ManaAddTopic(@Param("topic")Topic topic);
    public List<User> findStudentList(@Param("userId")String userId,
                                      @Param("userName")String userName,
                                      @Param("gender")Character gender,
                                      @Param("className")String className,
                                      @Param("majorIn")String majorIn,
                                      @Param("enterYear")String enterYear,
                                      @Param("selectedSignal")Character selectedSignal);

    Integer stopAllCourse();
    Integer startAllCourse();

}

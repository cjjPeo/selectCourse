package com.dao;

import com.pojo.Excel;
import com.pojo.StudentAndTopic;
import com.pojo.Topic;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TeacherDao {
    public List<Excel> findSelectByTeacher(@Param("userId")String userId,@Param("releaseSignal")String releaseSignal);
    public Integer findTopicById(@Param("topicId")String topicId);
    public Integer insertTopicDetail(@Param("topic")Topic topic);
    public Integer insertTopicTeacher(@Param("topic")Topic topic);
    public Integer deleteStudentTopic(@Param("userId")String userId);
    public Integer updateStudentSignal(@Param("selectedSignal")String selectedSignal,@Param("userId")String userId);
    public Integer insertStudentTopic(@Param("userId")String userId,@Param("topicId")String topicId);
    public List<StudentAndTopic> findStudentForInsert(@Param("userId")String userId);
    Topic findOneTopic(@Param("topicId")String topicId);
    public int editThistopic(@Param("topic")Topic topic); //修改课程
    public int deleteTopicInTopic(@Param("topicId")String topicId);
    public int deleteTopicInToTea(@Param("topicId")String topicId);
    public int deleteTopicInChoose(@Param("topicId")String topicId);
    public int stopMyTopic(@Param("releaseSingal")String releaseSingal,@Param("userId")String userId); //结束课题
}

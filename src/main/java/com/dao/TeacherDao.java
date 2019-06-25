package com.dao;

import com.pojo.Excel;
import com.pojo.Topic;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TeacherDao {
    public List<Excel> findSelectByTeacher(@Param("userId")String userId);
    public Integer findTopicById(@Param("topicId")String topicId);
    public Integer insertTopicDetail(@Param("topic")Topic topic);
    public Integer insertTopicTeacher(@Param("topic")Topic topic);
}

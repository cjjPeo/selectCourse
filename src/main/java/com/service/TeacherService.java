package com.service;

import com.pojo.Excel;
import com.pojo.StudentAndTopic;
import com.pojo.Topic;

import java.util.List;

public interface TeacherService {
    public List<Excel> findSelectByTeacher(String userId,String releaseSingal);
    public Integer findTopicById(String topicId);
    public void insertDataFromExcel(List<Topic> topics);
    public Integer insertOneTopic(Topic topic);
    public Integer updateStudentTopic(String topicId,String userId);
    public Integer deleteStudentTopic(String userId,String topicId);
    public Integer insertStudentToTopic(String userId,String topicId);
    public List<StudentAndTopic> findStudentToTopic();
}

package com.service;

import com.pojo.Excel;
import com.pojo.Topic;

import java.util.List;

public interface TeacherService {
    public List<Excel> findSelectByTeacher(String userId);
    public Integer findTopicById(String topicId);
    public void insertDataFromExcel(List<Topic> topics);
    public Integer inserOneTopic(Topic topic);
}

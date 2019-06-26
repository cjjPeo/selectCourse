package com.service;

import com.pojo.Excel;
import com.pojo.Topic;

import java.util.List;

public interface StudentChooseService {
    public List<Topic> findTopic(String topicName,String majorLimit,String userName,String userId);
    public int updatePassword(String userId,String password);
}

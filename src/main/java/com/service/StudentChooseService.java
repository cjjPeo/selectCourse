package com.service;

import com.pojo.Excel;
import com.pojo.Topic;
import com.pojo.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface StudentChooseService {
    public List<Topic> findTopic(String topicName,String majorLimit,String userName,String userId);
    public int updatePassword(String userId,String password);
   public User findMyInfo(String userId);

    public int optTopic(String userId,String topicId);
    public int deleteMychoose(String userId);
    public Topic findMyTopic(String userId);
}

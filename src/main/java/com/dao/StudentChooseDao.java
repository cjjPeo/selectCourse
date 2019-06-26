package com.dao;

import com.pojo.Excel;
import com.pojo.Topic;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface StudentChooseDao {
    public List<Topic> findTopic(@Param("topicName")String topicName,@Param("majorLimit")String majorLimit,@Param("userName")String userName,@Param("userId")String userId);
    public int updatePassword(@Param("password")String password,@Param("userId")String userId);
    public Integer findCountThisTopic(@Param("topicId")String topicId);
}

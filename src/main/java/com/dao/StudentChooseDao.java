package com.dao;

import com.pojo.Excel;
import com.pojo.Topic;
import com.pojo.User;
import org.apache.ibatis.annotations.Param;
import java.util.List;

public interface StudentChooseDao {
    public List<Topic> findTopic(@Param("topicName")String topicName,@Param("majorLimit")String majorLimit,@Param("userName")String userName,@Param("userId")String userId);
    public int updatePassword(@Param("password")String password,@Param("userId")String userId);
    public Integer findCountThisTopic(@Param("topicId")String topicId);
    public User findMyInfo(@Param("userId")String userId);
    public int optTopic(@Param("userId") String userId,@Param("topicId") String topicId);
    public Integer findMyTopicCount(@Param("userId")String userId);

    public Topic findMyTopic(@Param("userId") String userId);
    Integer optTopic2(@Param("userId")String userId);

    public int deleteMychoose(@Param("userId") String userId);
}

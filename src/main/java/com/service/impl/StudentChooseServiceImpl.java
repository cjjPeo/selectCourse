package com.service.impl;

import com.dao.StudentChooseDao;
import com.pojo.Excel;
import com.pojo.Topic;
import com.service.StudentChooseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Service("studentChooseService")
@Transactional
public class StudentChooseServiceImpl implements StudentChooseService {
    @Autowired
    private StudentChooseDao studentChooseDao;
    public List<Topic> findTopic(String topicName, String majorLimit, String userName,String userId){
       List<Topic> topicList=  this.studentChooseDao.findTopic(topicName,majorLimit,userName,userId);
       for(Topic topic:topicList){
           //对时间格式的处理
           Date date=topic.getDeadline();
           SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
           String dateString=simpleDateFormat.format(date);
           System.out.println(dateString);
           topic.setDeadlineString(dateString);
           //已经选择人数
           Integer numberCount=this.studentChooseDao.findCountThisTopic(topic.getTopicId());
           topic.setNumberNow(numberCount);
       }
       return topicList;
    }
    public int updatePassword(String userId,String password){
        return this.studentChooseDao.updatePassword(password,userId);
    }

}

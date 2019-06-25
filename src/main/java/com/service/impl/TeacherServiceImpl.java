package com.service.impl;

import com.dao.TeacherDao;
import com.pojo.Excel;
import com.pojo.Topic;
import com.service.TeacherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service("teacherService")
@Transactional
public class TeacherServiceImpl implements TeacherService {
    @Autowired
    private TeacherDao teacherDao;
    public List<Excel> findSelectByTeacher(String userId){
        return this.teacherDao.findSelectByTeacher(userId);
    }
    public Integer findTopicById(String topicId){
        return this.teacherDao.findTopicById(topicId);
    }
    public void insertDataFromExcel(List<Topic> topics){
       System.out.println(topics.size());
        for(Topic topic:topics){
            this.teacherDao.insertTopicDetail(topic);
            this.teacherDao.insertTopicTeacher(topic);
        }
    }

    @Override
    public Integer inserOneTopic(Topic topic) {
        Integer sign=this.teacherDao.insertTopicDetail(topic);
        Integer sign2=this.teacherDao.insertTopicTeacher(topic);
        if(sign>0&&sign2>0){
            return 1;
        }else{
            return 0;
        }
    }
}

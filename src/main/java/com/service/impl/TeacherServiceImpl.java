package com.service.impl;

import com.dao.TeacherDao;
import com.pojo.Excel;
import com.pojo.StudentAndTopic;
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
    public List<Excel> findSelectByTeacher(String userId,String releaseSingal){
        return this.teacherDao.findSelectByTeacher(userId,releaseSingal);
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
    public Integer insertOneTopic(Topic topic) {
        //插入topic表
        Integer sign=this.teacherDao.insertTopicDetail(topic);
        //插入topic_teacher表
        Integer sign2=this.teacherDao.insertTopicTeacher(topic);
        if(sign>0&&sign2>0){
            return 1;
        }else{
            return 0;
        }
    }
    //先删除后添加
    @Override
    public Integer updateStudentTopic(String topicId, String userId) {
        Integer sin=this.teacherDao.deleteStudentTopic(userId);
        Integer sin2=this.teacherDao.insertStudentTopic(userId,topicId);
        if (sin >0&& sin2>0){
            return 1;
        }else{
            return 0;
        }
    }
    //直接删除
    @Override
    public Integer deleteStudentTopic(String userId) {
        Integer sin=this.teacherDao.deleteStudentTopic(userId);
        Integer sin2=this.teacherDao.updateStudentSignal("0",userId);
        if (sin >0&& sin2>0){
            return 1;
        }else{
            return 0;
        }
    }
    //查找全部的学生，如果有课程的话，包含课程信息和负责老师的id和名字
    @Override
    public List<StudentAndTopic> findStudentToTopic() {
        return this.teacherDao.findStudentForInsert();
    }

    @Override
    public Integer insertStudentToTopic(String userId, String topicId) {
        Integer sin=this.teacherDao.insertStudentTopic(userId,topicId);
        Integer sin2=this.teacherDao.updateStudentSignal("1",userId);
        if (sin >0&& sin2>0){
            return 1;
        }else{
            return 0;
        }
    }
}

package com.controller;

import com.Execel.ExecelUtil;
import com.pojo.Excel;
import com.pojo.Login;
import com.pojo.Topic;
import com.pojo.User;
import com.service.StudentChooseService;
import jxl.write.WriteException;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "studentChoose")
public class StudentChooseController {
    @Autowired
    private StudentChooseService studentChooseService;
    @RequestMapping(value = "searchTopic.action")
    public  String findTopic(String searchText, String searchFor, Model model){
        String majorLimit=null,userName=null,topicName=null;
        //单选条件
        System.out.println(searchFor);
        if ("majorLimit".equals(searchFor)){
            majorLimit =searchText;
            System.out.println("      majorLimit");
        }else if ("userName".equals(searchFor)){
            userName=searchText;
            System.out.println("      userName");
        }else if("topicName".equals(searchFor)){
            topicName=searchText;
            System.out.println("       topicName");
        }
        System.out.println("        studentCourse");
        List<Topic> topicList=this.studentChooseService.findTopic(topicName,majorLimit,userName,"");
        model.addAttribute("topicList",topicList);
        return "student-course-list";
    }
    @RequestMapping(value = "tosss.action")
    public  String findTosss(HttpSession session,Model model){
        Login login=(Login)session.getAttribute("USER_SESSION");
        String userId=login.getUserId();
        model.addAttribute("userId",userId);
        return "sss";
    }

    @RequestMapping("optTopic.action")
    @ResponseBody
    public String topicOpt(String userId,String topicId) {
        if (userId!=null &&topicId!=null){
            int rows=studentChooseService.optTopic(userId, topicId);
            if(rows>0) {
                return "OK";
            }else {
                return "FALL";
            }
        }
        return "fail";
    }

    //删除我的选择
    @RequestMapping("deleteMyChoose.action")
    @ResponseBody
    public String Deletemychoose(String userId) {
        System.out.println("登录用户Id:"+userId);
        int rows=studentChooseService.deleteMychoose(userId);
        if(rows>0) {
            System.out.println("删除成功！");
            return "OK";
        }else {
            System.out.println("error！");
            return "FALL";
        }
    }
}

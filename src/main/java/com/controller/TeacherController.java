package com.controller;

import com.Execel.ExecelUtil;
import com.pojo.*;
import com.service.StudentChooseService;
import com.service.TeacherService;
import jxl.write.WriteException;
import org.apache.commons.io.FileUtils;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.net.URLEncoder;
import java.util.*;

@Controller
@RequestMapping(value = "teacher")
public class TeacherController {
    @Autowired
    private StudentChooseService studentChooseService;
    @Autowired
    private TeacherService teacherService;
    @RequestMapping(value = "updatePass.action")
    public String updatePassword(String userId, String password, Model model){
        int i=this.studentChooseService.updatePassword(userId,password);
        if(i>0){
            model.addAttribute("msg","修改成功");
        }else{
            model.addAttribute("msg","修改失败");
        }
        return "sss";
    }
//导出表格
    @RequestMapping(value = "outPutExcel.action")
    public void download(HttpServletResponse response, HttpSession session,Model model) throws IOException {
        // 指定一个地方临时存放生成的 excel 文件，然后后面调用浏览器接口下载完后再删除
        String FILEPATH = "d:/test.xls";
        // 判断 "c:/test.xls" 文件是否已经存在，如果存在就删除掉
        ExecelUtil.deleteFile(FILEPATH);
        // 首行表头信息
        List<String> ll = new ArrayList<>();
        ll.add("topicId");
        ll.add("topicName");
        ll.add("demand");
        ll.add("numberLimit");
        ll.add("majorLimit");
        ll.add("userDetail");
        ll.add("releaseSignal");
        // 获取所有用户信息
        Login login=(Login)session.getAttribute("USER_SESSION");
        String userId=login.getUserId();
        //查找全部已经发布的课题
        List<Excel> allUserList =this.teacherService.findSelectByTeacher(userId,"1");
        if(allUserList.isEmpty()){
            model.addAttribute("msg","还没有发布的课程！");
            return;
        }
        // 将用户的相关信息遍历到 List<Map<String, Object>> 中
        List<Map<String, Object>> list = new ArrayList<>();
        for (Excel excel : allUserList) {
            Map<String, Object> map = new HashMap<>();
            map.put("topicId", excel.getTopicId());
            map.put("topicName", excel.getTopicName());
            map.put("demand", excel.getDemand());
            map.put("numberLimit", excel.getNumberLimit());
            map.put("majorLimit", excel.getMajorLimit());
            map.put("userDetail", excel.getUserDetail());
            map.put("releaseSingal", excel.getReleaseSingal());
            list.add(map);
        }
        try {
            // 第一个参数：表格中的数据
            // 第二个参数：表格保存的路径
            // 第三个参数：表格第二行的列信息
            // 第四个参数：表格第一行的表头信息
            ExecelUtil.CreateExcelFile(list, new File(FILEPATH), ll, login.getUserId()+"-选课情况表");
        } catch (WriteException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        // 调用浏览器下载接口
        ExecelUtil.send(FILEPATH, response);
        // 删除临时存放的 excel 文件
        boolean deleteFileState = ExecelUtil.deleteFile(FILEPATH);
        if (deleteFileState) {
            System.out.println("服务器上文件删除成功！！！");
        } else {
            System.out.println("服务器上文件删除失败！！！");
        }
    }
    @RequestMapping(value = "toInputData.action")
    public String toInput(){
        return "inputdata";
    }
    //下载数据导入模板
    @RequestMapping("downloadModel.action")
    public ResponseEntity<byte[]> fileDownload(HttpServletRequest request,@RequestParam("filename") String filename) throws Exception{
        String path=request.getServletContext().getRealPath("/upload/");
        File file=new File(path+File.separator+filename);
        filename=this.getFilename(request,filename);
        System.out.println(path+File.separator+filename);
        HttpHeaders headers=new HttpHeaders();
        headers.setContentDispositionFormData("attachment", filename);
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file),headers, HttpStatus.OK);
    }

    public String getFilename(HttpServletRequest request,String filename) throws Exception{
        String [] IEBrowserKeyWords= {"MSIE","Trident","Edge"};
        String userAgent=request.getHeader("User-Agent");
        for(String keyWord:IEBrowserKeyWords)
            if(userAgent.contains(keyWord))
                return URLEncoder.encode(filename,"UTF-8");
        return new String(filename.getBytes("UTF-8"),"ISO-8859-1");
    }
    //导入
    @RequestMapping(value = "uploadData.action",method = RequestMethod.POST)//上传课题
    public String uploadData(List<MultipartFile> uploadFile, HttpServletRequest request, Model model){
        List<Topic> list = new ArrayList<Topic>();
        InputStream input=null;
        // File file = null;
        //判断时是否为空，上传一个文件，判断上传文件是否为.xls(二进制的)
        System.out.println(uploadFile.isEmpty());
        System.out.println(uploadFile.size());
        if(!uploadFile.isEmpty()&&uploadFile.size()==1){
            MultipartFile file=uploadFile.get(0);
            String fileName=file.getOriginalFilename();
            String suffix=fileName.substring(fileName.lastIndexOf('.'),fileName.length());
            //只能对.xls文件进行操作
            if (suffix.equals(".xls")){
                String dirPath=request.getServletContext().getRealPath("/upload/");
                File filePath=new File(dirPath);
                if(!filePath.exists()) {
                    filePath.mkdirs();
                }
                String path=dirPath+fileName;
                //首先上传文件保存在服务器
                try {
                    file.transferTo(new File(path));
                } catch (Exception e) {
                    e.printStackTrace();
                }
                System.out.println(path);
                try {
                    input = new FileInputStream(path);
                } catch (FileNotFoundException e) {
                    System.out.println("未找到指定的文件！");
                }
                POIFSFileSystem fileSystem = null;
                HSSFWorkbook workBook = null;
                try {
                    fileSystem = new POIFSFileSystem(input);
                    workBook = new HSSFWorkbook(fileSystem);
                } catch (IOException e) {
                    e.printStackTrace();
                }
                HSSFSheet sheet = workBook.getSheetAt(0);
                //开始读文件
                int rowCount=sheet.getPhysicalNumberOfRows();
                //行
                for(int i=1;i<rowCount;i++){
                    Topic topic=new Topic();
                    Row row=sheet.getRow(i);
                    int cellCount=row.getPhysicalNumberOfCells();
                    //列
                    for(int j=0;j<cellCount;j++){
                        Cell cell=row.getCell(j);
                        if(cell!=null){
                            switch (j){
                                case 0:
                                        Integer sign=this.teacherService.findTopicById(cell.getStringCellValue());
                                        if (sign>0){
                                            model.addAttribute("msg","其中有课题的学号已存在");
                                            return "";
                                        }else{
                                            topic.setTopicId(cell.getStringCellValue());
                                        }
                                    break;
                                case 1:
                                        topic.setTopicName(cell.getStringCellValue());
                                    break;
                                case 2:
                                    topic.setDemand(cell.getStringCellValue());
                                    break;
                                case 3:
                                    topic.setNumberLimit((int)cell.getNumericCellValue());
                                    break;
                                case 4:
                                    topic.setMajorLimit(cell.getStringCellValue());
                                    break;
                                case 5:
                                    topic.setUserId(cell.getStringCellValue());
                                    break;
                            }
                        }
                    }
                    Calendar date = Calendar.getInstance();
                    String year = String.valueOf(date.get(Calendar.YEAR));
                    topic.setTopicYear(year);
                    topic.setReleaseSingal('0');
                    list.add(topic);
                }
                if(list.size()>0){
                    this.teacherService.insertDataFromExcel(list);
                    System.out.println("insertSuccess");
                }
            }else{
                model.addAttribute("msg","请上传.xls类型的文件");
            }
        }else{
            model.addAttribute("msg","请上传一个文件");
        }
        return "next";
    }
    //单个添加课题
    @RequestMapping(value = "toInsertTopic.action")
    public String toInsertTopic(){
        return "insertOneT";
    }
    @RequestMapping(value = "insertOneTopic.action")
    public String insertOneTopic (String topicId,String topicName,String demand,Integer numberLimit,String majorLimit,HttpSession session,Model model){
        Integer sign=this.teacherService.findTopicById(topicId);
        if(sign>0){
            model.addAttribute("msg","该课程号已经存在");
            return "insertOneT";
        }
        Login login=(Login)session.getAttribute("USER_SESSION");
        String userId=login.getUserId();
        Topic topic=new Topic();
        topic.setTopicId(topicId);
        topic.setTopicName(topicName);
        topic.setDemand(demand);
        topic.setNumberLimit(numberLimit);
        topic.setMajorLimit(majorLimit);
        topic.setUserId(userId);
        Calendar date = Calendar.getInstance();
        String year = String.valueOf(date.get(Calendar.YEAR));
        topic.setTopicYear(year);
        topic.setReleaseSingal('0');
        Integer sign2=this.teacherService.insertOneTopic(topic);
        if (sign2>0){
            model.addAttribute("msg","插入成功");
        }else{
            model.addAttribute("msg","插入失败");

        }
        return "next";
    }
    //查看教师自己的课程
    @RequestMapping(value = "selectTopicByUserId.action")
    public String selectTopicByUserId(HttpSession session,Model model){
        Login login =(Login)session.getAttribute("USER_SESSION");
        List<Excel> excelList=this.teacherService.findSelectByTeacher(login.getUserId(),"");
        model.addAttribute("excelList",excelList);
        return "showTeacherTopic";
    }
    @RequestMapping(value = "getTopicStudent.action")
    public String getTopicStudent(String studentList,String topicId,Model model){
        model.addAttribute("topicId",topicId);
        if(!studentList.isEmpty()){
            String[] studentLists=studentList.split(",");
            List<User> users=new ArrayList<>();
            for(String s:studentLists){
                User user=new User();
                if (s.contains("-")){
                        String[] s1=s.split("-");
                        for(int i=0;i<s1.length;i++){
                            switch (i){
                                case 0:
                                    user.setUserId(s1[0]);
                                    break;
                                case 1:
                                    user.setUserName(s1[1]);
                                    break;
                                case 2:
                                    user.setClassName(s1[2]);
                                    break;
                                case 3:
                                    user.setMajorIn(s1[3]);
                                    break;
                            }
                        }
                    }else{
                        user.setUserId(s);
                    }
                users.add(user);
            }
            model.addAttribute("users",users);
        }else{
            model.addAttribute("msg","现在无学生，请加入学生");
        }
        return "showStudent";
    }
    //修改学生的选课,只能将该学生改到自己的其他已经发布课程中
    @RequestMapping(value = "ForUpdateStudentTopic.action")
    public String ForUpdateStudentTopic(String userId,HttpSession session,Model model){
        Login login=(Login)session.getAttribute("USER_SESSION");
        List<Topic> topicList=this.studentChooseService.findTopic("","","",login.getUserId());
        model.addAttribute("courseList",topicList);
        model.addAttribute("userId",userId);
        return "updateStudentTopic";
    }
    @RequestMapping(value = "updateStudentTopic.action")
    public String updateStudentTopic(String topicId,String userId,Model model){
        Integer sin=this.teacherService.updateStudentTopic(topicId,userId);
        if (sin>0){
            model.addAttribute("msg","添加成功！");
        }else {
            model.addAttribute("msg","添加失败");
        }
        return "redirect:/teacher/selectTopicByUserId.action";//流程还要改
    }
    //从课程中删除学生的操作，另外接入的时候可能需要判断该学生选的课程是否是该教师的
    @RequestMapping(value = "deleteStudentFromThisTopic.action")
    public void deleteStudentTopic(String userId,String topicId,Model model){
        Integer sin=this.teacherService.deleteStudentTopic(userId,topicId);
        if (sin>0){
            model.addAttribute("msg","删除成功");
        }else {
            model.addAttribute("msg","删除失败");
        }
    }
    //将学生添加进课题,显示全部学生的信息和选择状态，如果有选择的课程可以先让他退选然后再选择
    @RequestMapping(value = "findStudentToTopic.action")
    public String findStudentToTopic(String topicId,Model model){
        model.addAttribute("topicId",topicId);
        List<StudentAndTopic> studentAndTopics=this.teacherService.findStudentToTopic();
        System.out.println("find");
        model.addAttribute("AllUsers",studentAndTopics);
        return "afterInsertStudent";
    }
    @RequestMapping(value = "insertStudentToTopic.action")
    public String insertStudentToTopic(String userId,String selectedSignal,String teacherId,String topicId,HttpSession session,Model model){
        Login login=(Login)session.getAttribute("USER_SESSION");
        if(teacherId!=null&&login.getUserId()!=teacherId){
            model.addAttribute("msg","该学生选择了其他老师，请勿操作");
            System.out.println("111123");
        }else{
            System.out.println("sisis:"+selectedSignal);
            Integer sin;
            if(selectedSignal=="1"){
                sin=this.teacherService.updateStudentTopic(topicId,userId);
            }else{
                sin=this.teacherService.insertStudentToTopic(userId,topicId);
            }
            if (sin>0){
                model.addAttribute("msg", "成功");
            }else{
                model.addAttribute("msg","失败");
            }
        }
        return "redirect:/teacher/selectTopicByUserId.action";
    }
}

<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2019/6/5
  Time: 18:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%--<%@ taglib prefix="itheima" uri="http://itheima.com/common/"%>--%>
<html>
<head>
    <title>Title</title>
</head>
<body>
hello!<br>
${USER_SESSION.userId}<br>
${msg}
<a href="${pageContext.request.contextPath}/studentChoose/tosss.action">修改密码</a>
<a href="${pageContext.request.contextPath}/teacher/outPutExcel.action">导出（只能在教师的页面使用，否则出错) </a>
<a href="${pageContext.request.contextPath}/teacher/toInputData.action">导入</a>
<a href="${pageContext.request.contextPath}/teacher/toInsertTopic.action">添加课程</a><%--//待测试--%>
<a href="${pageContext.request.contextPath}/teacher/selectTopicByUserId.action">查看自己的课题</a>
<br><a href="${pageContext.request.contextPath}/admin/findTeacherList.action">管理员对教师的增删改查</a>
<br><a href="${pageContext.request.contextPath}/login/quit.action">注销</a>
课程搜索
<form action="${pageContext.request.contextPath}/studentChoose/searchTopic.action">
    搜索框：<br><input type="text" name="searchText">
    搜索标签：（单选）<br>
    专业方向<input type="radio" value="majorLimit" name="searchFor">
    老师<input type="radio" value="userName" name="searchFor">
    课题名字<input type="radio" value="topicName" name="searchFor"><br>
    <input type="submit" value="搜索">
</form><br>
课程显示（全部的课程）<br>
<table border="1"  >
    <tr>
        <th>topicId</th>
        <th>topicName</th>
        <th>demand</th>
        <th>numberLimit</th>
        <th>majorLimit</th>
        <th>numberNow</th>
        <th>deadline</th>
        <th>userName</th>
    </tr>
        <c:forEach items="${topicList}" var="it">
            <tr>
                <td>${it.topicId}</td>
                <td>${it.topicName}</td>
                <td>${it.demand}</td>
                <td>${it.numberLimit}</td>
                <td>${it.majorLimit}</td>
                <td>${it.numberNow}</td>
                <td>${it.deadlineString}</td>
                <td>${it.userName}</td>
            </tr>

        </c:forEach>
</table>
</body>
</html>

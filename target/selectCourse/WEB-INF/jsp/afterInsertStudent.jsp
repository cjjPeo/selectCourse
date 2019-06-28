<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2019/6/26
  Time: 15:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <title>Title</title>
</head>
<body>
<table border="1">
    <tr>
        <td>学号</td>
        <td>姓名</td>
        <td>具体的方向</td>
        <td>状态</td>
        <td>操作</td>
    <tr>
        <c:forEach items="${AllUsers}" var="it">
           <tr>
                <td>${it.userId}</td>
                <td>${it.studentName}</td>
                <td>${it.majorIn}</td>
                <td>课程编号：${it.topicId}课程名称：${it.topicName}课程要求：${it.demand}课程负责老师:${it.teacherName}</td>
                <td><a href="${pageContext.request.contextPath}/teacher/insertStudentToTopic.action?userId=${it.userId}&selectedSignal=${it.selectedSignal}&teacherId=${it.teacherName}&topicId=${topicId}">添加进课程</a> </td>
        </tr>
        </c:forEach>
    </tr>
</table>
</body>
</html>

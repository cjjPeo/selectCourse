<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2019/6/25
  Time: 10:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <title>Title</title>
</head>
<body>
<table  border="1">
    <tr>
        <th>userId</th>
        <th>userName</th>
        <th>className</th>
        <th>majorIn</th>
        <th>操作</th>
    </tr>
    <c:forEach items="${users}" var="it">
        <tr>
            <td>${it.userId}</td>
            <td>${it.userName}</td>
            <td>${it.className}</td>
            <td>${it.majorIn}</td>
            <td><a href="${pageContext.request.contextPath}/teacher/ForUpdateStudentTopic.action?userId=${it.userId}">修改学生的选课</a>
                <a href="${pageContext.request.contextPath}/teacher/deleteStudentFromThisTopic.action?userId=${it.userId}&topicId=${topicId}">从该课程中删除学生</a> </td>
        </tr>
    </c:forEach>
</table>
    <a href="${pageContext.request.contextPath}/teacher/findStudentToTopic.action?topicId=${topicId}">添加学生</a>
点击添加学生以后出现，显示全部学生的选择状态<br>

</body>
</html>

<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2019/6/26
  Time: 14:12
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
        <td>课程编号</td>
        <td>课程</td>
        <td>要求</td>
        <td>方向</td>
        <td>操作</td>
    </tr>
    <c:forEach items="${courseList}" var="it">
       <tr>
           <td>${it.topicId}</td>
        <td>${it.topicName}</td>
        <td>${it.demand}</td>
        <td>${it.majorLimit}</td>
        <td><a href="${pageContext.request.contextPath}/teacher/updateStudentTopic.action?topicId=${it.topicId}&userId=${userId}">添加进该课程</a> </td>
       </tr>
    </c:forEach>
</table>
</body>
</html>

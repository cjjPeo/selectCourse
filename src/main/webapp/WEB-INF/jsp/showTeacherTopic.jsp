<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2019/6/24
  Time: 21:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <title>Title</title>
</head>
<body>
<table border="1"  >
    <tr>
        <th>topicId</th>
        <th>topicName</th>
        <th>demand</th>
        <th>numberLimit</th>
        <th>majorLimit</th>
        <th>发布状态</th>
        <th>操作</th>
    </tr>
    <c:forEach items="${excelList}" var="it">
        <tr>
            <td>${it.topicId}</td>
            <td>${it.topicName}</td>
            <td>${it.demand}</td>
            <td>${it.numberLimit}</td>
            <td>${it.majorLimit}</td><%--显示人数的部分/限制--%>
            <td>${it.releaseSingal}</td>
            <td><a href="${pageContext.request.contextPath}/teacher/getTopicStudent.action?studentList=${it.userDetail}&topicId=${it.topicId}">查看学生</a> </td>
        </tr><%--等待测试--%>
    </c:forEach>
</table>

</body>
</html>

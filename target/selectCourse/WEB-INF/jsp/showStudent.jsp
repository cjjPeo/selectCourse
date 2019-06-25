<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2019/6/25
  Time: 10:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
            <td><a>修改学生的选课</a></td>
        </tr>
    </c:forEach>
    <c:if test="${empty users}">
        <a>添加学生</a>
    </c:if>
</table>
</body>
</html>

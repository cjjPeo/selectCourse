<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2019/6/27
  Time: 23:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<html>
<head>
    <title>Title</title>
</head>
<a href="${pageContext.request.contextPath}/admin/ToInsert.action">增加教师</a>
<a href="${pageContext.request.contextPath}/admin/updateTeacherPassword.action">老师学生管理员全部密码重置</a>
<br>${msg}
<table border="1">
    <tr>
        <th>教师编号</th>
        <th>姓名</th>
        <th>性别</th>
        <th>操作</th>
    </tr>
    <c:forEach items="${teacherList}" var="it">
        <tr>
            <td>${it.userId}</td>
            <td>${it.userName}</td>
            <td>${it.gender}</td>
            <td><a href="${pageContext.request.contextPath}/admin/ToUpdateInsertTeacher,action.action?userId=${it.userId}&userName=${it.userName}&gender=${it.gender}">修改</a> &nbsp;<a href="${pageContext.request.contextPath}/admin/deleteTeacher.action?userId=${it.userId}">删除</a>
            <a href="${pageContext.request.contextPath}/admin/updateTeacherPassword.action?userId=${it.userId}">重置密码</a>
            </td>
        </tr>
    </c:forEach>
</table>
</body>
</html>

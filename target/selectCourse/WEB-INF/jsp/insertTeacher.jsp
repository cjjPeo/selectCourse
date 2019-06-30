<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2019/6/28
  Time: 0:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form action="${pageContext.request.contextPath}/admin/insertTeacher.action">
    编号<input type="text" name="userId" id="userId">
    老师的名字<input type="text" name="userName" id="userName">
    性别<input type="radio" name="gender" value="女">女
    <input type="radio" name="gender" value="男">男

    <input type="submit" value="提交">
</form>
</body>
</html>

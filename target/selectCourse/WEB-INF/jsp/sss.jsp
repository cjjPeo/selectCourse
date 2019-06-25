<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2019/6/13
  Time: 16:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form action="${pageContext.request.contextPath}/teacher/updatePass.action">
    账号：<input type="text" name="userId" value="${userId}" readonly><br>
    密码：<input type="text" name="password"><br>
    <input type="submit" value="提交">
</form>
${msg}
</body>
</html>

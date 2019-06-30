<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2019/6/28
  Time: 1:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body><form action="${pageContext.request.contextPath}/admin/updateTeacher.action">
    <input type="text" value="${userId}" name="userId" readonly>
    <input type="text" value="${userName}" name="userName">
    <input type="text" value="${gender}" name="gender">
    <input type="submit" value="提交">
</form>
</body>
</html>

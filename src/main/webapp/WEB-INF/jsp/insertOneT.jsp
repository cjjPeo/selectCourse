<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2019/6/24
  Time: 21:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form action="${pageContext.request.contextPath}/teacher/insertOneTopic.action">
    topicId <input type="text" name="topicId" id="topicId"><br>
    topicName<input type="text" name="topicName" id="topicName"><br>
    demand<input type="text" name="demand" id="demand"><br>
    numberLimit<input type="text" name="numberLimit" id="numberLimit"><br>
    majorLimit<input type="text" name="majorLimit" id="majorLimit"><br>
    <input type="submit" value="提交"><br>
</form>
</body>
</html>

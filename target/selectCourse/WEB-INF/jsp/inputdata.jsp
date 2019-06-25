<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2019/6/24
  Time: 10:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>

</head>

<body>
<a href="${pageContext.request.contextPath }/teacher/downloadModel.action?filename=数据导入模板.xls">下载导入的模板</a>
<form action="${pageContext.request.contextPath }/teacher/uploadData.action"  method="post" enctype="multipart/form-data" >
    <input type="file" name="uploadFile" id="uploadFile" multiple="multiple" >
    <input type="submit" value="导入数据">
</form>
</body>
</html>

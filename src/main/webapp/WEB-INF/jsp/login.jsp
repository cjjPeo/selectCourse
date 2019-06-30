<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2019/6/5
  Time: 9:37
  To change this template use File | Settings | File Templates.
--%>

<%--<html>--%>
<%--<head>--%>
<%--    <title>登录</title>--%>
<%--</head>--%>
<%--<body>--%>
<%--<form action="${pageContext.request.contextPath}/login/register.action" method="post">--%>
<%--    工号：<input type="text" name="userId">--%>
<%--    密码：<input type="password" name="password">--%>
<%--    身份选择：<input type="radio" name="userState" value="user">学生--%>
<%--                <input type="radio" name="userState" value="teacher">教师--%>
<%--                <input type="radio" name="userState" value="admin">管理员--%>
<%--    <input type="submit" value="登录">--%>
<%--</form>--%>
<%--${msg}电饭锅电饭锅--%>
<%--</body>--%>
<%--</html>--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName()
            + ":" + request.getServerPort() + path + "/";
%>
<html class="loginHtml">
<head>
    <meta charset="utf-8">
    <title>登录</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="icon" href="<%=basePath%>img/favicon.ico">
    <link rel="stylesheet" href="<%=basePath%>layui/css/layui.css" media="all" />
    <link rel="stylesheet" href="<%=basePath%>css/public.css" media="all" />
</head>
    <style>
        .loginBody{ background:url("<%=basePath%>img/bg.jpg") no-repeat center center;}
    </style>

<body class="loginBody">
<form class="layui-form" action="<%=basePath%>login/register.action" method="post">
    <div class="login_face">
        <img src="<%=basePath%>img/101.png" style="position: relative;bottom: -50px;" class="userAvatar">
    </div>
    <div class="layui-form-item input-item">
        <label for="userName">学号/工号</label>
        <input type="text" placeholder="请输入用户名" autocomplete="off" id="userName" name="userId" class="layui-input" lay-verify="required">
    </div>
    <div class="layui-form-item input-item">
        <label for="password">密码</label>
        <input type="password" placeholder="请输入密码" autocomplete="off" id="passWord" name="password" class="layui-input" lay-verify="required">
    </div>
    <div class="layui-form-item input-item">
        <input type="radio" name="userState" value="teacher" title="教师" >
        <input type="radio" name="userState" value="user" title="学生" checked>
        <input type="radio" name="userState" value="admin" title="管理员" >
    </div>
    <div class="layui-form-item">
        <input type="submit" class="layui-btn layui-block" value="登录">
        <%--<button class="layui-btn layui-block" onclick="">登录</button>--%>
    </div>
${msg}

</form>
<script type="text/javascript" src="<%=basePath%>layui/layui.js"></script>
<script type="text/javascript" src="<%=basePath%>js/login.js"></script>

</body>
</html>
<%--
  Created by IntelliJ IDEA.
  User: tutu
  Date: 2019/6/28
  Time: 22:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName()
            + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>教师端-5101在线选课系统</title>
    <link rel="shortcut icon" href="<%=basePath%>img/favicon.ico">
    <link rel="stylesheet" href="<%=basePath%>layui/css/layui.css">
    <link media="(max-width: 600px)" rel="stylesheet" href="<%=basePath%>css/mobile.css">
</head>

<body class="layui-layout-body">

<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo">5101在线选课系统</div>
        <!-- 头部区域（可配合layui已有的水平导航） -->
        <ul class="layui-nav layui-layout-left">
            <li class="layui-nav-item xt"><a href="${pageContext.request.contextPath}/login/student-course-list.action" target="right">教师系统</a></li>
        </ul>
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item">
                <a href="javascript:;">
                    <img src="<%=basePath%>img/01.jpg" class="layui-nav-img">
                    用户
                </a>
                <dl class="layui-nav-child">
                    <dd><a href="${pageContext.request.contextPath}/login/change-password.action" target="right"><i class="layui-icon layui-icon-refresh"></i>&nbsp<cite>修改密码</cite></a></dd>
                    <dd><a href="${pageContext.request.contextPath}/login/notice.action" target="right"><i class="layui-icon layui-icon-speaker"></i>&nbsp<cite>系统公告</cite></a></dd>
                    <dd><a href="${pageContext.request.contextPath}/login/quit.action"><i class="layui-icon layui-icon-return"></i>&nbsp<cite>退出</cite></a></dd>
                </dl>
            </li>

        </ul>
    </div>

    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <ul class="layui-nav layui-nav-tree"  lay-filter="test">
                <li class="layui-nav-item "><a href="${pageContext.request.contextPath}/login/student-course-list.action" target="right">
                    <img src="<%=basePath%>img/全部课程.svg" style="width: 20px;height: 20px;">&nbsp;&nbsp;全部课程
                </a></li>
                <li class="layui-nav-item "><a href="${pageContext.request.contextPath}/teacher/teacher-my-course.action" target="right">
                    <img src="<%=basePath%>img/课程.svg" style="width: 20px;height: 20px;">&nbsp;&nbsp;我的课程
                </a></li>
                <li class="layui-nav-item "><a href="${pageContext.request.contextPath}/teacher/teacher-select-list.action" target="right">
                    <img src="<%=basePath%>img/名称-完成情况.svg" style="width: 20px;height: 20px;">&nbsp;&nbsp;选课情况

                </a></li>
            </ul>
        </div>
    </div>

    <div class="layui-body" style="background: #F2F2F2;">
        <!-- 内容主体区域 -->
        <div style="padding: 15px;">
            <iframe src="${pageContext.request.contextPath}/login/student-course-list.action" name="right" frameborder="0" width="100%" height="600px">
            </iframe>
        </div>
    </div>

    <!-- 显示/隐藏菜单 -->
    <div class="site-tree-mobile" ><i class="layui-icon layui-icon-right"></i></div>
    <div class="site-mobile-shade"></div>

    <div class="layui-footer">
        <!-- 底部固定区域 -->
        底部固定区域
    </div>
</div>
<script src="<%=basePath%>layui/layui.js"></script>
<script src="<%=basePath%>js/side-hide.js"></script>
<script>
    //JavaScript代码区域
    layui.use('element', function(){
        var element = layui.element;

    });
</script>

</body>
</html>


<%--
  Created by IntelliJ IDEA.
  User: tutu
  Date: 2019/6/28
  Time: 18:27
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
    <meta charset="UTF-8">
    <title>我的小组</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="<%=basePath%>layui/css/layui.css">
    <link rel="stylesheet" href="<%=basePath%>css/card.css">
</head>
<body>
<div style="padding: 20px;">
    <div class="layui-row layui-col-space10">
        <div class="layui-col-md12">
            <div class="layui-card group-card" >
                <div class="layui-card-header"><span class="card-title">小组成员1</span></div>
                <div class="layui-card-body" >
                    <div class="myGroup">
                        <div>姓名：<span>屠顺迪</span></div>
                        <div>电话：<span>18888646393</span></div>
                        <div>专业方向：<span>前端方向</span></div>
                    </div>
                </div>
            </div>
            <div class="layui-card group-card" >
                <div class="layui-card-header"><span class="card-title">小组成员2</span></div>
                <div class="layui-card-body" >
                    <div class="myGroup">
                        <div>姓名：<span>陈菁菁</span></div>
                        <div>电话：<span>1XXXXXXXXXX</span></div>
                        <div>专业方向：<span>Java服务器方向</span></div>
                    </div>
                </div>
            </div>
            <div class="layui-card group-card" >
                <div class="layui-card-header"><span class="card-title">小组成员3</span></div>
                <div class="layui-card-body" >
                    <div class="myGroup">
                        <div>姓名：<span>符燕燕</span></div>
                        <div>电话：<span>1XXXXXXXXXX</span></div>
                        <div>专业方向：<span>Java服务器方向</span></div>
                    </div>
                </div>
            </div>
        </div>


    </div>

</div>
</body>
</html>

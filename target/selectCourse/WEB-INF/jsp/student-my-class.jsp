<%--
  Created by IntelliJ IDEA.
  User: tutu
  Date: 2019/6/28
  Time: 18:20
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
    <title>我的课程</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="<%=basePath%>layui/css/layui.css">
    <link rel="stylesheet" href="<%=basePath%>css/card.css">
    <style>

        .myClass  {
            float: left;
        }

    </style>

</head>
<body>
<c:if test="${not empty mytopicmsg}">
<div class="layui-card" >
    <div class="layui-card-header"><span class="card-title">${mytopicmsg.topicName}</span></div>
    <div class="layui-card-body" >
        <div class="myClass" style="line-height:2em;"><input type="text" id="topicId" value="${mytopicmsg.topicId}" hidden>
            <input type="text" id="userId" value="${USER_SESSION.userId}" hidden>
            <div>课题名称：<span>${mytopicmsg.topicName}</span></div>
            <div>发布教师：<span>${mytopicmsg.userName}</span></div>
            <div>学生限制：<span>${mytopicmsg.majorLimit}</span></div>
            <div>课题内容：<span>${mytopicmsg.demand}</span></div>
            <div>课题期限：<span>${mytopicmsg.deadlineString}</span></div>
            <br>
            <button  class="layui-btn layui-btn-normal delClass" onclick="">删除课程</button>
        </div>
    </div>
</div>
</c:if>
<c:if test="${empty mytopicmsg}">
    <div class="layui-card" >无</div>
</c:if>
</body>

<script src="<%=basePath%>layui/layui.js"></script>
<script>
    layui.use(['jquery','layer'],function () {
        var $ =layui.jquery;
        var layer = layui.layer;

        $(".delClass").click(function () {
            var userId=$('#userId').val();
            var topicId=$('#topicId').val();
            layer.confirm('确定删除这门课吗', {
                btn: ['确定','取消'], //按钮
                yes:function () {
                    $.ajax({
                        url:'<%=basePath%>studentChoose/deleteMyChoose.action',
                        type:'get',
                        data:{topicId:topicId,userId:userId},
                        success:function (data) {
                            alert(data);
                            window.location.reload();
                            /*layer.msg('课程添加成功', {icon: 1});*/
                        }
                    })
                }
            }, function(){

            }, function(){
            });
        });

    });
</script>
</html>

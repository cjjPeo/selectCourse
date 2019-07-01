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
<html>
<head>
    <meta charset="utf-8">
    <title>添加课程</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="stylesheet" href="<%=basePath%>layui/css/layui.css" media="all" />
    <link rel="stylesheet" href="<%=basePath%>css/public.css" media="all" />
    <link rel="stylesheet" href="<%=basePath%>css/normal.css">
</head>

<body class="childrenBody">
<div style="padding: 20px;">
    <form class="layui-form linksAdd">
        <div class="layui-form-item">
            <label class="layui-form-label">课题编号</label>
            <div class="layui-input-block">
                <input type="text" class="layui-input courser-name" lay-verify="required" placeholder="请输入课程编号" id="topicId"/>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">课题名称</label>
            <div class="layui-input-block">
                <input type="text" class="layui-input courser-name" lay-verify="required" placeholder="请输入课程名称" id="topicName" />
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">课题限制</label>
            <div class="layui-input-block">
                <input type="text" class="layui-input courser-limit" lay-verify="required" placeholder="请输入课程限制" id="majorLimit" />
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">课题容量</label>
            <div class="layui-input-block " style="width: 50px;">
                <select name="person-limit" id="numberLimit">
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                </select>
            </div>

        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">课程要求</label>
            <div class="layui-input-block">
                <textarea type="text" class="layui-input course-require" lay-verify="required" id="demand"></textarea>
            </div>
        </div>
        <div class="layui-form-item" >
            <button class="layui-btn course-submit" >提交</button>
            <button class="layui-btn layui-btn-primary" >取消</button>
        </div>

    </form>
</div>


<script type="text/javascript" src="<%=basePath%>layui/layui.js"></script>
<script>
    layui.use(['form','layer','jquery'], function(){
        var form = layui.form;
        var layer = layui.layer;
        var $ = layui.jquery;
        $(".course-submit").click(function () {
            var topicId=$("#topicId").val();
            var topicName=$("#topicName").val();
            var majorLimit=$("#majorLimit").val();
            var numberLimit=$("#numberLimit").val();
            var demand=$("#demand").val();
            console.log(topicId+","+topicName+","+majorLimit+","+numberLimit+","+demand)
            $.ajax({
                url:"<%=basePath%>teacher/insertOneTopic.action",
                type:'post',
                data:{topicId:topicId,topicName:topicName,majorLimit:majorLimit,numberLimit:numberLimit,demand:demand},
                success:function (data) {
                    alert(data);
                    console.log(data)
                    window.location.reload();

                }
            })
            var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
            console.log(index);
            parent.layer.close(index);
            /*parent.layer.close(index);*/
        });
        $(".layui-btn-primary").click(function () {
            var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
            console.log(index);
            parent.layer.close(index);
        });


console.log("111")
        form.render();
    });

</script>
</body>
</html>
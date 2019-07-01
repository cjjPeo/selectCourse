<%--
  Created by IntelliJ IDEA.
  User: tutu
  Date: 2019/6/28
  Time: 23:01
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
    <title>密码初始化</title>
    <link rel="stylesheet" href="<%=basePath%>layui/css/layui.css">
    <link media="(max-width: 600px)" rel="stylesheet" href="<%=basePath%>css/mobile.css">

</head>
<body>
<div class="demoTable">
    搜索ID：
    <div class="layui-inline">
        <input class="layui-input" autocomplete="off">
    </div>
    <button class="layui-btn layui-btn-normal" id="password-init" >重置</button>
</div>

<script src="<%=basePath%>layui/layui.js"></script>
<script>
    layui.use(['jquery','layer'],function () {
        var $ =layui.jquery;
        var layer = layui.layer;

        $("#password-init").click(function () {
            var userId=$(this).prev().children().val();

            layer.confirm('确定重置该学生密码吗', {
                btn: ['确定','取消'], //按钮
                yes:function () {
                    $.ajax({
                        url:'<%=basePath%>admin/updateTeacherPassword.action',
                        type:'get',
                        data:{userId:userId},
                        success:function (data) {
                            layer.msg(data);
                        }
                    })
                }
            }, function(){
                layer.msg('密码重置成功', {icon: 1});
            }, function(){
            });
        });

    });
</script>
</body>
</html>

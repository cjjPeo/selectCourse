<%--
  Created by IntelliJ IDEA.
  User: tutu
  Date: 2019/6/28
  Time: 18:32
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
    <title>同通知公告</title>
    <link rel="stylesheet" href="<%=basePath%>layui/css/layui.css">
    <link rel="stylesheet" href="<%=basePath%>css/normal.css">
</head>

<body>
<div class="add-new-notice">
    <button class="layui-btn layui-btn-normal " id="add-new"><i class="layui-icon">&#xe609;</i>新的发布</button>
</div>
<blockquote class="layui-elem-quote layui-bg-green new ">
    <div class="new">
        第一条系统公告
        <div class="fr del-a"><i class="layui-icon layui-icon-close close" ></i></div>
    </div>
</blockquote>
<blockquote class="layui-elem-quote layui-bg-green new">
    <div class="new">
        第二条系统公告
        <div class="fr del-a"><i class="layui-icon layui-icon-close close" ></i></div>
    </div>
</blockquote>


<script src="<%=basePath%>layui/layui.js"></script>
<script>
    layui.use(['jquery','layer'],function () {
        var $ =layui.jquery;
        var layer = layui.layer;


        //添加公告
        $('#add-new').click(function () {

            layer.prompt({
                formType: 2,
                value: '请输入新的公告',
                title: '新的公告',
                area: ['350px', '150px'] //自定义文本域宽高
            }, function(value, index, elem){
                alert(value); //得到value
                layer.close(index);
            });

        });
        //删除公告
        $(".del-a").click(function () {
            $(this).parent().parent().addClass("hide");
        });


    });
</script>
</body>
</html>
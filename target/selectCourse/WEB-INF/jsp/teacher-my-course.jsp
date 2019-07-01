<%--
  Created by IntelliJ IDEA.
  User: tutu
  Date: 2019/6/28
  Time: 22:10
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
    <link rel="stylesheet" href="<%=basePath%>layui/css/layui.css">
    <link rel="stylesheet" href="<%=basePath%>css/card.css">
    <link rel="stylesheet" href="<%=basePath%>css/normal.css">
    <style>

        .myClass  {
            float: left;
        }

    </style>

</head>

<body>
<div style="padding: 10px;">

    <fieldset class="layui-elem-field layui-field-title" >
        <legend>我的课程</legend>
    </fieldset>
    <div class="layui-inline">
        <button class="layui-btn layui-block" id="add-course"><i class="layui-icon layui-icon-add-1"></i>添加新课程</button>
    </div>
    <div style="height: 20px;"></div>
    <c:forEach items="${excelList}" var="it" step="3" varStatus="status">
    <div class="layui-row layui-col-space10">
        <c:forEach items="${excelList}" var="its" begin="${status.index}" end="${status.index+2}" >
        <div class="layui-col-md4">
            <div class="layui-card"  >
                <div class="layui-card-header"><span class="card-title">${its.topicName}</span><span class="fr">发布状态：${its.releaseSingal}</span></div>
                <div class="layui-card-body" >
                    <input type="text" id="topicId" value="${its.topicId}" hidden>
                    <input type="text" id="userId" value="${USER_SESSION.userId}" hidden>
                    <p>招募${its.numberLimit}人：${its.majorLimit}</p>
                </div>
                <div class="detail fl" style="display: block">
                    ${its.demand}
                </div>
                <div class="btn-select">
                    <div class="limit fl">${its.numberNow}/${its.numberLimit}</div>
                    <button  class="layui-btn layui-btn-sm change fr">修改课程</button>
                    <button  class="layui-btn layui-btn-sm layui-btn-danger del fr">删除课程</button>
                </div>
            </div>
        </div>
        </c:forEach>

    </div>
    </c:forEach>
</div>

<script src="<%=basePath%>layui/layui.all.js"></script>
<script>
    layui.use(['jquery','layer'],function () {
        var $ =layui.jquery;
        var layer = layui.layer;
        //显示隐藏课程详细内容
        $(".card-title").click(function(){
            $(this).parent().next().next().slideToggle();
        });
        //添加课程
        $('#add-course').click(function () {
            var index = layui.layer.open({
                title : "添加课程",
                type : 2,
                area: ['80%', '80%'],
                content : "${pageContext.request.contextPath}/login/teacher-add-course.action"
            })
        });
        //修改
        $(".change").click(function () {
            console.log($(this).parent().prev().prev().children(":first").val());
            var index = layui.layer.open({
                title : "修改课程",
                type : 2,
                area: ['80%', '80%'],
                content : "${pageContext.request.contextPath}/teacher/teacher-change-course.action?topicId="+$(this).parent().prev().prev().children(":first").val()
            })
        });
        //删除
        $(".del").click(function () {
            var topicId=$(this).parent().prev().prev().children(":first").val();
            console.log(topicId+"djidj");
            layer.confirm('确定删除吗', {
                btn: ['确定','取消'], //按钮
                yes:function () {
                    $.ajax({
                        url:'<%=basePath%>teacher/deleteTopic.action',
                        type:'get',
                        data:{topicId:topicId},
                        success:function (data) {
                            alert(data);
                            window.location.reload();
                            /*layer.msg('课程添加成功', {icon: 1});*/
                        }
                    });
                }
            }, function(){

            }, function(){
            });
        });

    });


</script>
</body>
</html>
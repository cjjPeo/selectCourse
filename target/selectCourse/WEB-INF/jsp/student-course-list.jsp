<%--
  Created by IntelliJ IDEA.
  User: tutu
  Date: 2019/6/28
  Time: 17:35
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
    <title>课程列表</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="stylesheet" href="<%=basePath%>layui/css/layui.css" media="all" />
    <link rel="stylesheet" href="<%=basePath%>css/public.css" media="all" />
    <link rel="stylesheet" href="<%=basePath%>css/card.css">
    <link rel="stylesheet" href="<%=basePath%>css/normal.css">
    <link media="(max-width: 600px)" rel="stylesheet" href="<%=basePath%>css/mobile.css">

</head>
<style>
    #search-input {
        background-image: url("<%=basePath%>img/搜索.svg");
        background-repeat: no-repeat;
        background-position: 5px 10px;
        background-size:10%;
        padding-left: 28px;
    }
</style>
<body>

<div class="course-list" style="padding: 10px;">
    <blockquote class="layui-elem-quote layui-bg-green new">
        <div class="new">
            点击课题名，查看课题详情
            <div class="fr del-a"><i class="layui-icon layui-icon-close close" ></i></div>
        </div>
    </blockquote>

    <fieldset class="layui-elem-field layui-field-title" >
        <legend>课程列表</legend>
    </fieldset>

    <div class="layui-form-item">
        <form class="layui-form" id="searcheForm" action="${pageContext.request.contextPath}/studentChoose/searchTopic.action">
            <div class="layui-form-item">
                <input type="text" class="layui-input" id="search-input" name="searchText">
                <button class="layui-btn " id="search-button"  lay-filter="login" >查询</button>
            </div>
            <div class="layui-form-item input-item">
                <input type="radio" name="searchFor" value="topicName" title="课程" checked>
                <input type="radio" name="searchFor" value="userName" title="教师" >
            </div>
        </form>
    </div>
    <c:forEach items="${topicList}" var="it" step="3" varStatus="status">
    <div class="layui-row layui-col-space10">
        <c:forEach items="${topicList}" var="its" begin="${status.index}" end="${status.index+2}" >
        <div class="layui-col-md4">
            <div class="layui-card" >
                <div class="layui-card-header"><span class="card-title">${its.topicName}</span><span class="fr">${its.userName}</span></div>
                <div class="layui-card-body" >
		            <input type="text" id="topicId" value="${its.topicId}" hidden>
                    <input type="text" id="userId" value="${USER_SESSION.userId}" hidden>
                    <p>招募${its.numberLimit}人：${its.majorLimit}</p>
                </div>
                <div class="btn-select">
                    <div class="limit fl">${its.numberNow}/${its.numberLimit}</div>
                    <c:if test="${USER_SESSION.userState=='user'}">
                    <button  class="layui-btn layui-btn-normal addClass  fr">添加课程</button></c:if>
                </div>
                <div class="detail fl">
                   ${its.demand}
                </div>
            </div>
        </div>       
        </c:forEach>
    </div>
        <div style="height: 2px;width:100%;float: left;"></div>
    </c:forEach>
    <div style="height: 30px;width:100%;float: left;"></div>
    <div class="layui-col-md12">
        <div  style="margin: 0 auto; width: 410px;"  id="page"></div>
    </div>
</div>

</body>

<script src="<%=basePath%>layui/layui.js"></script>
<script>
    layui.use(['jquery','layer','laypage','form'],function () {
        var $ =layui.jquery;
        var layer = layui.layer;
        var form = layui.form;
        var laypage = layui.laypage;
        //删除公告
        $(".del-a").click(function () {
            $(".new").addClass("hide");
        });



        //显示隐藏课程详细内容
        $(".layui-card-header").click(function(){
            $(this).next().next().next().slideToggle();
            if($(this).parent().hasClass("height-auto")){
                console.log("存在");
                $(this).parent().removeClass("height-auto");
            }else {
                console.log("不存在");
                $(this).parent().addClass("height-auto");
            }
        });
        //询问框

        $(".addClass").click(function () {

console.log($(this).parent().prev().children(":first").val())

        var userId=$('#userId').val();
           var topicId=$(this).parent().prev().children(":first").val();
            layer.confirm('确定选这门课吗', {
                btn: ['确定','取消'] ,//按钮
                yes:function () {
                    $.ajax({
                        url:'<%=basePath%>studentChoose/optTopic.action',
                        type:'get',
                        data:{topicId:topicId,userId:userId},
                        success:function (data) {
                            alert(data);
                            window.location.reload();
                            /*layer.msg('课程添加成功', {icon: 1});*/
                        }
                    });
                }
            }, function(){
                /*layer.msg('课程添加成功', {icon: 1});*/
            }, function(){
            });
        });

        //分页
        laypage.render({
            elem: 'page'
            ,count: 50 //数据总数，从服务端得到
            ,jump: function(obj, first){
                //obj包含了当前分页的所有参数，比如：
                console.log(obj.curr); //得到当前页，以便向服务端请求对应页的数据。
                console.log(obj.limit); //得到每页显示的条数
                //首次不执行
                if(!first){
                    //do something
                }
            }
        });

    });
</script>
<script type="<%=basePath%>js/jquery-1.11.3.min.js"></script>
<%--<script type="text/javascript">
    function searchTopic() {
        $.post("<%=basePath%>login/",$("#searcheForm").serialize(),function(data){
            alert(data)
        })
    }
</script>--%>
</html>

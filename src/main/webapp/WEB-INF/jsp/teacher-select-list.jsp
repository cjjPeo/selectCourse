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
    <title>课程选择情况</title>
    <link rel="stylesheet" href="<%=basePath%>layui/css/layui.css">
    <link rel="stylesheet" href="<%=basePath%>css/normal.css">
    <script>
        function submitform(){
            document.form01.action="${pageContext.request.contextPath}/teacher/uploadData.action";
            document.form01.submit();
        }
    </script>
</head>

<body>
<div style="padding: 10px;">
    <fieldset class="layui-elem-field layui-field-title" >
        <legend>选课情况</legend>
    </fieldset>
    <div class="layui-form-item">
        <input type="text" class="layui-input" id="search-input">
        <button class="layui-btn" id="search-button" >查询</button>
        <a href="${pageContext.request.contextPath }/teacher/downloadModel.action?filename=数据导入模板.xls" class="layui-btn">下载模板</a>
        <input type="text" id="moduleName" value="数据导入模板.xls" hidden>
        <button type="button" class="layui-btn layui-btn-sm layui-btn-normal close" style="float: right;">结束选课</button>
        <span class="fr">
             <form name="form01" method="post" enctype= "multipart/form-data">
                    <input type="hidden" name="xx" value="1" />
                    <label class="layui-btn layui-btn-sm layui-btn-normal" for="file-up" >导入课程信息</label>
                    <input type= "file" name="upfile" onchange="submitform()" id="file-up" />
                </form>
                    <%--<label class="layui-btn layui-btn-sm layui-btn-normal" for="file-up" >导入课程信息</label>
                    <input type="file" id="file-up">--%>
        </span>
    </div>

 <%--   <table class="layui-hide" id="table" lay-filter="test"></table>--%>
    <div class="layui-col-md12" >
        <div class="table">
            <table class="layui-table">
                <colgroup>
                    <col width="150">
                    <col width="100">
                    <col width="100">
                    <col width="100">
                    <col width="150">
                    <col width="150">
                    <col width="150">
                    <col width="150">
                    <col width="200">
                </colgroup>
                <thead>
                <tr>
                    <th>课题编号</th>
                    <th>要求</th>
                    <th>学号</th>
                    <th>姓名</th>
                    <th>方向</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${studentList}" var="it">
                <tr>
                    <td>${it.topicId}</td>
                    <td>${it.demand}</td>
                    <td>${it.userId}</td>
                    <td>${it.studentName}</td>
                    <td>${it.majorIn}</td>
                    <td>
                        <input type="text" id="userId" value="${it.userId}" hidden>
                        <a class="layui-btn layui-btn-xs  adjust" >调整</a>
                        <a class="layui-btn layui-btn-xs layui-btn-danger del" href="${pageContext.request.contextPath }/teacher/deleteStudentFromThisTopic.action?userId=${it.userId}&topicId=${it.topicId}">退选</a>
                    </td>
                </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
        <div style=" margin: 0 auto;width: 410px;" id="page"></div>
    </div>
</div>
<%--<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">
    </div>
</script>--%>
<div id="addModal" style="display: none">
    <div style="padding: 10px;">
        <table class="layui-table" lay-even="" lay-skin="col">
            <colgroup>
                <col width="5%">
                <col width="90%">
                <col width="5%">
            </colgroup>
            <tbody>
            <c:forEach items="${courseList}" var="it">
                <tr>
                    <td>${it.topicId}</td>
                    <td>${it.topicName}</td>
                    <td>
                        <input type="text" id="UuserId" hidden>
                        <input type="radio" name="radio" id="radio" value="${it.topicId}" ></td>
                </tr>
            </c:forEach>

            </tbody>
        </table>
    </div>

</div>
<%--<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit">调整</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">退选</a>
</script>--%>


<script src="<%=basePath%>layui/layui.js"></script>
<script>
    //JavaScript代码区域

    layui.use(['form','jquery','layer','table','element','laypage'],function () {
        var form =layui.form;
        var $ = layui.jquery;
        var table = layui.table;
        var layer = layui.layer;
        var element = layui.element;
        var laypage = layui.laypage;

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
        $(".adjust").click(function () {
            $str=$("#addModal").html();//加载弹窗内容
            var userId=$(this).prev().val()
            $("#UuserId").val(userId)
            layer.open({
                type: 1,                //弹窗类型
                title: '修改信息',     //显示标题
                closeBtn: 1,         //是否显示关闭按钮
                shadeClose: true, //显示模态窗口
                skin: 'layui-layer-rim', //加上边框
                area: ['500px', '550px'], //宽高
                content: $str  //弹窗内容
                ,btn: ['调整', '取消'] //只是为了演示
                ,btn1: function(){
                    var userId=$("#UuserId").val()
                    var rdios=document.getElementsByName("radio");
                    var value;
                    for(var i=0;i<rdios.length;i++){
                        if (rdios[i].checked){
                            value=rdios[i].value
                            break;
                        }
                    }
                    if(value==null) return;
                   /* var topicId=$("#radio").val()*/
                    console.log(userId)
                    console.log(value)
                    /*alert("调整成功");*/
                    $.ajax({
                        url:'<%=basePath%>teacher/updateStudentTopic.action',
                        type:'get',
                        data:{userId:userId,topicId:value},
                        success:function (data) {
                            alert(data)
                            window.location.reload()
                        }
                    })
                    layer.closeAll();
                }
                ,btn2: function(){
                    layer.closeAll();
                }

            });
        });
        $(".close").click(function () {
            $(this).toggleClass("layui-btn-normal");
            if($(this).hasClass("layui-btn-normal")){
                $(this).text("结束选课");
                $.ajax({
                    url:'<%=basePath%>teacher/stopMyTopic.action',
                    type:'get',
                    success:function (data) {
                        alert(data);
                        window.location.reload()

                    }
                })
            }else{
                $(this).text("开放选课");
                $.ajax({
                    url:'<%=basePath%>teacher/startMyTopic.action',
                    type:'get',
                    success:function (data) {
                        alert(data);
                        window.location.reload()

                    }
                })
            }
        });



    });
</script>
</body>
</html>

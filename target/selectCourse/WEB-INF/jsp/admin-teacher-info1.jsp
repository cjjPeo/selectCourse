<%--
  Created by IntelliJ IDEA.
  User: tutu
  Date: 2019/7/1
  Time: 12:04
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
    <title>教师信息</title>
    <link rel="stylesheet" href="<%=basePath%>layui/css/layui.css">
    <link rel="stylesheet" href="<%=basePath%>css/normal.css">
</head>
<body>
教师信息
<label class="layui-btn layui-btn-sm layui-btn-normal" for="file-up" >导入教师信息</label>
<input type="file" id="file-up">

<div class="layui-col-md12" >
    <div class="table">
        <table class="layui-table">
            <colgroup>
                <col width="150">
                <col width="150">
                <col width="150">
                <col width="150">
                <col width="150">
                <col width="150">
                <col width="150">
            </colgroup>
            <thead>
            <tr>
                <th>ID</th>
                <th>姓名</th>
                <th>性别</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${teacherList}" var="it">
            <tr>
                <td>${it.userId}</td>
                <td>${it.userName}</td>
                <td>${it.gender}</td>
                <td>
                    <input type="text" value="${it.userName}" id="userName" hidden>
                    <input type="text" value="${it.gender}" id="gender" hidden>
                    <input type="text" value="${it.userId}" id="userId" hidden>
                    <a class="layui-btn layui-btn-xs edit">编辑</a>
                    <a class="layui-btn layui-btn-xs layui-btn-danger del">删除</a>
                    <br>
                </td>
            </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
    <div style=" margin: 0 auto;width: 410px;" id="page"></div>
</div>


<div id="addModal" style="display: none">

    <div class="" style="padding: 20px;">
        <form class="layui-form linksAdd">
            <div class="layui-form-item">
                <label class="layui-form-label">ID</label>
                <div class="layui-input-block">
                    <input type="text" class="layui-input courser-limit" id="EuserId" value="" readonly />
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">姓名</label>
                <div class="layui-input-block">
                    <input type="text" class="layui-input courser-limit" id="EUserName" value=""/>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">性别</label>
                <div class="layui-input-block">
                    <input type="text" class="layui-input courser-limit" id="Egender" value="" />
                </div>
            </div>
        </form>
    </div>
</div>



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
            ,count: 70 //数据总数，从服务端得到
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
        //弹出层
        $(".edit").click(function () {
            $str=$("#addModal").html();//加载弹窗内容
            var userId=$(this).prev().val()
            var userName=$(this).prev().prev().prev().val()
            var gender=$(this).prev().prev().val()
            $('#EuserId').val(userId);
            $('#EuserName').val(userName);
            $('#Egender').val(gender);
            layer.open({
                type: 1,                //弹窗类型
                title: '修改信息',     //显示标题
                closeBtn: 1,         //是否显示关闭按钮
                shadeClose: true, //显示模态窗口
                skin: 'layui-layer-rim', //加上边框
                area: ['500px', '550px'], //宽高
                content: $str  //弹窗内容
                ,btn: ['修改', '取消'] //只是为了演示
                ,btn1: function(){
                    /*alert("修改成功");*/
                    var userId=$('#EuserId').val();
                    var userName=$('#EuserName').val();
                    var gender=$('#Egender').val();
                    $.ajax({
                        url:'<%=basePath%>admin/updateTeacher.action',
                        type:'get',
                        data:{userId:userId,userName:userName,gender:gender},
                        success:function (data) {
                            alert(data);
                            window.location.reload();
                        }
                    })
                    layer.closeAll();
                }
                ,btn2: function(){
                    layer.closeAll();
                }

            });
        });
        //删除
        $(".del").click(function () {
            $id=$(this).parent().parent().children('td').eq(0).html();
            console.log($id);
            var userId=$(this).prev().prev().val()
            layer.confirm('确定删除吗？', {
                btn: ['确定','取消'], //按钮
                yes:function () {
                    $.ajax({
                        url:'<%=basePath%>admin/deleteTeacher.action',
                        type:'get',
                        data:{userId:userId},
                        success:function (data) {
                            alert(data);
                            window.location.reload();
                        }
                    })
                }
            }, function(){
                layer.msg('删除成功', {icon: 1});
            }, function(){
            });
        });



    });
</script>
</body>
</html>

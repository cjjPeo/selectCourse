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
    <title>学生信息</title>
    <link rel="stylesheet" href="<%=basePath%>layui/css/layui.css">
    <link rel="stylesheet" href="<%=basePath%>css/normal.css">
</head>
<body>
学生信息
<label class="layui-btn layui-btn-sm layui-btn-normal" for="file-up" >导入学生信息</label>
<input type="file" id="file-up">

<table class="layui-hide" id="table" lay-filter="test"></table>
<div class="layui-col-md12" >
    <div style=" margin: 0 auto;width: 410px;" id="page"></div>
</div>

<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">
    </div>
</script>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>


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

        table.render({
            elem: '#table'
            ,url:'<%=basePath%>json/user.json'
            ,toolbar: '#toolbarDemo'
            ,height:430
            ,title: '用户数据表'
            ,cols: [[
                {type:'checkbox',width:80}
                ,{field:'id', width:80, title: 'ID', sort: true}
                ,{field:'username', width:80, title: '姓名',edit:'text'}
                ,{field:'sex', width:80, title: '性别'}
                ,{field:'major', width:80, title: '专业'}
                ,{field:'course', title: '方向', width: '20%', minWidth: 100} //minWidth：局部定义当前单元格的最小宽度
                ,{field:'telephone', title: '联系方式'}
                ,{field:'state', title: '选课状态', sort: true}
                ,{field:'other', title: '其他'}
                ,{width:150,title:'操作',fixed:'right',toolbar:'#barDemo'}
            ]]
        });

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

        //头工具栏事件
        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'getCheckData':
                    var data = checkStatus.data;
                    layer.alert(JSON.stringify(data));
                    break;
                case 'getCheckLength':
                    var data = checkStatus.data;
                    layer.msg('选中了：'+ data.length + ' 个');
                    break;
                case 'isAll':
                    layer.msg(checkStatus.isAll ? '全选': '未全选');
                    break;
            };
        });

        //监听行工具事件
        table.on('tool(test)', function(obj){
            var data = obj.data;
            //console.log(obj)
            if(obj.event === 'del'){
                layer.confirm('真的删除行么', function(index){
                    obj.del();
                    layer.close(index);
                });
            } else if(obj.event === 'edit'){
                layer.prompt({
                    formType: 2
                    ,value: data.email
                }, function(value, index){
                    obj.update({
                        email: value
                    });
                    layer.close(index);
                });
            }
        });


    });
</script>
</body>
</html>

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
            ,url:'<%=basePath%>admin/StudentList.action'
            ,toolbar: '#toolbarDemo'
            ,height:430
            ,title: '学生列表'
            ,cols: [[
                {type:'checkbox',width:80}
                ,{field:'userId',title: '学生学号', width:80, title: 'ID', sort: true}
                ,{field:'userName',title: '学生姓名', width:80, title: '姓名',edit:'text'}
                ,{field:'gender', title: '性别',width:80, title: '性别'}
                ,{field:'enterYear', title: '年份',width:80, title: '专业'}
                ,{field:'className', title: '班级名称', width: '20%', minWidth: 100} //minWidth：局部定义当前单元格的最小宽度
                ,{field:'majorIn', title: '专业方向'}
                ,{field:'selectedSignal', title: '选课标志', sort: true}
                ,{field:'userState', title: '学生身份'}
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
                   /* obj.del();*/
                    var ajax = new jqajax();
                    ajax.options.method = 'POST';
                    ajax.options.contentType="application/json;charset=UTF-8";
                    ajax.options.url = "<%=basePath%>admin/eleteStu.action?userId="+$(this).prev().prev().prev().val();
                    ajax.options.data = obj.data;
                    ajax.ajax(ajax.options);
                    ajax.complete = function (ret, options) {
                        if (ret.httpCode == 200) {
                            layer.msg("删除成功!");
                            layer.close(index);//关闭弹窗
                            //刷新表格 tableId表格id
                            layui.table.reload('taskTable',{page:{curr:1}});
                        }else {
                            layer.msg("删除失败!");
                        }
                    };
                    layer.close(index);
                });
            } else if(obj.event === 'edit'){
                //获取
               var userName,className,majorIn,userId
                layer.prompt({
                    formType: 2
                    ,value: data.email
                }, function(value, index){
                   /* obj.update({
                        email: value
                    });
                    layer.close(index);*/
                    $.ajax({
                        type:'post',
                        url:'<%=basePath%>admin/editStu.action',
                        data:{userName:userName,className:className,majorIn:majorIn,userId:userId},
                        success:function (data) {
                            lay.msg(data);
                        }
                    });
                });
            }
        });


    });
</script>
</body>
</html>

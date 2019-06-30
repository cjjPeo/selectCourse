<%--
  Created by IntelliJ IDEA.
  User: tutu
  Date: 2019/6/28
  Time: 23:00
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
    <title>课程信息</title>
    <link rel="stylesheet" href="<%=basePath%>layui/css/layui.css">
    <link rel="stylesheet" href="<%=basePath%>css/public.css">
    <link rel="stylesheet" href="<%=basePath%>css/normal.css">
</head>
<body>
课程信息
<div class="demoTable">
    <div class="layui-form-item">
        <form class="layui-form">
            <div class="layui-form-item">
                <input type="text" class="layui-input" id="search-input">
                <button class="layui-btn " id="search-button"  lay-filter="login" lay-submit>查询</button>
                <span class="fr">
                    <label class="layui-btn layui-btn-sm layui-btn-normal" for="file-up" >导入课程信息</label>
                    <input type="file" id="file-up">
                </span>
            </div>
            <div class="layui-form-item input-item">
                <input type="radio" name="id" value="t1" title="课程" checked>
                <input type="radio" name="id" value="t2" title="教师" >
                <input type="radio" name="id" value="t3" title="方向" >
                <button type="button" class="layui-btn layui-btn-sm layui-btn-normal close" style="float: right;">结束选课</button>
            </div>
        </form>
    </div>


</div>
<table class="layui-hide" id="table" lay-filter="test"></table>
<div class="layui-col-md12" >
    <div style=" margin: 0 auto;width: 410px;" id="page"></div>
</div>

<script type="text/html" id="toolbarDemo">

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
            ,url:'<%=basePath%>admin/findCourses.action'
            ,toolbar: '#toolbarDemo'
            ,height:430
            ,title: '课程表'
            ,cols: [[
                {type:'checkbox',width:80}
                ,{field:'topicId',title: '课程编号', width:80, title: 'ID', sort: true}
                ,{field:'topicName',title: '课程名', width:80, title: '姓名',edit:'text'}
                ,{field:'demand',title: '要求', width:80, title: '性别'}
                ,{field:'majorLimit',title: '专业限制', width:80, title: '专业'}
                ,{field:'numberLimit', title: '容量限制', width: '20%', minWidth: 100} //minWidth：局部定义当前单元格的最小宽度
                ,{field:'releaseSingal', title: '发布状态'}
                ,{field:'userId', title: '老师编号', sort: true}
                ,{field:'userName', title: '老师姓名'}
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
                    /*obj.del();*/
                    var ajax = new jqajax();
                    ajax.options.method = 'POST';
                    ajax.options.contentType="application/json;charset=UTF-8";
                    ajax.options.url = "<%=basePath%>admin/deleteCourses.action?topicId="+$(this).prev().prev().prev().val();
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
                layer.prompt({
                    formType: 2
                    ,value: data.email
                }, function(value, index){
                    /*obj.update({
                        email: value
                    });
                    layer.close(index);*/
                    var topicName,topicYear,demand,numberLimit,majorLimit,deadline,releaseSingal,topicId
                    $.ajax({
                        type:'post',
                        url:'<%=basePath%>admin/updateTeacher.action',
                        data:{topicName:topicName,topicYear:topicName,demand:demand,numberLimit:demand,majorLimit:majorLimit,deadline:deadline,releaseSingal:releaseSingal,topicId:topicId},
                        success:function (data) {
                            lay.msg(data);
                        }
                    });
                });
            }
        });

        $(".close").click(function () {
            $(this).toggleClass("layui-btn-normal");
            if($(this).hasClass("layui-btn-normal")){
                $(this).text("结束选课");
            }else{
                $(this).text("开放选课");
            }
        });

    });
</script>
</body>
</html>

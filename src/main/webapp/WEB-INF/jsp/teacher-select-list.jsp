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
                        <a class="layui-btn layui-btn-xs edit" >编辑</a>
                        <a class="layui-btn layui-btn-xs layui-btn-danger del" href="${pageContext.request.contextPath }/teacher/deleteStudentFromThisTopic.action?userId=${it.userId}&topicId=${it.topicId}">删除</a>
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

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit">调整</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">退选</a>
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
            ,url:'<%=basePath%>json/teacher-class.json'
            ,toolbar: '#toolbarDemo'
            ,height:430
            ,title: '用户数据表'
            ,cols: [[
                {type:'checkbox',width:80}
                ,{field:'topicId', title: '课题', width: '20%',minWidth: 100}
                ,{field:'topicName', title: 'ID', width: 80}
                ,{field:'demand', width:80, title: '姓名',edit:'text'}
                ,{field:'numberLimit', width:80, title: '性别'}
                ,{field:'majorLimit', width:80, title: '专业'}
                ,{field:'userDetail', title: '方向', width: '10%', minWidth: 100} //minWidth：局部定义当前单元格的最小宽度
                ,{field:'releaseSingal', title: '联系方式'}
                ,{field:'numberNow', title: '其他'}
                ,{width:150,title:'操作',fixed:'right',toolbar:'#barDemo'}
            ]]
            // ,page:true
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
                layer.confirm('真的退选么', function(index){
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

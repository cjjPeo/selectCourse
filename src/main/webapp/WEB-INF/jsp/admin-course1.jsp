<%--
  Created by IntelliJ IDEA.
  User: tutu
  Date: 2019/7/1
  Time: 12:03
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
                <th>课题名称</th>
                <th>要求</th>
                <th>课程限制</th>
                <th>课程容量</th>
                <th>发布状态</th>
                <th>负责教师编号</th>
                <th>负责教师姓名</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${topicList}" var="it">
            <tr>
                <td>${it.topicId}</td>
                <td>${it.topicName}</td>
                <td>${it.demand}</td>
                <td>${it.majorLimit}</td>
                <td>${it.numberLimit}</td>
                <td>${it.releaseSingal}</td>
                <td>${it.userId}</td>
                <td>${it.userName}</td>
                <td>
                    <input type="text" value="${it.topicName}" id="topicName" hidden>
                    <input type="text" value="${it.demand}" id="demand" hidden>
                    <input type="text" value="${it.majorLimit}" id="majorLimit" hidden>
                    <input type="text" value="${it.numberLimit}" id="numberLimit" hidden>
                    <input type="text" value="${it.releaseSingal}" id="releaseSingal" hidden>
                    <input type="text" value="${it.userId}" id="userId" hidden>
                    <input type="text" value="${it.userName}" id="userName" hidden>
                    <input type="text" value="${it.topicId}" id="topicId" hidden>
                    <a class="layui-btn layui-btn-xs edit">编辑</a>
                    <a class="layui-btn layui-btn-xs layui-btn-danger del" >删除</a>
                    <br>
                    <%--F12可以看到删除的是哪个--%>
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
                <label class="layui-form-label">课题编号</label>
                <div class="layui-input-block">
                    <input type="text" class="layui-input courser-name" id="EtopicId" readonly />
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">课题名称</label>
                <div class="layui-input-block">
                    <input type="text" class="layui-input courser-limit"  id="EtopicName"/>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">要求</label>
                <div class="layui-input-block">
                    <input type="text" class="layui-input courser-limit" id="Edemand"/>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">课程限制</label>
                <div class="layui-input-block">
                    <input type="text" class="layui-input courser-limit" id="Emajor" />
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">课程容量</label>
                <div class="layui-input-block">
                    <input type="text" class="layui-input courser-limit"   id="Enumber"/>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">发布状态</label>
                <div class="layui-input-block">
                    <input type="text" class="layui-input courser-limit" id="Erelease"/>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">负责教师编号</label>
                <div class="layui-input-block">
                    <input type="text" class="layui-input courser-limit" id="EuserId" readonly />
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">负责教师姓名</label>
                <div class="layui-input-block">
                    <input type="text" class="layui-input courser-limit" id="EuserName" readonly/>
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
        //开启关闭选课
        $(".close").click(function () {
            $(this).toggleClass("layui-btn-normal");
            if($(this).hasClass("layui-btn-normal")){
                $(this).text("结束选课");
                $.ajax({
                    url:'<%=basePath%>admin/stopAllCourse.action',
                    type:'get',
                    success:function (data) {
                        alert(data);
                    }
                })
            }else{
                $(this).text("开放选课");
                $.ajax({
                    url:'<%=basePath%>admin/startAllCourse.action',
                    type:'get',
                    success:function (data) {
                        alert(data);
                    }
                })
            }
        });
        //弹出层
        $(".edit").click(function () {
            $str=$("#addModal").html();//加载弹窗内容
           /* var topicId=$(this).prev().prev().val()
            var userName=$(this).prev().prev().prev().val()
            var userId=$(this).prev().prev().prev().prev().val()
            var releaseSingal=$(this).prev().prev().prev().prev().prev().val()
            var numberLimit=$(this).prev().prev().prev().prev().prev().prev().val()
            var majorLimit=$(this).prev().prev().prev().prev().prev().prev().prev().val()
            var demand=$(this).prev().prev().prev().prev().prev().prev().prev().prev().val()
            var topicName=$(this).prev().prev().prev().prev().prev().prev().prev().prev().prev().val()*/
            var list=$(this).parent().parent().children('td')
            var topicId=list.eq(0).html()
            var userName=list.eq(7).html()
            var userId=list.eq(6).html()
            var releaseSingal=list.eq(5).html()
            var numberLimit=list.eq(4).html()
            var majorLimit=list.eq(3).html()
            var demand=list.eq(2).html()
            var topicName=list.eq(1).html()
            console.log(topicId)
            /*console.log($(this))*/
            $('#EtopicId').attr({"value":"112"})
            /*$('#EtopicId').valueOf(topicId);
            $('#EuserName').valueOf(userName);
            $('#EuserId').valueOf(userId);
            $('#Erelease').valueOf(releaseSingal);
            $('#Enumber').valueOf(numberLimit);
            $('#Emajor').valueOf(majorLimit);
            $('#Edemand').valueOf(demand);
            $('#EtopicName').valueOf(topicName);*/
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
                    var topicId=$('#EtopicId').val(topicId);
                    var userName=$('#EuserName').val(userName);
                    var userId=$('#EuserId').val(userId);
                    var releaseSingal=$('#Erelease').val(releaseSingal);
                    var numberLimit=$('#Enumber').val(numberLimit);
                    var majorLimit=$('#Emajor').val(majorLimit);
                    var demand=$('#Edemand').val(demand);
                    var demand=$('#EtopicName').val(demand);
                    var deadline=null
                    var topicYear='2019'
                    $.ajax({
                        url:'<%=basePath%>admin/updateTeacher.action',
                        type:'get',
                        data:{ topicId:topicId, topicName:topicName, topicYear:topicYear, demand:demand, numberLimit:numberLimit, majorLimit:majorLimit,deadline:deadline,releaseSingal:releaseSingal},
                        success:function (data) {
                            alert(data);
                            window.location.reload();
                        }
                    })
                   /* alert("修改成功");*/
                    layer.closeAll();
                }
                ,btn2: function(){
                    layer.closeAll();
                }

            });
        });
        //删除
        $(".del").click(function () {
            console.log($(this).parent().parent().children('td').eq(0).html());
            var topicId=$(this).prev().prev().val()
            layer.confirm('确定删除吗？', {
                btn: ['确定','取消'], //按钮
                yes:function () {
                    $.ajax({
                        url:'<%=basePath%>admin/deleteCourses.action',
                        type:'get',
                        data:{topicId:topicId},
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

layui.use(['form','layer','jquery'],function(){
    var form = layui.form,
        layer = parent.layer === undefined ? layui.layer : top.layer
        $ = layui.jquery;

    //登录按钮
    form.on("submit(login)",function(data){
        $(this).text("登录中...").attr("disabled","disabled").addClass("layui-disabled");

        var $check = $('input:radio:checked').val()
        setTimeout(function(){
            if($check == "r1"){
                window.location.href = "../idea-project/page/teacher/teacher.html";
            }
            if($check == "r2"){
                window.location.href = "../idea-project/page/student/student.html";
            }
            if($check == "r3"){
                window.location.href = "../idea-project/page/admin/admini.html";
            }

        },1000);
        return false;
    })

    //表单输入效果
    $(".loginBody .input-item").click(function(e){
        e.stopPropagation();
        $(this).addClass("layui-input-focus").find(".layui-input").focus();
    })
    $(".loginBody .layui-form-item .layui-input").focus(function(){
        $(this).parent().addClass("layui-input-focus");
    })
    $(".loginBody .layui-form-item .layui-input").blur(function(){
        $(this).parent().removeClass("layui-input-focus");
        if($(this).val() != ''){
            $(this).parent().addClass("layui-input-active");
        }else{
            $(this).parent().removeClass("layui-input-active");
        }
    })
})

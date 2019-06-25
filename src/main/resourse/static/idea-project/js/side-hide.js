layui.use(['element','jquery'], function(){
    var element = layui.element;
    var $ = layui.jquery;
    $(".site-tree-mobile").click(function () {
        if($(document.body).hasClass("site-mobile")){
            $(".layui-side").css("display","");
            $(".layui-side-scroll").css("display","");
            $(".site-tree-mobile i").addClass("layui-icon-right");
            $(".site-tree-mobile i").removeClass("layui-icon-left");
            $(document.body).removeClass("site-mobile");
        }else {
            $(".layui-side").css("display","block");
            $(".layui-side-scroll").css("display","block");
            $(".site-tree-mobile i").removeClass("layui-icon-right");
            $(".site-tree-mobile i").addClass("layui-icon-left");
            $(document.body).addClass("site-mobile");

        }

    });

});
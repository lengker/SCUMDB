<%--
  Created by IntelliJ IDEA.
  User: zhuhaipeng
  Date: 2019/11/2
  Time: 15:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<script src="js/jquery-3.4.1.min.js"></script>
<script>
    function register() {
        var mobile = document.getElementById("mobile").value;
        // 通过ajax异步方式 请求服务端
        xmlHttpRequest = new XMLHttpRequest();

        //设置xmlHttpRequest对下的回调函数
        xmlHttpRequest.onreadystatechange = callBack;

        // 服务端地址
        xmlHttpRequest.open("post", "mobile", true)
        // 设置 post方式的头消息
        xmlHttpRequest.setRequestHeader("Content-Type",
            "application/x-www-form-urlencoded")
        xmlHttpRequest.send("mobile=" + mobile)
    }

    // 定义回调函数（接收服务端的返回值）
    function callBack() {
        if (xmlHttpRequest.readyState == 4 && xmlHttpRequest.status == 200) {
            // 接收服务端返回的数据
            var data = xmlHttpRequest.responseText; // 服务端返回值为String格式
            if(data === "true"){
                alert("注册失败，此号码已存在")
            }else{
                alert("注册成功！")
            }
        }
    }


    function register1() {
        var $mobile = $("#mobile").val();
        /*
        $.ajax({
            url:"mobile",
            type:"post",
            data:"mobile="+$mobile,
            success:function (result, testStatus){
                if(result === "true"){
                    alert("此号码已存在")
                }else{
                    alert("注册成功！")
                }
            },
            error:function (xhr, errMessage, e) {
                alert("系统异常")
            }
        });
        */
        // load 加载
        $("#tip").load(
            "mobile",
            "mobile="+$mobile
        );

    }


</script>
<body>


手机号<input id="mobile">
<button value="注册" onclick="register1() " >注册</button>
<span id="tip"></span>
</body>
</html>

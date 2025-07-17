<%@ page import="domain.User" %><%--
  Created by IntelliJ IDEA.
  User: zhuhaipeng
  Date: 2019/11/15
  Time: 14:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    User user = (User) request.getSession().getAttribute("user");
%>

<style>
    .back {
        position: absolute;
        margin-top: -60px;
    }

    .row {
        padding: 0px;
        margin: 0px;
    }

    .list-group-item {
        border: 0px;
        border-radius: 0px;
    }

    a {
        text-decoration: none;
    }
</style>
<div class="row w-100 m-0 p-0">

    <div class="col-md-12 p-0 m-0 overflow-hidden " style="background: url('img/bg.jpg') no-repeat;
            background-position-y: -120px; width: 100%; height: 400px; background-size: cover;">
    </div>
</div>
<div class="row">
    <div class="col-md-12 text-center">
        <img src="img/bg.png" alt="" class="rounded-circle "
             style="width: 150px; height: 150px; margin-top: -75px;">
        <div class="row">
            <a href="main.jsp">
                <span class="iconfont iconxiangzuo back"></span>
            </a>
        </div>
        <div class="row ">
            <dif class="col-md-12 text-center">
                <span><%=user.getUsername()%></span>
                <div class="col-md-4 offset-4">
                    <div class="mt-1 text-secondary" contenteditable="true" id="introduce">
                        <%=user.getIntroduce()%>
                    </div>
                </div>
                <div class="row text-center">
                    <div class="col-md-12">
                        <span class="iconfont iconiconfonticon02" data-toggle="modal" data-target="#avatar-modal"
                              style="top: -70px; margin-left: 150px; position: relative; color: skyblue; font-size: 1.8em;"> </span>
                    </div>

                </div>
            </dif>
        </div>
    </div>
</div>
<div class="row m-4 border-bottom">
    <div class="col-md-12 text-center">
        <div class="col-md-3 " style="margin: 0 auto;">
            <ul class="list-group list-group-horizontal">
                <li class="list-group-item" id="user">
                    <a href="${pageContext.request.contextPath}/userInfo" class="text-secondary">账户信息</a>
                </li>
                <li class="list-group-item " id="history">
                    <a href="${pageContext.request.contextPath}/history" class="text-secondary">历史记录 </a>
                </li>
                <li class="list-group-item " id="collect">
                    <a href="${pageContext.request.contextPath}/collect" class="text-secondary">我的收藏</a>
                </li>
            </ul>
        </div>
    </div>
</div>
<script>
    var url = decodeURI(window.location);
    var type = url.substring(url.lastIndexOf("/") + 1);
    if (type === "history") {
        $("#history").css("border-bottom", "2px solid skyblue")
    }else if(type === "collect"){
        $("#collect").css("border-bottom", "2px solid skyblue")
    }else if(type === "userInfo"){
        $("#user").css("border-bottom", "2px solid skyblue")
    }
</script>
<script src="js/userInfo.js"></script>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>重置密码</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/normalize.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/sign-up-login.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/custom-login.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/font-awesome.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/inputEffect.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/tooltips.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/spop.min.css"/>

    <script src="${pageContext.request.contextPath}/js/jquery-3.4.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/snow.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery.pure.tooltips.js"></script>
    <script src="${pageContext.request.contextPath}/js/spop.min.js"></script>
    <style type="text/css">
        html {
            width: 100%;
            height: 100%;
        }
        body {
            background-repeat: no-repeat;
            background-position: center center;
            background-color: #00BDDC;
            background-image: url(${pageContext.request.contextPath}/images/snow.jpg);
            background-size: 100% 100%;
        }
        .snow-container {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: 100001;
        }
    </style>
</head>
<body>

<!-- 雪花背景 -->
<div class="snow-container"></div>

<div id="login" style="display: flex; justify-content: center; align-items: center;">
    <div class="wrapper" style="width: 400px;">
        <div class="login">
            <form class="container offset1 loginform" action="${pageContext.request.contextPath}/resetPassword" method="post">
                <div class="pad input-container">
                    <h2 style="text-align: center; color: black; margin-bottom: 20px;">重置密码</h2>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger" style="color: red; text-align: center;">${error}</div>
                    </c:if>
                    <c:if test="${not empty message}">
                        <div class="alert alert-success" style="color: green; text-align: center;">${message}</div>
                    </c:if>

                    <input type="hidden" name="email" value="${email}">
                    <section class="content">
                        <span class="input input--hideo">
                            <input class="input__field input__field--hideo" type="text" id="code" name="code" value="${code}" autocomplete="off" placeholder="请输入验证码" required>
                            <label class="input__label input__label--hideo" for="code">
                                <i class="fa fa-fw fa-key icon icon--hideo"></i>
                                <span class="input__label-content input__label-content--hideo"></span>
                            </label>
                        </span>
                        <span class="input input--hideo">
                            <input class="input__field input__field--hideo" type="password" id="password" name="password" autocomplete="off" placeholder="请输入新密码" required>
                            <label class="input__label input__label--hideo" for="password">
                                <i class="fa fa-fw fa-lock icon icon--hideo"></i>
                                <span class="input__label-content input__label-content--hideo"></span>
                            </label>
                        </span>
                        <span class="input input--hideo">
                            <input class="input__field input__field--hideo" type="password" id="confirmPassword" name="confirmPassword" autocomplete="off" placeholder="请确认新密码" required>
                            <label class="input__label input__label--hideo" for="confirmPassword">
                                <i class="fa fa-fw fa-lock icon icon--hideo"></i>
                                <span class="input__label-content input__label-content--hideo"></span>
                            </label>
                        </span>
                    </section>
                </div>
                <div class="form-actions">
                     <a tabindex="3" class="btn pull-left btn-link text-muted" href="${pageContext.request.contextPath}/loginAndRegister.jsp">返回登录</a>
                    <input class="btn btn-primary" type="submit" tabindex="1" value="重置密码" style="color:white;"/>
                </div>
            </form>
        </div>
    </div>
</div>

</body>
</html>

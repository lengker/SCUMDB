<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>找回密码</title>
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
    <div class="wrapper" style="width: 400px">
        <div class="login">
            <form class="container loginform" action="${pageContext.request.contextPath}/forgotPassword" method="post">
                <div class="pad input-container">
                    <h2 style="text-align: center; color: #000000; margin-bottom: 20px;">找回密码</h2>
                    <p style="text-align: center; color: #000000; font-size: 14px;">请输入您的注册邮箱地址，我们将向您发送一封包含重置密码说明的邮件。</p>

                    <c:if test="${not empty message}">
                        <div class="alert alert-success" style="color: #075507; text-align: center;">${message}</div>
                    </c:if>
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger" style="color: #650b0b; text-align: center;">${error}</div>
                    </c:if>

                    <section class="content">
                        <span class="input input--hideo">
                            <input class="input__field input__field--hideo" type="email" id="email" name="email" autocomplete="off" placeholder="请输入邮箱地址" required/>
                            <label class="input__label input__label--hideo" for="email">
                                <i class="fa fa-fw fa-envelope icon icon--hideo"></i>
                                <span class="input__label-content input__label-content--hideo"></span>
                            </label>
                        </span>
                    </section>
                </div>
                <div class="form-actions">
                    <a tabindex="2" class="btn pull-left btn-link text-muted" href="${pageContext.request.contextPath}/loginAndRegister.jsp" style="color: #ccc;">返回登录</a>
                    <input class="btn btn-primary" type="submit" tabindex="1" value="发送邮件" style="color:white;"/>
                </div>
            </form>
        </div>
    </div>
</div>

</body>
</html>

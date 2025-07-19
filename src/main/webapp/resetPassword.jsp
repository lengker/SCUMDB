<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>重置密码</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <style>
        body {
            background: #f7f7f7;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .form-container {
            background: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
        }
        .form-container h2 {
            margin-bottom: 20px;
            text-align: center;
        }
    </style>
</head>
<body>

<div class="form-container">
    <h2>重置您的密码</h2>

    <%-- 显示消息 --%>
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/resetPassword" method="post">
        <%-- 隐藏域用于传递邮箱和验证码 --%>
        <input type="hidden" name="email" value="${email}">

        <div class="form-group">
            <label for="emailCode">验证码</label>
            <input type="text" class="form-control" id="emailCode" name="emailCode" value="${emailCode}" required>
        </div>
        <div class="form-group">
            <label for="password">新密码</label>
            <input type="password" class="form-control" id="password" name="password" required>
        </div>
        <div class="form-group">
            <label for="confirmPassword">确认新密码</label>
            <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
        </div>
        <button type="submit" class="btn btn-primary btn-block">重置密码</button>
    </form>
</div>

</body>
</html>


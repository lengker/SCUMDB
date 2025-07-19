<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>编辑用户 - YCU 电影管理</title>

    <!-- App favicon -->
    <link rel="shortcut icon" href="management/assets/images/favicon.ico">

    <!-- Icons css -->
    <link href="management/assets/libs/@mdi/font/css/materialdesignicons.min.css" rel="stylesheet" type="text/css"/>
    <link href="management/assets/libs/dripicons/webfont/webfont.css" rel="stylesheet" type="text/css"/>
    <link href="management/assets/libs/simple-line-icons/css/simple-line-icons.css" rel="stylesheet" type="text/css"/>

    <!-- App css -->
    <link href="management/assets/css/app.css" rel="stylesheet" type="text/css"/>
    <!-- Custom sidebar css -->
    <link href="management/assets/css/sidebar.css" rel="stylesheet" type="text/css"/>
    

</head>

<body>
<!-- Navigation Bar-->
<header id="topnav">
    <nav class="navbar-custom">
        <div class="container-fluid">
            <!-- Sidebar toggle button for mobile -->
            <div class="sidebar-toggle" id="sidebar-toggle">
                <i class="mdi mdi-menu"></i>
            </div>

            <ul class="list-unstyled topbar-right-menu float-right mb-0">
                <li class="dropdown notification-list">
                    <a class="nav-link dropdown-toggle nav-user" data-toggle="dropdown" href="#" role="button"
                       aria-haspopup="false" aria-expanded="false">
                        <img src="management/assets/images/users/avatar-1.jpg" alt="user" class="rounded-circle"> <span
                            class="ml-1">admin<i class="mdi mdi-chevron-down"></i> </span>
                    </a>
                    <div class="dropdown-menu dropdown-menu-right dropdown-menu-animated profile-dropdown ">
                        <div class="dropdown-item noti-title">
                            <h6 class="text-overflow m-0">Welcome !</h6>
                        </div>
                        <a href="${pageContext.request.contextPath}/logout.do" class="dropdown-item notify-item">
                            <i class="dripicons-power"></i> <span>退出</span>
                        </a>
                    </div>
                </li>
            </ul>

            <ul class="list-inline menu-left mb-0">
                <li class="float-left">
                    <a href="main.jsp" class="logo" style="text-decoration: none; color: #fff; text-align: center">
                        <img src="img/logo.png" alt="" style="height: auto; width: 40px;">
                    </a>
                </li>
            </ul>
        </div>
    </nav>
    <!-- end topbar-main -->
</header>

<!-- Left Sidebar -->
<div id="left-sidebar">
    <div class="sidebar-header">
        <h5 style="color: #fff; padding: 20px; margin: 0; border-bottom: 1px solid rgba(255,255,255,0.1);">菜单</h5>
    </div>
    <ul class="sidebar-menu">
        <li>
            <a href="management/index.jsp">
                <i class="mdi mdi-view-dashboard"></i>
                主页
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/movieManagement">
                <i class="mdi mdi-file-multiple"></i>
                电影管理
            </a>
        </li>
        <li class="active">
            <a href="${pageContext.request.contextPath}/userManagement">
                <i class="mdi mdi-account-multiple"></i>
                用户管理
            </a>
        </li>
    </ul>
</div>

<!-- Sidebar overlay for mobile -->
<div class="sidebar-overlay" id="sidebar-overlay"></div>

<div class="wrapper">
    <div class="container-fluid">
        <!-- Page title box -->
        <div class="page-title-alt-bg"></div>
        <div class="page-title-box">
            <ol class="breadcrumb float-right">
                <li class="breadcrumb-item"><a href="javascript:void(0);">YCU</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/userManagement">用户管理</a></li>
                <li class="breadcrumb-item active">编辑用户</li>
            </ol>
            <h4 class="page-title">编辑用户</h4>
        </div>

        <div class="row">
            <div class="col-12">
                <div class="card-box">
                    <h4 class="header-title mb-4">
                        <i class="mdi mdi-pencil"></i> 编辑用户信息
                    </h4>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="mdi mdi-alert-circle"></i> ${error}
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                    </c:if>

                    <form method="post" action="${pageContext.request.contextPath}/editUser">
                        <input type="hidden" name="originalUsername" value="${user.username}">
                        
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="username">用户名 <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="username" name="username" 
                                           value="${user.username}" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="password">密码 <span class="text-danger">*</span></label>
                                    <input type="password" class="form-control" id="password" name="password" 
                                           value="${user.password}" required>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="email">邮箱</label>
                                    <input type="email" class="form-control" id="email" name="email" 
                                           value="${user.email}">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="phone">电话</label>
                                    <input type="text" class="form-control" id="phone" name="phone"
                                           value="${user.telephone}">
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="gender">性别</label>
                                    <select class="form-control" id="gender" name="gender">
                                        <option value="">请选择</option>
                                        <option value="男" ${user.gender == '男' ? 'selected' : ''}>男</option>
                                        <option value="女" ${user.gender == '女' ? 'selected' : ''}>女</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="age">年龄</label>
                                    <input type="number" class="form-control" id="age" name="age" 
                                           value="${user.age}" min="0" max="150">
                                </div>
                            </div>
                        </div>

                        <div class="form-group text-center">
                            <button type="submit" class="btn btn-primary btn-rounded w-md mr-2">
                                <i class="mdi mdi-content-save"></i> 保存修改
                            </button>
                            <a href="${pageContext.request.contextPath}/userManagement" class="btn btn-secondary btn-rounded w-md">
                                <i class="mdi mdi-arrow-left"></i> 返回
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- jQuery  -->
<script src="js/jquery-3.4.1.min.js"></script>
<script src="js/bootstrap.bundle.min.js"></script>
<script src="management/assets/libs/jquery-slimscroll/jquery.slimscroll.min.js"></script>

<!-- App js -->
<script src="management/assets/js/jquery.core.js"></script>
<script src="management/assets/js/jquery.app.js"></script>

<script>
    $(document).ready(function() {
        // 侧边栏切换功能
        $('#sidebar-toggle').on('click', function() {
            $('#left-sidebar').toggleClass('active');
            $('#sidebar-overlay').toggleClass('active');
        });
        
        $('#sidebar-overlay').on('click', function() {
            $('#left-sidebar').removeClass('active');
            $('#sidebar-overlay').removeClass('active');
        });
        
        // 表单验证
        $('form').on('submit', function(e) {
            var username = $('#username').val().trim();
            var password = $('#password').val().trim();
            var email = $('#email').val().trim();
            var age = $('#age').val().trim();
            
            if (!username) {
                alert('用户名不能为空');
                e.preventDefault();
                return false;
            }
            
            if (!password) {
                alert('密码不能为空');
                e.preventDefault();
                return false;
            }
            
            if (email && !isValidEmail(email)) {
                alert('请输入有效的邮箱地址');
                e.preventDefault();
                return false;
            }
            
            if (age && (isNaN(age) || age < 0 || age > 150)) {
                alert('请输入有效的年龄（0-150）');
                e.preventDefault();
                return false;
            }
        });
        
        function isValidEmail(email) {
            var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            return emailRegex.test(email);
        }
    });
</script>

</body>
</html>

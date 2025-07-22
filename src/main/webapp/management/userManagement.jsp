<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>用户管理 - SCU Movie DB</title>

    <!-- App favicon -->
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/img/logo.png">

    <!-- Icons css -->
    <link href="management/assets/libs/@mdi/font/css/materialdesignicons.min.css" rel="stylesheet" type="text/css"/>
    <link href="management/assets/libs/dripicons/webfont/webfont.css" rel="stylesheet" type="text/css"/>
    <link href="management/assets/libs/simple-line-icons/css/simple-line-icons.css" rel="stylesheet" type="text/css"/>

    <!-- App css -->
    <link href="management/assets/css/app.css" rel="stylesheet" type="text/css"/>
    <!-- Custom sidebar css -->
    <link href="management/assets/css/sidebar.css" rel="stylesheet" type="text/css"/>
    
    <!-- Sweet Alert -->
    <link href="management/assets/libs/sweetalert2/sweetalert2.min.css" rel="stylesheet" type="text/css"/>
    
    <style>
        /* 用户管理页面美化 */
        .avatar-sm {
            width: 32px;
            height: 32px;
            font-size: 14px;
        }

        .user-row:hover {
            background-color: #f8f9fa;
        }

        .badge-pink {
            color: #fff;
            background-color: #e91e63;
        }

        .card {
            border-radius: 8px;
        }

        .table th {
            font-weight: 600;
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .btn-group .btn {
            margin-right: 2px;
        }

        .btn-group .btn:last-child {
            margin-right: 0;
        }

        .form-label {
            font-weight: 500;
            color: #495057;
            margin-bottom: 5px;
        }
    </style>
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
        <li>
            <a href="${pageContext.request.contextPath}/aiAnalysis">
                <i class="mdi mdi-robot"></i>
                智能分析
            </a>
        </li>
    </ul>
</div>
<!-- End Left Sidebar -->

<!-- Sidebar overlay for mobile -->
<div class="sidebar-overlay" id="sidebar-overlay"></div>

<div class="wrapper">
    <div class="container-fluid">
        <!-- Page title box -->
        <div class="page-title-alt-bg"></div>
        <div class="page-title-box">
            <ol class="breadcrumb float-right">
                <li class="breadcrumb-item"><a href="javascript:void(0);">SCU Movie DB</a></li>
                <li class="breadcrumb-item active">用户管理</li>
            </ol>
            <h4 class="page-title">用户管理</h4>
        </div>

        <div class="row">
            <div class="col-12">
                <div class="card-box">
                    <div class="row">
                        <div class="col-md-12">
                            <h4 class="header-title float-left">所有用户</h4>
                            <button type="button" class="btn btn-primary waves-effect w-md mr-2 mb-2 float-right"
                                    onclick="showAddUserModal()">
                                <i class="mdi mdi-account-plus"></i> 添加用户
                            </button>
                        </div>
                        
                        <!-- 成功消息 -->
                        <c:if test="${param.success == 'add'}">
                            <div class="col-md-12">
                                <div class="alert alert-success alert-dismissible fade show" role="alert">
                                    <i class="mdi mdi-check-circle"></i> 用户添加成功！
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                            </div>
                        </c:if>
                        
                        <c:if test="${param.success == 'edit'}">
                            <div class="col-md-12">
                                <div class="alert alert-success alert-dismissible fade show" role="alert">
                                    <i class="mdi mdi-check-circle"></i> 用户信息更新成功！
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                            </div>
                        </c:if>
                        
                        <!-- 错误消息 -->
                        <c:if test="${param.error == 'required'}">
                            <div class="col-md-12">
                                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                    <i class="mdi mdi-alert-circle"></i> 用户名和密码不能为空！
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                            </div>
                        </c:if>
                        
                        <c:if test="${param.error == 'exists'}">
                            <div class="col-md-12">
                                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                    <i class="mdi mdi-alert-circle"></i> 用户名已存在！
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                            </div>
                        </c:if>
                        
                        <c:if test="${param.error == 'database'}">
                            <div class="col-md-12">
                                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                    <i class="mdi mdi-alert-circle"></i> 数据库操作失败！
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                            </div>
                        </c:if>
                    </div>

                    <!-- 筛选表单 -->
                    <div class="row mb-4">
                        <div class="col-md-12">
                            <div class="card border-0 shadow-sm">
                                <div class="card-body">
                                    <h6 class="card-title mb-3">
                                        <i class="mdi mdi-filter-variant text-primary"></i> 筛选用户
                                    </h6>
                                    <form method="get" action="${pageContext.request.contextPath}/userManagement">
                                        <div class="row">
                                            <div class="col-md-3">
                                                <div class="form-group">
                                                    <label for="filterType" class="form-label">筛选类型</label>
                                                    <select name="filterType" id="filterType" class="form-control">
                                                        <option value="">全部用户</option>
                                                        <option value="username" ${filterType == 'username' ? 'selected' : ''}>用户名</option>
                                                        <option value="email" ${filterType == 'email' ? 'selected' : ''}>邮箱</option>
                                                        <option value="gender" ${filterType == 'gender' ? 'selected' : ''}>性别</option>
                                                        <option value="state" ${filterType == 'state' ? 'selected' : ''}>状态</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label for="filterValue" class="form-label">筛选值</label>
                                                    <input type="text" name="filterValue" id="filterValue" class="form-control"
                                                           value="${filterValue}" placeholder="请输入筛选条件">
                                                </div>
                                            </div>
                                            <div class="col-md-5">
                                                <div class="form-group">
                                                    <label class="form-label">&nbsp;</label>
                                                    <div class="d-block">
                                                        <button type="submit" class="btn btn-primary mr-2">
                                                            <i class="mdi mdi-magnify"></i> 筛选
                                                        </button>
                                                        <button type="button" class="btn btn-outline-secondary" onclick="clearFilter()">
                                                            <i class="mdi mdi-refresh"></i> 重置
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="table-responsive">
                        <table id="datatable" class="table table-hover table-centered mb-0" style="table-layout: fixed; width: 100%;">
                            <thead class="thead-light">
                            <tr>
                                <th style="width: 15%;" class="border-top-0">
                                    <i class="mdi mdi-account text-muted mr-1"></i>用户名
                                </th>
                                <th style="width: 20%;" class="border-top-0">
                                    <i class="mdi mdi-email text-muted mr-1"></i>邮箱
                                </th>
                                <th style="width: 15%;" class="border-top-0">
                                    <i class="mdi mdi-phone text-muted mr-1"></i>电话
                                </th>
                                <th style="width: 10%;" class="border-top-0">
                                    <i class="mdi mdi-gender-male-female text-muted mr-1"></i>性别
                                </th>
                                <th style="width: 8%;" class="border-top-0">
                                    <i class="mdi mdi-calendar text-muted mr-1"></i>年龄
                                </th>
                                <th style="width: 10%;" class="border-top-0">
                                    <i class="mdi mdi-check-circle text-muted mr-1"></i>状态
                                </th>
                                <th style="width: 22%;" class="border-top-0">
                                    <i class="mdi mdi-cog text-muted mr-1"></i>操作
                                </th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:choose>
                                <c:when test="${not empty error}">
                                    <tr>
                                        <td colspan="7" class="text-center py-4">
                                            <div class="text-danger">
                                                <i class="mdi mdi-alert-circle-outline h3 mb-2"></i>
                                                <p class="mb-0">${error}</p>
                                            </div>
                                        </td>
                                    </tr>
                                </c:when>
                                <c:when test="${empty allUsers}">
                                    <tr>
                                        <td colspan="7" class="text-center py-5">
                                            <div class="text-muted">
                                                <i class="mdi mdi-account-search h1 mb-3 text-muted"></i>
                                                <h5 class="text-muted">暂无用户数据</h5>
                                                <p class="mb-0">没有找到符合条件的用户，请尝试调整筛选条件</p>
                                            </div>
                                        </td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="user" items="${allUsers}" varStatus="status">
                                        <tr class="user-row">
                                            <td style="word-wrap: break-word; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
                                                <div class="d-flex align-items-center">
                                                    <div class="avatar-sm rounded-circle bg-primary text-white d-flex align-items-center justify-content-center mr-2">
                                                        <i class="mdi mdi-account"></i>
                                                    </div>
                                                    <div>
                                                        <h6 class="mb-0" title="${user.username}">${user.username}</h6>
                                                        <small class="text-muted">ID: ${user.id}</small>
                                                    </div>
                                                </div>
                                            </td>
                                            <td style="word-wrap: break-word; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;" title="${user.email}">
                                                <c:choose>
                                                    <c:when test="${not empty user.email}">
                                                        <i class="mdi mdi-email-outline text-muted mr-1"></i>
                                                        <span>${user.email}</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-muted">未设置</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td style="word-wrap: break-word; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;" title="${user.telephone}">
                                                <c:choose>
                                                    <c:when test="${not empty user.telephone}">
                                                        <i class="mdi mdi-phone text-muted mr-1"></i>
                                                        <span>${user.telephone}</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-muted">未设置</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td style="text-align: center;">
                                                <c:choose>
                                                    <c:when test="${user.gender == '男'}">
                                                        <span class="badge badge-primary">
                                                            <i class="mdi mdi-gender-male mr-1"></i>男
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${user.gender == '女'}">
                                                        <span class="badge badge-pink">
                                                            <i class="mdi mdi-gender-female mr-1"></i>女
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-muted">未设置</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td style="text-align: center;">
                                                <c:choose>
                                                    <c:when test="${user.age > 0}">
                                                        <span class="font-weight-medium">${user.age}岁</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-muted">未设置</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td style="text-align: center;">
                                                <c:choose>
                                                    <c:when test="${user.state == 1}">
                                                        <span class="badge badge-success">
                                                            <i class="mdi mdi-check-circle mr-1"></i>已激活
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge badge-warning">
                                                            <i class="mdi mdi-clock mr-1"></i>未激活
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td style="text-align: center;">
                                                <div class="btn-group" role="group">
                                                    <button type="button" onclick="editUser('${user.username}')"
                                                            class="btn btn-sm btn-outline-primary" title="编辑用户">
                                                        <i class="mdi mdi-pencil"></i>
                                                    </button>
                                                    <button type="button" onclick="deleteUser('${user.username}')"
                                                            class="btn btn-sm btn-outline-danger" title="删除用户">
                                                        <i class="mdi mdi-delete"></i>
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                            </tbody>
                        </table>
                    </div>
                </div> <!-- end card-box -->
            </div> <!-- end col -->
        </div> <!-- end row -->

    </div>
</div>

<!-- 添加用户模态框 -->
<div class="modal fade" id="addUserModal" tabindex="-1" role="dialog" aria-labelledby="addUserModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title" id="addUserModalLabel">
                    <i class="mdi mdi-account-plus mr-2"></i> 添加新用户
                </h5>
                <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form method="post" action="${pageContext.request.contextPath}/addUser">
                <div class="modal-body">
                    <div class="row justify-content-center">
                        <div class="col-md-8">
                            <div class="form-group">
                                <label for="username" class="form-label">
                                    <i class="mdi mdi-account text-muted mr-1"></i>用户名 <span class="text-danger">*</span>
                                </label>
                                <input type="text" class="form-control" id="username" name="username"
                                       placeholder="请输入用户名" required>
                            </div>
                        </div>
                    </div>
                    <div class="row justify-content-center">
                        <div class="col-md-8">
                            <div class="form-group">
                                <label for="password" class="form-label">
                                    <i class="mdi mdi-lock text-muted mr-1"></i>密码 <span class="text-danger">*</span>
                                </label>
                                <input type="password" class="form-control" id="password" name="password"
                                       placeholder="请输入密码" required>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer bg-light">
                    <button type="button" class="btn btn-outline-secondary" data-dismiss="modal">
                        <i class="mdi mdi-close mr-1"></i>取消
                    </button>
                    <button type="submit" class="btn btn-primary">
                        <i class="mdi mdi-content-save mr-1"></i>保存用户
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- jQuery  -->
<script src="js/jquery-3.4.1.min.js"></script>
<script src="js/bootstrap.bundle.min.js"></script>
<script src="management/assets/libs/jquery-slimscroll/jquery.slimscroll.min.js"></script>

<!-- Sweet Alert -->
<script src="management/assets/libs/sweetalert2/sweetalert2.min.js"></script>

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
    });

    // 显示添加用户模态框
    function showAddUserModal() {
        $('#addUserModal').modal('show');
    }

    // 删除用户
    function deleteUser(username) {
        Swal.fire({
            title: '确认删除?',
            text: '您确定要删除用户 "' + username + '" 吗？此操作不可撤销！',
            type: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#d33',
            cancelButtonColor: '#3085d6',
            confirmButtonText: '确定删除',
            cancelButtonText: '取消'
        }).then((result) => {
            if (result.value) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/managementAjax',
                    type: 'POST',
                    data: {
                        choose: 'deleteUser',
                        username: username
                    },
                    success: function(response) {
                        console.log('删除响应:', response);
                        if (response === 'OK') {
                            Swal.fire('删除成功!', '用户已被删除。', 'success').then(() => {
                                location.reload();
                            });
                        } else {
                            Swal.fire('删除失败!', '删除用户时出现错误：' + response, 'error');
                        }
                    },
                    error: function(xhr, status, error) {
                        console.log('删除错误:', xhr, status, error);
                        Swal.fire('删除失败!', '网络错误，请稍后重试。错误信息：' + error, 'error');
                    }
                });
            }
        });
    }

    // 编辑用户
    function editUser(username) {
        window.location.href = '${pageContext.request.contextPath}/editUser?username=' + encodeURIComponent(username);
    }

    // 清除筛选
    function clearFilter() {
        window.location.href = '${pageContext.request.contextPath}/userManagement';
    }

    // 筛选表单验证
    $('form').on('submit', function(e) {
        var filterType = $('#filterType').val();
        var filterValue = $('#filterValue').val().trim();
        
        if (filterType && !filterValue) {
            alert('请输入筛选值');
            e.preventDefault();
            return false;
        }
    });
</script>

</body>
</html>

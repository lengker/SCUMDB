<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>编辑电影 - SCU Movie DB</title>

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

    <style>
        /* 确保页面布局正确 */
        .wrapper {
            margin-left: 250px;
            transition: margin-left 0.3s;
        }

        @media (max-width: 768px) {
            .wrapper {
                margin-left: 0;
            }

            #left-sidebar {
                transform: translateX(-100%);
                transition: transform 0.3s;
            }

            #left-sidebar.active {
                transform: translateX(0);
            }

            .sidebar-overlay {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0,0,0,0.5);
                z-index: 999;
            }

            .sidebar-overlay.active {
                display: block;
            }
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
                        <img src="assets/images/users/avatar-1.jpg" alt="user" class="rounded-circle"> <span
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
        </div>
    </nav>
</header>

<!-- Left Sidebar -->
<div id="left-sidebar">
    <div class="sidebar-header">
        <h5 style="color: #fff; padding: 20px; margin: 0; border-bottom: 1px solid rgba(255,255,255,0.1);">菜单</h5>
    </div>
    <ul class="sidebar-menu">
        <li>
            <a href="index.jsp">
                <i class="mdi mdi-view-dashboard"></i>
                主页
            </a>
        </li>
        <li class="active">
            <a href="${pageContext.request.contextPath}/movieManagement">
                <i class="mdi mdi-file-multiple"></i>
                电影管理
            </a>
        </li>
        <li>
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
                <li class="breadcrumb-item"><a href="javascript:void(0);">SCU Movie DB</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/movieManagement">电影管理</a></li>
                <li class="breadcrumb-item active">编辑电影</li>
            </ol>
            <h4 class="page-title">编辑电影</h4>
        </div>

        <div class="row">
            <div class="col-12">
                <div class="card-box">
                    <h4 class="header-title mb-4">
                        <i class="mdi mdi-pencil"></i> 编辑电影信息
                    </h4>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="mdi mdi-alert-circle"></i> ${error}
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                    </c:if>

                    <form method="post" action="${pageContext.request.contextPath}/editMovie">
                        <input type="hidden" name="originalName" value="${movie.name}">
                        
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="name">电影名称 <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="name" name="name" 
                                           value="${movie.name}" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="score">评分</label>
                                    <input type="number" class="form-control" id="score" name="score" 
                                           value="${movie.score}" step="0.1" min="0" max="10">
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="director">导演</label>
                                    <input type="text" class="form-control" id="director" name="director" 
                                           value="${movie.director}">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="scriptwriter">编剧</label>
                                    <input type="text" class="form-control" id="scriptwriter" name="scriptwriter" 
                                           value="${movie.scriptwriter}">
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="actor">主演</label>
                            <input type="text" class="form-control" id="actor" name="actor" 
                                   value="${movie.actor}">
                        </div>

                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="years">上映年份</label>
                                    <input type="text" class="form-control" id="years" name="years" 
                                           value="${movie.years}">
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="country">上映国家</label>
                                    <input type="text" class="form-control" id="country" name="country" 
                                           value="${movie.country}">
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="languages">语言</label>
                                    <input type="text" class="form-control" id="languages" name="languages" 
                                           value="${movie.languages}">
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="length">片长 (分钟)</label>
                                    <input type="number" class="form-control" id="length" name="length" 
                                           value="${movie.length}" min="0">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="type">类型</label>
                                    <select class="form-control" id="type" name="type">
                                        <option value="">请选择类型</option>
                                        <option value="动作" ${movie.type == '动作' ? 'selected' : ''}>动作</option>
                                        <option value="科幻" ${movie.type == '科幻' ? 'selected' : ''}>科幻</option>
                                        <option value="喜剧" ${movie.type == '喜剧' ? 'selected' : ''}>喜剧</option>
                                        <option value="剧情" ${movie.type == '剧情' ? 'selected' : ''}>剧情</option>
                                        <option value="动画" ${movie.type == '动画' ? 'selected' : ''}>动画</option>
                                        <option value="恐怖" ${movie.type == '恐怖' ? 'selected' : ''}>恐怖</option>
                                        <option value="悬疑" ${movie.type == '悬疑' ? 'selected' : ''}>悬疑</option>
                                        <option value="奇幻" ${movie.type == '奇幻' ? 'selected' : ''}>奇幻</option>
                                        <option value="爱情" ${movie.type == '爱情' ? 'selected' : ''}>爱情</option>
                                        <option value="惊悚" ${movie.type == '惊悚' ? 'selected' : ''}>惊悚</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="image">电影海报URL</label>
                            <input type="url" class="form-control" id="image" name="image" 
                                   value="${movie.image}">
                        </div>

                        <div class="form-group">
                            <label for="url">播放地址</label>
                            <input type="url" class="form-control" id="url" name="url" 
                                   value="${movie.url}">
                        </div>

                        <div class="form-group">
                            <label for="des">电影描述</label>
                            <textarea class="form-control" id="des" name="des" rows="4">${movie.des}</textarea>
                        </div>

                        <div class="form-group text-center">
                            <button type="submit" class="btn btn-primary btn-rounded w-md mr-2">
                                <i class="mdi mdi-content-save"></i> 保存修改
                            </button>
                            <a href="${pageContext.request.contextPath}/movieManagement" class="btn btn-secondary btn-rounded w-md">
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
            var name = $('#name').val().trim();
            var score = $('#score').val().trim();
            var years = $('#years').val().trim();

            if (!name) {
                alert('电影名称不能为空');
                e.preventDefault();
                return false;
            }

            if (score && (isNaN(score) || score < 0 || score > 10)) {
                alert('评分应该是0-10之间的数字');
                e.preventDefault();
                return false;
            }

            if (years && (isNaN(years) || years < 1900 || years > new Date().getFullYear() + 5)) {
                alert('请输入有效的年份');
                e.preventDefault();
                return false;
            }
        });
    });
</script>

</body>
</html>

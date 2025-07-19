<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>YCU 电影管理</title>
    <link href="management/assets/libs/datatables.net-bs4/css/dataTables.bootstrap4.min.css" rel="stylesheet"
          type="text/css"/>
    <link href="management/assets/libs/datatables.net-responsive-bs4/css/responsive.bootstrap4.min.css" rel="stylesheet"
          type="text/css"/>
    <link href="management/assets/libs/datatables.net-buttons-bs4/css/buttons.bootstrap4.min.css" rel="stylesheet"
          type="text/css"/>
    <link href="management/assets/libs/datatables.net-select-bs4/css/select.bootstrap4.min.css" rel="stylesheet"
          type="text/css"/>

    <!-- Sweet Alert css -->
    <link href="management/assets/libs/sweetalert2/sweetalert2.min.css" rel="stylesheet" type="text/css"/>

    <!-- App favicon -->
    <link rel="shortcut icon" href="img/logo.png">

    <!-- Custom box css -->
    <link href="management/assets/libs/custombox/custombox.min.css" rel="stylesheet">

    <!-- Icons css -->
    <link href="management/assets/libs/@mdi/font/css/materialdesignicons.min.css" rel="stylesheet" type="text/css"/>
    <link href="management/assets/libs/dripicons/webfont/webfont.css" rel="stylesheet" type="text/css"/>
    <link href="management/assets/libs/simple-line-icons/css/simple-line-icons.css" rel="stylesheet" type="text/css"/>


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
                    <a class="nav-link dropdown-toggle arrow-none" data-toggle="dropdown" href="#" role="button"
                       aria-haspopup="false" aria-expanded="false">
                        <i class="dripicons-bell noti-icon"></i>
                        <span class="badge badge-danger badge-pill noti-icon-badge">4</span>
                    </a>
                    <div class="dropdown-menu dropdown-menu-right dropdown-menu-animated dropdown-lg">

                        <!-- item-->
                        <div class="dropdown-item noti-title">
                            <h5 class="m-0"><span class="float-right"><a href="" class="text-dark"><small>Clear
                                                All</small></a> </span>Notification</h5>
                        </div>

                        <div class="slimscroll noti-scroll">
                            <!-- item-->
                            <a href="javascript:void(0);" class="dropdown-item notify-item">
                                <div class="notify-icon bg-warning"><i class="mdi mdi-comment-account-outline"></i>
                                </div>
                                <p class="notify-details">Caleb Flakelar commented on Admin<small
                                        class="text-muted">1 min ago</small></p>
                            </a>

                            <!-- item-->
                            <a href="javascript:void(0);" class="dropdown-item notify-item">
                                <div class="notify-icon bg-info"><i class="mdi mdi-account-plus"></i></div>
                                <p class="notify-details">New user registered.<small class="text-muted">5 hours
                                    ago</small></p>
                            </a>

                            <!-- item-->
                            <a href="javascript:void(0);" class="dropdown-item notify-item">
                                <div class="notify-icon"><img src="management/assets/images/users/avatar-2.jpg"
                                                              class="img-fluid rounded-circle" alt=""/></div>
                                <p class="notify-details">Cristina Pride</p>
                                <p class="text-muted font-13 mb-0 user-msg">Hi, How are you? What about our next
                                    meeting</p>
                            </a>

                            <!-- item-->
                            <a href="javascript:void(0);" class="dropdown-item notify-item">
                                <div class="notify-icon bg-danger"><i class="mdi mdi-comment-account-outline"></i>
                                </div>
                                <p class="notify-details">Caleb Flakelar commented on Admin<small
                                        class="text-muted">4 days ago</small></p>
                            </a>

                            <!-- item-->
                            <a href="javascript:void(0);" class="dropdown-item notify-item">
                                <div class="notify-icon"><img src="management/assets/images/users/avatar-4.jpg"
                                                              class="img-fluid rounded-circle" alt=""/></div>
                                <p class="notify-details">Karen Robinson</p>
                                <p class="text-muted font-13 mb-0 user-msg">Wow that's great</p>
                            </a>

                            <!-- item-->
                            <a href="javascript:void(0);" class="dropdown-item notify-item">
                                <div class="notify-icon bg-primary"><i class="mdi mdi-heart"></i></div>
                                <p class="notify-details">Carlos Crouch liked <b>Admin</b><small
                                        class="text-muted">13 days ago</small></p>
                            </a>
                        </div>

                        <!-- All-->
                        <a href="javascript:void(0);"
                           class="dropdown-item text-center text-primary notify-item notify-all">
                            View all <i class="fi-arrow-right"></i>
                        </a>

                    </div>
                </li>

                <li class="dropdown notification-list">
                    <a class="nav-link dropdown-toggle nav-user" data-toggle="dropdown" href="#" role="button"
                       aria-haspopup="false" aria-expanded="false">
                        <img src="management/assets/images/users/avatar-1.jpg" alt="user" class="rounded-circle"> <span
                            class="ml-1">${user.username}<i class="mdi mdi-chevron-down"></i> </span>
                    </a>
                    <div class="dropdown-menu dropdown-menu-right dropdown-menu-animated profile-dropdown ">
                        <!-- item-->
                        <div class="dropdown-item noti-title">
                            <h6 class="text-overflow m-0">Welcome !</h6>
                        </div>

                        <!-- item-->
                        <a href="javascript:void(0);" class="dropdown-item notify-item">
                            <i class="dripicons-user"></i> <span>My Account</span>
                        </a>

                        <!-- item-->
                        <a href="javascript:void(0);" class="dropdown-item notify-item">
                            <i class="dripicons-gear"></i> <span>Settings</span>
                        </a>

                        <!-- item-->
                        <a href="javascript:void(0);" class="dropdown-item notify-item">
                            <i class="dripicons-help"></i> <span>Support</span>
                        </a>

                        <!-- item-->
                        <a href="management/auth-lock-screen.html" class="dropdown-item notify-item">
                            <i class="dripicons-lock"></i> <span>Lock Screen</span>
                        </a>

                        <!-- item-->
                        <a href="${pageContext.request.contextPath}/logout.do" class="dropdown-item notify-item">
                            <i class="dripicons-power"></i> <span>退出</span>
                        </a>

                    </div>
                </li>
                <li class="dropdown notification-list">
                    <a href="javascript:void(0);" class="nav-link right-bar-toggle">
                        <i class="dripicons-gear noti-icon"></i>
                    </a>
                </li>

            </ul>

            <ul class="list-inline menu-left mb-0">
                <li class="float-left">
                    <a href="main.jsp" class="logo" style="text-decoration: none; color: #fff; text-align: center">
                        <img src="img/logo.png" alt="" style="height: auto; width: 40px;">
                        <%-- <span class="logo-lg">
                             <img src="assets/images/logo.png" alt="" height="20">
                         </span>
                         <span class="logo-sm">
                             <img src="assets/images/logo_sm.png" alt="" height="28">
                         </span>--%>
                    </a>
                </li>

            </ul>
        </div>

    </nav>
    <!-- end topbar-main -->
</header>
<!-- End Navigation Bar-->

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
                <li class="breadcrumb-item"><a href="javascript:void(0);">YCU</a></li>
                <li class="breadcrumb-item active">电影管理</li>
            </ol>
            <h4 class="page-title">电影管理</h4>
        </div>
        <div class="row">
            <div class="col-12">
                <div class="card-box">
                    <div class="row w-100">
                        <div class="col-md-12">
                            <h4 class="header-title float-left">所有电影</h4>
                            <a href="#custom-modal" class="btn btn-primary waves-effect w-md mr-2 mb-2 float-right"
                               data-animation="blur" data-plugin="custommodal"
                               data-overlaySpeed="100" data-overlayColor="#36404a">添加电影</a>
                        </div>

                        <!-- 成功消息 -->
                        <c:if test="${param.success == 'edit'}">
                            <div class="col-md-12">
                                <div class="alert alert-success alert-dismissible fade show" role="alert">
                                    <i class="mdi mdi-check-circle"></i> 电影信息更新成功！
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                            </div>
                        </c:if>

                        <!-- 筛选和排序控件 -->
                        <div class="col-md-12 mb-3">
                            <form method="get" action="${pageContext.request.contextPath}/movieManagement">
                                <div class="row">
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <label for="type">电影类型:</label>
                                            <select name="type" id="type" class="form-control">
                                                <option value="">全部类型</option>
                                                <option value="动作" ${filterType == '动作' ? 'selected' : ''}>动作</option>
                                                <option value="科幻" ${filterType == '科幻' ? 'selected' : ''}>科幻</option>
                                                <option value="喜剧" ${filterType == '喜剧' ? 'selected' : ''}>喜剧</option>
                                                <option value="剧情" ${filterType == '剧情' ? 'selected' : ''}>剧情</option>
                                                <option value="动画" ${filterType == '动画' ? 'selected' : ''}>动画</option>
                                                <option value="恐怖" ${filterType == '恐怖' ? 'selected' : ''}>恐怖</option>
                                                <option value="悬疑" ${filterType == '悬疑' ? 'selected' : ''}>悬疑</option>
                                                <option value="奇幻" ${filterType == '奇幻' ? 'selected' : ''}>奇幻</option>
                                                <option value="爱情" ${filterType == '爱情' ? 'selected' : ''}>爱情</option>
                                                <option value="惊悚" ${filterType == '惊悚' ? 'selected' : ''}>惊悚</option>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="col-md-2">
                                        <div class="form-group">
                                            <label for="years">上映年份:</label>
                                            <input type="text" name="years" id="years" class="form-control"
                                                   value="${filterYears}" placeholder="如: 2019">
                                        </div>
                                    </div>

                                    <div class="col-md-2">
                                        <div class="form-group">
                                            <label for="country">上映国家:</label>
                                            <input type="text" name="country" id="country" class="form-control"
                                                   value="${filterCountry}" placeholder="如: 美国">
                                        </div>
                                    </div>

                                    <div class="col-md-2">
                                        <div class="form-group">
                                            <label for="minScore">最低评分:</label>
                                            <input type="number" name="minScore" id="minScore" class="form-control"
                                                   value="${filterMinScore}" placeholder="如: 8.0" step="0.1" min="0" max="10">
                                        </div>
                                    </div>


                                </div>

                                <div class="row mt-2">
                                    <div class="col-md-12">
                                        <button type="submit" class="btn btn-success mr-2">
                                            <i class="mdi mdi-filter"></i> 筛选
                                        </button>
                                        <a href="${pageContext.request.contextPath}/movieManagement" class="btn btn-secondary">
                                            <i class="mdi mdi-refresh"></i> 重置
                                        </a>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                    <table id="datatable" class="table table-bordered dt-responsive nowrap" style="table-layout: fixed; width: 100%;">
                        <thead>
                        <tr>
                            <th style="width: 25%;">名字</th>
                            <th style="width: 8%;">评分</th>
                            <th style="width: 15%;">导演</th>
                            <th style="width: 10%;">上映日期</th>
                            <th style="width: 12%;">上映国家</th>
                            <th style="width: 10%;">类型</th>
                            <th style="width: 20%;">删除 / 修改</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:choose>
                            <c:when test="${not empty error}">
                                <tr>
                                    <td colspan="7" class="text-center text-danger">
                                        <i class="mdi mdi-alert-circle"></i> ${error}
                                    </td>
                                </tr>
                            </c:when>
                            <c:when test="${empty allMovies}">
                                <tr>
                                    <td colspan="7" class="text-center text-muted">
                                        <i class="mdi mdi-information"></i> 没有找到符合条件的电影
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="movie" items="${allMovies}" varStatus="status">
                                    <tr>
                                        <td style="word-wrap: break-word; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
                                            <strong title="${movie.name}">${movie.name}</strong>
                                        </td>
                                        <td style="text-align: center;">
                                            <span class="badge badge-${movie.score >= 8 ? 'success' : movie.score >= 6 ? 'warning' : 'danger'}">
                                                ${movie.score}
                                            </span>
                                        </td>
                                        <td style="word-wrap: break-word; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;" title="${movie.director}">
                                            ${movie.director}
                                        </td>
                                        <td style="text-align: center;">
                                            <span class="badge badge-info">${movie.years}</span>
                                        </td>
                                        <td style="word-wrap: break-word; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;" title="${movie.country}">
                                            ${movie.country}
                                        </td>
                                        <td style="text-align: center;">
                                            <span class="badge badge-secondary">${movie.type}</span>
                                        </td>
                                        <td style="text-align: center;">
                                            <button type="button" onclick="deleteMovie('${movie.name}')"
                                                    class="btn btn-sm btn-icon btn-danger" title="删除">
                                                <span><i class="mdi mdi-delete"></i></span>
                                            </button>
                                            <button type="button" onclick="editMovie('${movie.name}')"
                                                    class="btn btn-sm btn-icon btn-warning" title="编辑">
                                                <i class="mdi mdi-pencil"></i>
                                            </button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                        </tbody>
                    </table>
                </div> <!-- end card-box -->
            </div> <!-- end col -->
        </div> <!-- end row -->

    </div>
</div>
<!-- Custom Modal -->
<div id="custom-modal" class="modal-demo" style="margin-top: 20%; height: 860px">
    <button type="button" class="close" onclick="Custombox.modal.close();">
        <span>&times;</span><span class="sr-only">Close</span>
    </button>
    <h4 class="custom-modal-title">添加电影</h4>
    <form class="form-horizontal m-2" method="post"
          action="${pageContext.request.contextPath}/managementAjax?choose=insert"
          enctype="multipart/form-data">
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">电影名</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" value="" name="name">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">评分</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" value="" name="score">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">导演</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" value="" name="director">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">编剧</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" value="" name="scriptwriter">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">演员</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" value="" name="actor">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">上映日期</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" value="" name="years">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">上映国家</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" value="" name="country">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">语言</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" value="" name="languages">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">片长</label>
            <div class="col-sm-10">
                <input class="form-control" type="number" name="length">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">电影海报图片</label>
            <div class="col-sm-10">
                <input type="file" class="form-control" name="image"
                       accept="image/gif,image/jpeg,image/jpg,image/png,image/svg">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">电影描述</label>
            <div class="col-sm-10">
                <textarea class="form-control" rows="5" name="des"></textarea>
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">播放地址</label>
            <div class="col-sm-10">
                <input class="form-control" type="url" name="url">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">类型</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" value="" name="type">
            </div>
        </div>
        <div class="form-group row ">
            <div class="col-md-12 text-center align-content-center">
                <button type="submit" class="btn btn-primary btn-rounded w-md">提交</button>
            </div>
        </div>
    </form>
</div>
</body>
<!-- jQuery  -->
<script src="js/jquery-3.4.1.min.js"></script>
<script src="js/bootstrap.bundle.min.js"></script>
<script src="management/assets/libs/jquery-slimscroll/jquery.slimscroll.min.js"></script>

<!-- Datatable js -->
<script src="management/assets/libs/datatables.net/js/jquery.dataTables.min.js"></script>
<script src="management/assets/libs/datatables.net-bs4/js/dataTables.bootstrap4.min.js"></script>
<script src="management/assets/libs/datatables.net-buttons/js/dataTables.buttons.min.js"
        type="text/javascript"></script>
<%--<script src="management/assets/libs/datatables.net-responsive/js/dataTables.responsive.min.js"></script>--%>
<%--<script src="management/assets/libs/datatables.net-responsive-bs4/js/responsive.bootstrap4.min.js"></script>--%>

<!-- Sweet Alert Js  -->
<script src="management/assets/libs/sweetalert2/sweetalert2.min.js"></script>
<script src="management/assets/js/jquery.sweet-alert.init.js"></script>

<!-- Modal-Effect -->
<script src="management/assets/libs/custombox/custombox.min.js"></script>


<!-- App js -->
<script src="management/assets/js/jquery.core.js"></script>
<script src="management/assets/js/jquery.app.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        // Default Datatable
        $('#datatable').DataTable({
            keys: true,
            "pageLength": 10,
            "searching": true,
            "lengthChange": true,
            "info": true,
            "autoWidth": false,
            "responsive": true
        });

    });

    // 删除电影
    function deleteMovie(movieName) {
        Swal.fire({
            title: '确认删除?',
            text: '您确定要删除电影 "' + movieName + '" 吗？此操作不可撤销！',
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
                        choose: 'delete',
                        movieName: movieName
                    },
                    success: function(response) {
                        console.log('删除响应:', response);
                        if (response === 'OK') {
                            Swal.fire('删除成功!', '电影已被删除。', 'success').then(() => {
                                location.reload();
                            });
                        } else {
                            Swal.fire('删除失败!', '删除电影时出现错误：' + response, 'error');
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

    // 编辑电影
    function editMovie(movieName) {
        window.location.href = '${pageContext.request.contextPath}/editMovie?movieName=' + encodeURIComponent(movieName);
    }

    // 筛选表单提交前验证
    $('form').on('submit', function(e) {
        var minScore = $('#minScore').val().trim();
        var years = $('#years').val().trim();

        // 验证评分格式
        if (minScore) {
            var score = parseFloat(minScore);
            if (isNaN(score) || score < 0 || score > 10) {
                e.preventDefault();
                Swal.fire({
                    title: '评分格式错误',
                    text: '评分应该是0-10之间的数字',
                    type: 'warning'
                });
                return false;
            }
        }

        // 验证年份格式
        if (years) {
            var year = parseInt(years);
            if (isNaN(year) || year < 1900 || year > new Date().getFullYear() + 5) {
                e.preventDefault();
                Swal.fire({
                    title: '年份格式错误',
                    text: '请输入有效的年份 (1900-' + (new Date().getFullYear() + 5) + ')',
                    type: 'warning'
                });
                return false;
            }
        }
    });

</script>

</html>
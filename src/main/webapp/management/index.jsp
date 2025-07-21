<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8"/>
    <title>SCU Movie DB - 后台管理</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description"/>
    <meta content="Coderthemes" name="author"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <!-- App favicon -->
    <link rel="shortcut icon" href="../img/logo.png">

    <!-- jvectormap -->
    <link href="assets/libs/jqvmap/jqvmap.min.css" rel="stylesheet"/>

    <!-- DataTables -->
    <link href="assets/libs/datatables.net-bs4/css/dataTables.bootstrap4.min.css" rel="stylesheet" type="text/css"/>
    <link href="assets/libs/datatables.net-responsive-bs4/css/responsive.bootstrap4.min.css" rel="stylesheet"
          type="text/css"/>

    <!-- Icons css -->
    <link href="assets/libs/@mdi/font/css/materialdesignicons.min.css" rel="stylesheet" type="text/css"/>
    <link href="assets/libs/dripicons/webfont/webfont.css" rel="stylesheet" type="text/css"/>
    <link href="assets/libs/simple-line-icons/css/simple-line-icons.css" rel="stylesheet" type="text/css"/>

    <!-- App css -->
    <!-- build:css -->
    <link href="assets/css/app.css" rel="stylesheet" type="text/css"/>
    <!-- Custom sidebar css -->
    <link href="assets/css/sidebar.css" rel="stylesheet" type="text/css"/>
    <!-- endbuild -->

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
                            class="ml-1">${user.username}<i class="mdi mdi-chevron-down"></i> </span>
                    </a>
                    <div class="dropdown-menu dropdown-menu-right dropdown-menu-animated profile-dropdown ">
                        <!-- item-->
                        <div class="dropdown-item noti-title">
                            <h6 class="text-overflow m-0">Welcome !</h6>
                        </div>
                        <!-- 仅保留退出 -->
                        <a href="${pageContext.request.contextPath}/logout.do" class="dropdown-item notify-item">
                            <i class="dripicons-power"></i> <span>退出</span>
                        </a>

                    </div>
                </li>

            </ul>

            <ul class="list-inline menu-left mb-0">
                <li class="float-left">
                    <a href="../main.jsp" class="logo" style="text-decoration: none; color: #fff; text-align: center">
                        <img src="../img/logo.png" alt="" style="height: auto; width: 40px;">
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
        <li class="active">
            <a href="index.jsp">
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
                <li class="breadcrumb-item active">主页</li>
            </ol>
            <h4 class="page-title">主页</h4>
        </div>
        <!-- End page title box -->
        <!-- ===== Dashboard Stats & Charts ===== -->
        <div class="row mt-3">
            <div class="col-12 col-md-6 mb-4">
                <div class="card-box shadow-sm text-center h-100">
                    <h4 class="header-title">电影总数</h4>
                    <h2 class="font-weight-light mt-3 mb-0" id="movieCount">--</h2>
                </div>
            </div>
            <div class="col-12 col-md-6 mb-4">
                <div class="card-box shadow-sm text-center h-100">
                    <h4 class="header-title">用户总数</h4>
                    <h2 class="font-weight-light mt-3 mb-0" id="userCount">--</h2>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-12 col-lg-6 mb-4">
                <div class="card-box shadow-sm h-100" style="min-height:420px;">
                    <h4 class="header-title text-center mb-3">电影类型分布</h4>
                    <div class="chartjs-chart">
                        <canvas id="movieTypeDistributionChart" height="320" style="width:100%; height:320px;"></canvas>
                    </div>
                </div>
            </div>
            <div class="col-12 col-lg-6 mb-4">
                <div class="card-box shadow-sm h-100" style="min-height:420px;">
                    <h4 class="header-title text-center mb-3">点击量最高</h4>
                    <div class="chartjs-chart">
                        <canvas id="topMoviesChart" height="320" style="width:100%; height:320px;"></canvas>
                    </div>
                </div>
            </div>
        </div>
        <!-- ===== End Dashboard Stats & Charts ===== -->


        <!-- jQuery  -->
        <script src="assets/libs/jquery/jquery.min.js"></script>
        <script src="assets/libs/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="assets/libs/jquery-slimscroll/jquery.slimscroll.min.js"></script>

        <!-- KNOB JS -->
        <script src="assets/libs/jquery-knob/jquery.knob.min.js"></script>
        <!-- Chart JS -->
        <script src="assets/libs/chart.js/Chart.bundle.min.js"></script>

        <!-- Jvector map -->
        <script src="assets/libs/jqvmap/jquery.vmap.min.js"></script>
        <script src="assets/libs/jqvmap/maps/jquery.vmap.usa.js"></script>

        <!-- Datatable js -->
        <script src="assets/libs/datatables.net/js/jquery.dataTables.min.js"></script>
        <script src="assets/libs/datatables.net-bs4/js/dataTables.bootstrap4.min.js"></script>
        <script src="assets/libs/datatables.net-responsive/js/dataTables.responsive.min.js"></script>
        <script src="assets/libs/datatables.net-responsive-bs4/js/responsive.bootstrap4.min.js"></script>

        <!-- Dashboard Init JS -->
        <script src="assets/js/jquery.dashboard.js"></script>

        <!-- App js -->
        <script src="assets/js/jquery.core.js"></script>
        <script src="assets/js/jquery.app.js"></script>
        <script>
            $(document).ready(function () {
                // Default Datatable
                $('#datatable').DataTable({
                    "pageLength": 5,
                    "searching": false,
                    "lengthChange": false
                });

                $.ajax({
                    url: "${pageContext.request.contextPath}/dashboardStats",
                    method: "GET",
                    dataType: "json",
                    success: function(data) {
                        // Update counts
                        $('#movieCount').text(data.movieCount);
                        $('#userCount').text(data.userCount);

                        // Top movies bar chart
                        var topMoviesCtx = document.getElementById('topMoviesChart').getContext('2d');
                        new Chart(topMoviesCtx, {
                            type: 'bar',
                            data: {
                                labels: data.topMovies.map(m => m.movieName),
                                datasets: [{
                                    label: '点击量',
                                    data: data.topMovies.map(m => m.number),
                                    backgroundColor: 'rgba(54, 162, 235, 0.6)'
                                }]
                            },
                            options: {
                                responsive: true,
                                maintainAspectRatio: false,
                                legend: { display: false },
                                tooltips: {
                                    callbacks: {
                                        title: function(tooltipItems, data) {
                                            return data.labels[tooltipItems[0].index];
                                        }
                                    }
                                },
                                scales: {
                                    xAxes: [{
                                        ticks: {
                                            autoSkip: false,
                                            maxRotation: 45,
                                            minRotation: 45,
                                            callback: function(label) {
                                                return label.length > 6 ? label.substr(0, 6) + '…' : label;
                                            }
                                        }
                                    }],
                                    yAxes: [{
                                        ticks: { beginAtZero: true }
                                    }]
                                }
                            }
                        });

                        // Movie type distribution pie chart
                        var movieTypeCtx = document.getElementById('movieTypeDistributionChart').getContext('2d');
                        var baseColors = ['#ff6384','#36a2eb','#ffce56','#4bc0c0','#9966ff','#ff9f40'];
                        var bgColors = [];
                        for (var i = 0; i < data.movieTypeDistribution.length; i++) {
                            bgColors.push(baseColors[i % baseColors.length]);
                        }
                        new Chart(movieTypeCtx, {
                            type: 'pie',
                            data: {
                                labels: data.movieTypeDistribution.map(d => d.type),
                                datasets: [{
                                    data: data.movieTypeDistribution.map(d => d.count),
                                    backgroundColor: bgColors
                                }]
                            },
                            options: {responsive: true, maintainAspectRatio: false}
                        });
                    }
                });
            });
            var date = new Date().toLocaleString();
            $("#time").text(date);
        </script>

</body>

</html>
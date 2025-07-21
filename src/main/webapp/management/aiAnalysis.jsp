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
    <title>SCU Movie DB - 智能分析</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description"/>
    <meta content="Coderthemes" name="author"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <!-- App favicon -->
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/img/logo.png">

    <!-- Icons css -->
    <link href="${pageContext.request.contextPath}/management/assets/libs/@mdi/font/css/materialdesignicons.min.css" rel="stylesheet" type="text/css"/>
    <link href="${pageContext.request.contextPath}/management/assets/libs/dripicons/webfont/webfont.css" rel="stylesheet" type="text/css"/>
    <link href="${pageContext.request.contextPath}/management/assets/libs/simple-line-icons/css/simple-line-icons.css" rel="stylesheet" type="text/css"/>

    <!-- App css -->
    <link href="${pageContext.request.contextPath}/management/assets/css/app.css" rel="stylesheet" type="text/css"/>
    <!-- Custom sidebar css -->
    <link href="${pageContext.request.contextPath}/management/assets/css/sidebar.css" rel="stylesheet" type="text/css"/>
    <style>
        .chat-container {
            display: flex;
            flex-direction: column;
            height: 70vh;
            border: 1px solid #ddd;
            border-radius: 5px;
            overflow: hidden;
        }
        .chat-box {
            flex-grow: 1;
            padding: 20px;
            overflow-y: auto;
            background-color: #f9f9f9;
        }
        .chat-message {
            margin-bottom: 15px;
            display: flex;
        }
        .chat-message .message-content {
            padding: 10px 15px;
            border-radius: 15px;
            max-width: 70%;
        }
        .chat-message.user .message-content {
            background-color: #dcf8c6;
            align-self: flex-end;
            margin-left: auto;
        }
        .chat-message.bot .message-content {
            background-color: #fff;
            border: 1px solid #ddd;
        }
        .chat-input {
            display: flex;
            padding: 10px;
            border-top: 1px solid #ddd;
        }
        .chat-input input {
            flex-grow: 1;
            border-radius: 20px;
            border: 1px solid #ddd;
            padding: 10px 15px;
        }
        .chat-input button {
            margin-left: 10px;
        }
    </style>
</head>

<body>

<!-- Navigation Bar-->
<header id="topnav">
    <nav class="navbar-custom">
        <div class="container-fluid">
            <div class="sidebar-toggle" id="sidebar-toggle">
                <i class="mdi mdi-menu"></i>
            </div>
            <ul class="list-unstyled topbar-right-menu float-right mb-0">
                <li class="dropdown notification-list">
                    <a class="nav-link dropdown-toggle nav-user" data-toggle="dropdown" href="#" role="button"
                       aria-haspopup="false" aria-expanded="false">
                        <img src="${pageContext.request.contextPath}/management/assets/images/users/avatar-1.jpg" alt="user" class="rounded-circle"> <span
                            class="ml-1">${user.username}<i class="mdi mdi-chevron-down"></i> </span>
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
                    <a href="${pageContext.request.contextPath}/management/index.jsp" class="logo" style="text-decoration: none; color: #fff; text-align: center">
                        <img src="${pageContext.request.contextPath}/img/logo.png" alt="" style="height: auto; width: 40px;">
                    </a>
                </li>
            </ul>
        </div>
    </nav>
</header>
<!-- End Navigation Bar-->

<!-- Left Sidebar -->
<div id="left-sidebar">
    <div class="sidebar-header">
        <h5 style="color: #fff; padding: 20px; margin: 0; border-bottom: 1px solid rgba(255,255,255,0.1);">菜单</h5>
    </div>
    <ul class="sidebar-menu">
        <li>
            <a href="${pageContext.request.contextPath}/management/index.jsp">
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
        <li class="active">
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
                <li class="breadcrumb-item"><a href="javascript:void(0);">SCU Movie</a></li>
                <li class="breadcrumb-item active">智能分析</li>
            </ol>
            <h4 class="page-title">智能分析</h4>
        </div>
        <!-- End page title box -->

        <div class="row">
            <div class="col-12">
                <div class="card-box">
                    <div class="chat-container">
                        <div class="chat-box" id="chat-box">
                            <div class="chat-message bot">
                                <div class="message-content">
                                    你好！我是您的数据分析助手，有什么可以帮助您的吗？
                                </div>
                            </div>
                        </div>
                        <div class="chat-input">
                            <input type="text" id="user-input" placeholder="输入您的问题...">
                            <button class="btn btn-primary" id="send-button">发送</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- jQuery  -->
<script src="${pageContext.request.contextPath}/management/assets/libs/jquery/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/management/assets/libs/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/management/assets/libs/jquery-slimscroll/jquery.slimscroll.min.js"></script>

<!-- App js -->
<script src="${pageContext.request.contextPath}/management/assets/js/jquery.core.js"></script>
<script src="${pageContext.request.contextPath}/management/assets/js/jquery.app.js"></script>

<script>
    $(document).ready(function () {
        function sendMessage() {
            var userInput = $('#user-input').val();
            if (userInput.trim() === '') {
                return;
            }

            // Display user message
            $('#chat-box').append('<div class="chat-message user"><div class="message-content">' + userInput + '</div></div>');
            $('#user-input').val('');
            
            // Scroll to bottom
            $('#chat-box').scrollTop($('#chat-box')[0].scrollHeight);

            // Send to backend and get response
            $.ajax({
                url: '${pageContext.request.contextPath}/aiAnalysis',
                method: 'POST',
                data: {
                    prompt: userInput
                },
                beforeSend: function() {
                    $('#chat-box').append('<div class="chat-message bot" id="loading-indicator"><div class="message-content">正在思考中...</div></div>');
                    $('#chat-box').scrollTop($('#chat-box')[0].scrollHeight);
                },
                success: function (response) {
                    $('#loading-indicator').remove();
                    // Display bot response
                    $('#chat-box').append('<div class="chat-message bot"><div class="message-content">' + response + '</div></div>');
                    // Scroll to bottom
                    $('#chat-box').scrollTop($('#chat-box')[0].scrollHeight);
                },
                error: function () {
                     $('#loading-indicator').remove();
                    $('#chat-box').append('<div class="chat-message bot"><div class="message-content">抱歉，我暂时无法回答您的问题。</div></div>');
                    // Scroll to bottom
                    $('#chat-box').scrollTop($('#chat-box')[0].scrollHeight);
                }
            });
        }

        $('#send-button').click(function () {
            sendMessage();
        });

        $('#user-input').keypress(function (e) {
            if (e.which === 13) {
                sendMessage();
            }
        });
    });
</script>

</body>
</html>
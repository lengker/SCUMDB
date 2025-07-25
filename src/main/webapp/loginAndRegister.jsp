<%@ page language="java" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>登录</title>
    <link rel="stylesheet" href="css/normalize.css">
    <link rel="stylesheet" href="css/login.css">
    <link rel="stylesheet" href="css/sign-up-login.css">
    <link rel="stylesheet" href="css/custom-login.css">
    <link rel="stylesheet" type="text/css" href="css/font-awesome.min.css">
    <link rel="stylesheet" href="css/inputEffect.css"/>
    <link rel="stylesheet" href="css/tooltips.css"/>
    <link rel="stylesheet" href="css/spop.min.css"/>

    <script src="js/jquery-3.4.1.min.js"></script>
    <script src="js/snow.js"></script>
    <script src="js/jquery.pure.tooltips.js"></script>
    <script src="js/spop.min.js"></script>
    <script>
        (function () {
            // trim polyfill : https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/Trim
            if (!String.prototype.trim) {
                (function () {
                    // Make sure we trim BOM and NBSP
                    var rtrim = /^[\s\uFEFF\xA0]+|[\s\uFEFF\xA0]+$/g;
                    String.prototype.trim = function () {
                        return this.replace(rtrim, '');
                    };
                })();
            }

            [].slice.call(document.querySelectorAll('input.input__field')).forEach(function (inputEl) {
                // in case the input is already filled..
                if (inputEl.value.trim() !== '') {
                    classie.add(inputEl.parentNode, 'input--filled');
                }

                // events:
                inputEl.addEventListener('focus', onInputFocus);
                inputEl.addEventListener('blur', onInputBlur);
            });

            function onInputFocus(ev) {
                classie.add(ev.target.parentNode, 'input--filled');
            }

            function onInputBlur(ev) {
                if (ev.target.value.trim() === '') {
                    classie.remove(ev.target.parentNode, 'input--filled');
                }
            }
        })();

        $(function () {
            $('#login #login-password').focus(function () {
                $('.login-owl').addClass('password');
            }).blur(function () {
                $('.login-owl').removeClass('password');
            });
            $('#login #register-password').focus(function () {
                $('.register-owl').addClass('password');
            }).blur(function () {
                $('.register-owl').removeClass('password');
            });
            $('#login #register-repassword').focus(function () {
                $('.register-owl').addClass('password');
            }).blur(function () {
                $('.register-owl').removeClass('password');
            });

            const urlParams = new URLSearchParams(window.location.search);
            const message = urlParams.get('message');
            const show = urlParams.get('show');

            <%
                String sessionMessage = (String) session.getAttribute("message");
                if (sessionMessage != null) {
            %>
            spop({
                template: '<h4 class="spop-title"><%= sessionMessage %></h4>',
                position: 'top-center',
                style: 'success',
                autoclose: 4000
            });
            <%
                    session.removeAttribute("message");
                }
            %>

            if (show === 'login') {
                $("#tab-1").prop("checked", true);
            }
        });

        function goto_register() {
            $("#register-username").val("");
            $("#register-password").val("");
            $("#register-repassword").val("");
            $("#register-code").val("");
            $("#tab-2").prop("checked", true);
        }

        function goto_login() {
            $("#login-username").val("");
            $("#login-password").val("");
            $("#tab-1").prop("checked", true);
        }

        function login() { //登录
            var username = $("#login-username").val(),
                password = $("#login-password").val(),
                validatecode = null,
                flag = true;
            //判断用户名密码是否为空
            if (username == "") {
                $.pt({
                    target: $("#login-username"),
                    position: 'r',
                    align: 't',
                    width: 'auto',
                    height: 'auto',
                    content: "用户名不能为空"
                });
                flag = false;
            }
            if (password == "") {
                $.pt({
                    target: $("#login-password"),
                    position: 'r',
                    align: 't',
                    width: 'auto',
                    height: 'auto',
                    content: "密码不能为空"
                });
                flag = false;
            }
            //用户名只能是15位以下的字母或数字
            var regExp = new RegExp("^[a-zA-Z0-9_]{1,15}$");
            if (!regExp.test(username)) {
                $.pt({
                    target: $("#login-username"),
                    position: 'r',
                    align: 't',
                    width: 'auto',
                    height: 'auto',
                    content: "用户名必须为15位以下的字母或数字"
                });
                flag = false;
            }

            if (!flag) {
                return false;
            } else { //登录
                //调用后台登录验证的方法
                return true;
            }
        }

        //注册
        function register() {
            var username = $("#register-username").val(),
                password = $("#register-password").val(),
                repassword = $("#register-repassword").val(),
                email = $("#r_email").val(),
                captcha = $("#r_captcha").val(),
                flag = true;

            //判断用户名密码是否为空
            if (username === "") {
                $.pt({
                    target: $("#register-username"),
                    position: 'r',
                    align: 't',
                    width: 'auto',
                    height: 'auto',
                    content: "用户名不能为空"
                });
                flag = false;
            }
            if (password === "") {
                $.pt({
                    target: $("#register-password"),
                    position: 'r',
                    align: 't',
                    width: 'auto',
                    height: 'auto',
                    content: "密码不能为空"
                });
                flag = false;
            } else {
                if (password !== repassword) {
                    $.pt({
                        target: $("#register-repassword"),
                        position: 'r',
                        align: 't',
                        width: 'auto',
                        height: 'auto',
                        content: "两次输入的密码不一致"
                    });
                    flag = false;
                }
            }
            //用户名只能是15位以下的字母或数字
            var regExp = new RegExp("^[a-zA-Z0-9_]{1,15}$");
            if (!regExp.test(username)) {
                $.pt({
                    target: $("#register-username"),
                    position: 'r',
                    align: 't',
                    width: 'auto',
                    height: 'auto',
                    content: "用户名必须为15位以下的字母或数字"
                });
                flag = false;
            }

            if (!flag) {
                return false; // Prevent form submission
            }

            // 使用 fetch API 代替 $.ajax
            fetch("${pageContext.request.contextPath}/register", {
                method: "POST",
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: "username=" + encodeURIComponent(username) + "&password=" + encodeURIComponent(password) + "&email=" + encodeURIComponent(email) + "&captcha=" + encodeURIComponent(captcha)
            })
            .then(response => response.text())
            .then(data => {
                if (data === "success") {
                    spop({
                        template: '<h4 class="spop-title">注册成功</h4>即将于3秒后返回登录',
                        position: 'top-center',
                        style: 'success',
                        autoclose: 3000,
                        onOpen: function () {
                            var second = 2;
                            var showPop = setInterval(function () {
                                if (second == 0) {
                                    clearInterval(showPop);
                                }
                                $('.spop-body').html('<h4 class="spop-title">注册成功</h4>即将于' + second +
                                    '秒后返回登录');
                                second--;
                            }, 1000);
                        },
                        onClose: function () {
                            goto_login();
                        }
                    });
                } else {
                    // 使用 spop 插件显示错误信息
                    spop({
                        template: '<h4 class="spop-title">注册失败</h4>' + data,
                        position: 'top-center',
                        style: 'error',
                        autoclose: 3000
                    });
                    refreshRegisterCaptcha();
                }
            })
            .catch(error => {
                console.error('Error:', error);
                spop({
                    template: '<h4 class="spop-title">注册失败</h4>发生未知错误，请稍后重试。',
                    position: 'top-center',
                    style: 'error',
                    autoclose: 3000
                });
            });

            return false; // 阻止表单默认提交
        }

        function refreshRegisterCaptcha() {
            document.getElementById('registerCaptchaImage').src = '${pageContext.request.contextPath}/captcha?' + new Date().getTime();
        }
    </script>
    <style type="text/css">
        html {
            width: 100%;
            height: 100%;
        }

        body {

            background-repeat: no-repeat;

            background-position: center center #2D0F0F;

            background-color: #00BDDC;

            background-image: url(images/snow.jpg);

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
<%
    String s = (String) request.getServletContext().getAttribute("msg");
    if(s != null){

%>
<script>
    $(document).ready(function () {
        alert("此账号在别处登录，你已被踢下线，请重新登录");
    })
</script>
<%
        request.getServletContext().removeAttribute("msg");
    }
%>
<!-- 雪花背景 -->
<div class="snow-container"></div>
<!-- 登录控件 -->
<div id="login">
    <input id="tab-1" type="radio" name="tab" class="sign-in hidden" checked/>
    <input id="tab-2" type="radio" name="tab" class="sign-up hidden"/>
    <input id="tab-3" type="radio" name="tab" class="sign-out hidden"/>
    <div class="wrapper">
        <!-- 登录页面 -->
        <div class="login sign-in-htm">
            <form id="form1" class="container offset1 loginform" action="${pageContext.request.contextPath}/login.do"
                  method="post" onsubmit="return login()">
                <!-- 猫头鹰控件 -->
                <div id="owl-login" class="login-owl">
                    <div class="hand"></div>
                    <div class="hand hand-r"></div>
                    <div class="arms">
                        <div class="arm"></div>
                        <div class="arm arm-r"></div>
                    </div>
                </div>
                <div class="pad input-container">
                    <section class="content">
							<span class="input input--hideo">
								<input class="input__field input__field--hideo" type="text" id="login-username"
                                       autocomplete="off" placeholder="请输入用户名" tabindex="1" maxlength="15"
                                       name="username"/>
								<label class="input__label input__label--hideo" for="login-username">
									<i class="fa fa-fw fa-user icon icon--hideo"></i>
									<span class="input__label-content input__label-content--hideo"></span>
								</label>
							</span>
                        <span class="input input--hideo">
								<input class="input__field input__field--hideo" type="password" id="login-password"
                                       placeholder="请输入密码" tabindex="2" maxlength="15" name="password"/>
								<label class="input__label input__label--hideo" for="login-password">
									<i class="fa fa-fw fa-lock icon icon--hideo"></i>
									<span class="input__label-content input__label-content--hideo"></span>
								</label>
							</span>
                    </section>
                    <%
                        String message = (String) request.getAttribute("register_meesage");
                        if (message != null) {
                    %>
                    <span style="color: red; font-size: 1em;"><%=message %></span>
                    <%
                        }
                    %>
                </div>
                <div class="form-actions">
                    <a tabindex="4" class="btn pull-left btn-link text-muted" href="${pageContext.request.contextPath}/forgotPassword.jsp">忘记密码?</a>
                    <a tabindex="5" class="btn btn-link text-muted" onClick="goto_register()">注册</a>
                    <input class="btn btn-primary" type="submit" tabindex="3" value="登录"
                           style="color:white;"/>
                </div>
            </form>
        </div>
        <!-- 注册页面 -->
        <div class="login sign-up-htm">
            <form id="form2"
                  method="post" class="container offset1 loginform" onsubmit="return register()">
                <!-- 猫头鹰控件 -->
                <div id="owl-login" class="register-owl">
                    <div class="hand"></div>
                    <div class="hand hand-r"></div>
                    <div class="arms">
                        <div class="arm"></div>
                        <div class="arm arm-r"></div>
                    </div>
                </div>
                <div class="pad input-container">
                    <section class="content">
							<span class="input input--hideo">
								<input class="input__field input__field--hideo" type="text" id="register-username"
                                       autocomplete="off" placeholder="请输入用户名" maxlength="15" name="username"/>
								<label class="input__label input__label--hideo" for="register-username">
									<i class="fa fa-fw fa-user icon icon--hideo"></i>
									<span class="input__label-content input__label-content--hideo"></span>
								</label>
							</span>
                        <span class="input input--hideo">
								<input class="input__field input__field--hideo" type="password" id="register-password"
                                       placeholder="请输入密码" maxlength="15" name="password"/>
								<label class="input__label input__label--hideo" for="register-password">
									<i class="fa fa-fw fa-lock icon icon--hideo"></i>
									<span class="input__label-content input__label-content--hideo"></span>
								</label>
							</span>
                        <span class="input input--hideo">
								<input class="input__field input__field--hideo" type="password" id="register-repassword"
                                       placeholder="请确认密码" maxlength="15" name="confirmPassword"/>
								<label class="input__label input__label--hideo" for="register-repassword">
									<i class="fa fa-fw fa-lock icon icon--hideo"></i>
									<span class="input__label-content input__label-content--hideo"></span>
								</label>
							</span>
                        <span class="input input--hideo">
                        <input class="input__field input__field--hideo" type="email" id="r_email" name="email" autocomplete="off" placeholder="请输入邮箱" required/>
                        <label class="input__label input__label--hideo" for="r_email">
                            <i class="fa fa-fw fa-envelope icon icon--hideo"></i>
                            <span class="input__label-content input__label-content--hideo">邮箱</span>
                        </label>
                    </span>
                        <span class="input input--hideo">
                        <input class="input__field input__field--hideo" type="text" id="r_captcha" name="captcha" autocomplete="off" placeholder="请输入验证码" required/>
                        <label class="input__label input__label--hideo" for="r_captcha">
                            <i class="fa fa-fw fa-key icon icon--hideo"></i>
                            <span class="input__label-content input__label-content--hideo">验证码</span>
                        </label>
                    </span>
                        <img id="registerCaptchaImage" src="${pageContext.request.contextPath}/captcha" alt="Captcha Image" onclick="refreshRegisterCaptcha()" style="cursor: pointer; margin-top: 0;">
                    </section>
                </div>
                <div class="form-actions">
                    <a tabindex="5" class="btn pull-left btn-link text-muted" onClick="goto_login()">返回登录</a>
                    <input class="btn btn-primary" type="submit" value="注册"
                           style="color:white;"/>
                </div>
            </form>
        </div>
    </div>

    <script type="text/javascript">
        function refreshRegisterCaptcha() {
            document.getElementById('registerCaptchaImage').src = '${pageContext.request.contextPath}/captcha?' + new Date().getTime();
        }
    </script>
</body>

</html>

<%@ page import="domain.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>SCU Movie DB</title>

    <link rel="icon" type="image/x-icon" href="img/logo.png">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="font/iconfont.css">
    <link rel="stylesheet" type="text/css" href="css/font-awesome.min.css">
    <link href="css/cropper.min.css" rel="stylesheet">
    <link href="css/sitelogo.css" rel="stylesheet">


</head>

<style>
    .avatar-btns button {
        height: 35px;
    }
</style>

<body class="bg-white">
<script src="js/jquery-3.4.1.min.js"></script>
<%--<script src="js/bootstrap.bundle.min.js"></script>--%>
<script src="js/bootstrap.min.js"></script>
<%
    User user = (User) request.getSession().getAttribute("user");
    if (user == null) {
        request.getRequestDispatcher("loginAndRegister.jsp").forward(request, response);
    }
%>
<div class="container-fluid p-0" style="">
    <jsp:include page="userHeader.jsp"/>

    <script src="js/cropper.js"></script>
    <script src="js/sitelogo.js"></script>

    <div class="container">
        <div class="row">
            <h5 class="text-secondary">账户信息</h5>
            </br>
            <div class="col-md-12">
                <div class="row">
                    <div class="col">
                        <label for="">用户名 </label>
                        <input type="text" class="form-control" placeholder="<%=user.getUsername()%>" disabled>

                    </div>
                    <div class="col">
                        <label for="">邮箱</label>
                        <input type="email" class="form-control" placeholder="<%=user.getEmail()%>" disabled>

                    </div>
                </div>
            </div>
        </div>

        <!-- 修改密码 -->
        <div class="row mt-4">
            <h5 class="text-secondary">修改密码</h5>
            </br>
            <div class="col-md-12">
                <div class="row">

                    <div class="col">
                        <label for="new-password">新密码 </label>
                        <input type="password" id="new-password" class="form-control" placeholder="请输入新的密码">

                    </div>
                    <div class="col">
                        <label for="confirm-password">确认密码</label>
                        <input type="password" id="confirm-password" class="form-control" placeholder="请再输入一次">

                    </div>
                </div>
                <div class="row mt-3">
                    <div class="col-md-12 text-center">
                        <input type="submit" class="btn btn-info" value="确认修改" style="width: 200px;"
                               onclick="alterPassword()">
                    </div>
                </div>
            </div>
        </div>

        <!-- 修改个人信息 -->
        <div class="row mt-4">
    <h5 class="text-secondary">修改个人信息</h5>
    </br>
    <div class="col-md-12">
        <div class="row">
            <div class="col">
                <label for="user-gender">性别</label>
                <select id="user-gender" class="form-control">
                    <option value="">请选择</option>
                    <option value="男">男</option>
                    <option value="女">女</option>
                </select>
            </div>
            <div class="col">
                <label for="user-age">年龄</label>
                <input type="number" id="user-age" class="form-control" min="1" max="120" placeholder="请输入年龄">
            </div>
        </div>
        <div class="row mt-3">
            <div class="col-md-12 text-center">
                <input type="submit" class="btn btn-info" value="保存修改" style="width: 200px;"
                       onclick="alterUserInfo()">
            </div>
        </div>
        <!-- 这里添加空白行 -->
        <br><br><br>
    </div>
</div>
    </div>
</div>

<div class="modal fade" id="avatar-modal" aria-hidden="true" aria-labelledby="avatar-modal-label" role="dialog" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <form class="avatar-form">
                <div class="modal-header">
                    <h4 class="modal-title float-left" id="avatar-modal-label">上传图片</h4>
                    <button class="close" data-dismiss="modal" type="button">&times;</button>
                </div>
                <div class="modal-body">
                    <div class="avatar-body">
                        <div class="avatar-upload">
                            <input class="avatar-src" name="avatar_src" type="hidden">
                            <input class="avatar-data" name="avatar_data" type="hidden">
                            <label for="avatarInput" style="line-height: 35px;">图片上传</label>
                            <button class="btn btn-danger" type="button" style="height: 35px;"
                                    onclick="$('input[id=avatarInput]').click();">请选择图片
                            </button>
                            <span id="avatar-name"></span>
                            <input class="avatar-input invisible" id="avatarInput" name="avatar_file" type="file">
                        </div>
                        <div class="row">
                            <div class="col-md-9">
                                <div class="avatar-wrapper"></div>
                            </div>
                            <div class="col-md-3">
                                <div class="avatar-preview preview-lg" id="imageHead"></div>
                            </div>
                        </div>
                        <div class="row avatar-btns">
                            <div class="col-md-5">
                                <div class="btn-group">
                                    <button class="btn btn-danger fa fa-undo" data-method="rotate" data-option="-90"
                                            type="button" title="Rotate -90 degrees"> 向左旋转
                                    </button>
                                </div>
                                <div class="btn-group">
                                    <button class="btn  btn-danger fa fa-repeat" data-method="rotate"
                                            data-option="90" type="button" title="Rotate 90 degrees"> 向右旋转
                                    </button>
                                </div>
                            </div>
                            <div class="col-md-4" style="text-align: right;">
                                <button class="btn btn-danger fa fa-arrows" data-method="setDragMode"
                                        data-option="move" type="button" title="移动">
                                        <span class="docs-tooltip" data-toggle="tooltip" title=""
                                              data-original-title="$().cropper(&quot;setDragMode&quot;, &quot;move&quot;)">
                                        </span>
                                </button>
                                <button type="button" class="btn btn-danger fa fa-search-plus" data-method="zoom"
                                        data-option="0.1" title="放大图片">
                                        <span class="docs-tooltip" data-toggle="tooltip" title=""
                                              data-original-title="$().cropper(&quot;zoom&quot;, 0.1)">
                                        </span>
                                </button>
                                <button type="button" class="btn btn-danger fa fa-search-minus" data-method="zoom"
                                        data-option="-0.1" title="缩小图片">
                                        <span class="docs-tooltip" data-toggle="tooltip" title=""
                                              data-original-title="$().cropper(&quot;zoom&quot;, -0.1)">
                                        </span>
                                </button>
                                <button type="button" class="btn btn-danger fa fa-refresh" data-method="reset"
                                        title="重置图片">
                                        <span class="docs-tooltip" data-toggle="tooltip" title=""
                                              data-original-title="$().cropper(&quot;reset&quot;)"
                                              aria-describedby="tooltip866214">
                                        </span>
                                </button>
                            </div>
                            <div class="col-md-3">
                                <button class="btn btn-danger btn-block avatar-save fa fa-save" type="button"
                                        data-dismiss="modal"> 保存修改
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="loading" aria-label="Loading" role="img" tabindex="-1"></div>

<script src="js/html2canvas.min.js"></script>
<script type="text/javascript">
    // 全局变量
    var cropper = null;

    // 页面加载完成后初始化
    $(document).ready(function() {
        console.log('页面加载完成');
        console.log('jQuery版本:', $.fn.jquery);
        console.log('$.fn.cropper:', typeof $.fn.cropper);

        // 绑定文件选择事件
        $('#avatarInput').on('change', handleFileSelect);

        // 绑定保存按钮事件
        $('.avatar-save').on('click', handleSave);

        // 绑定裁剪工具按钮事件
        $('.avatar-btns button[data-method]').on('click', handleCropperAction);

        // 模态框显示时重置状态
        $('#avatar-modal').on('shown.bs.modal', function() {
            console.log('模态框显示');
            resetModal();
        });
    });

    // 处理文件选择
    function handleFileSelect(e) {
        console.log('文件选择事件触发');

        var file = e.target.files[0];
        if (!file) {
            alert('请选择文件！');
            return;
        }

        // 验证文件大小
        var filemaxsize = 1024 * 5; // 5MB
        var fileSize = file.size / 1024;
        if (fileSize > filemaxsize) {
            alert('图片过大，请重新选择!');
            return;
        }

        // 验证文件类型
        if (!file.type.match(/image.*/)) {
            alert('请选择正确的图片文件!');
            return;
        }

        // 显示文件名
        var filename = file.name;
        $('#avatar-name').text(filename);

        // 读取并显示图片
        var reader = new FileReader();
        reader.onload = function(e) {
            console.log('图片读取完成');

            // 清空预览区域
            $('.avatar-wrapper').empty();
            $('.avatar-preview').empty();

            // 创建图片元素
            var img = $('<img>').attr('src', e.target.result);

            // 添加到预览区域
            $('.avatar-wrapper').append(img);
            $('.avatar-preview').append(img.clone());

            // 等待图片加载完成后初始化裁剪器
            img.on('load', function() {
                console.log('图片加载完成，初始化裁剪器');
                initCropper(this);
            });
        };

        reader.onerror = function() {
            alert('图片读取失败！');
        };

        reader.readAsDataURL(file);
    }

    // 初始化裁剪器
    function initCropper(imgElement) {
        console.log('初始化裁剪器');
        console.log('$.fn.cropper:', typeof $.fn.cropper);

        // 销毁之前的裁剪器
        if (cropper) {
            cropper.cropper('destroy');
            cropper = null;
        }

        // 检查Cropper是否可用
        if (typeof $.fn.cropper === 'undefined') {
            console.error('Cropper jQuery插件未定义！');
            alert('图片裁剪功能加载失败，请刷新页面重试！');
            return;
        }

        try {
            // 使用jQuery插件方式创建裁剪器
            cropper = $(imgElement);
            cropper.cropper({
                aspectRatio: 1,
                viewMode: 1,
                dragMode: 'move',
                autoCropArea: 1,
                restore: false,
                guides: true,
                center: true,
                highlight: false,
                cropBoxMovable: true,
                cropBoxResizable: true,
                toggleDragModeOnDblclick: false,
                preview: '.avatar-preview'
            });

            console.log('裁剪器初始化完成');
        } catch (error) {
            console.error('裁剪器初始化失败:', error);
            alert('裁剪器初始化失败：' + error.message);
        }
    }

    // 处理裁剪工具按钮点击
    function handleCropperAction(e) {
        e.preventDefault();

        console.log('裁剪工具按钮点击');
        console.log('当前cropper实例:', cropper);

        if (!cropper) {
            alert('请先选择图片！');
            return;
        }

        var method = $(this).data('method');
        var option = $(this).data('option');

        console.log('执行裁剪操作:', method, option);

        try {
            cropper.cropper(method, option);
        } catch (error) {
            console.error('裁剪操作失败:', error);
            alert('操作失败：' + error.message);
        }
    }

    // 处理保存
    function handleSave() {
        console.log('保存按钮点击');
        console.log('当前cropper实例:', cropper);

        if (!cropper) {
            alert('请先选择图片！');
            return;
        }

        try {
            // 获取裁剪后的画布
            var canvas = cropper.cropper('getCroppedCanvas', {
                width: 200,
                height: 200,
                imageSmoothingEnabled: true,
                imageSmoothingQuality: 'high'
            });

            if (!canvas) {
                alert('裁剪失败，请重试！');
                return;
            }

            console.log('获取裁剪画布成功');

            // 转换为blob
            canvas.toBlob(function(blob) {
                console.log('转换为blob成功');

                // 创建FormData
                var formData = new FormData();
                formData.append('avatar', blob, 'avatar.jpg');

                // 显示加载状态
                $('.avatar-save').prop('disabled', true).text('上传中...');

                // 发送AJAX请求
                $.ajax({
                    url: 'uploadAvatar.do',
                    type: 'POST',
                    data: formData,
                    processData: false,
                    contentType: false,
                    success: function(response) {
                        console.log('上传响应:', response);
                        console.log('响应类型:', typeof response);

                        try {
                            // 如果响应已经是对象，直接使用
                            var result;
                            if (typeof response === 'object') {
                                result = response;
                            } else {
                                // 如果是字符串，尝试解析JSON
                                result = JSON.parse(response);
                            }

                            if (result.success) {
                                alert('头像上传成功！');

                                // 更新页面上的头像显示
                                $('.rounded-circle').attr('src', result.avatarUrl);

                                // 关闭模态框
                                $('#avatar-modal').modal('hide');
                            } else {
                                alert('上传失败：' + result.message);
                            }
                        } catch (e) {
                            console.error('解析响应失败:', e);
                            console.error('原始响应:', response);
                            alert('上传失败：服务器响应格式错误');
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error('上传失败:', error);
                        console.error('状态:', status);
                        console.error('响应文本:', xhr.responseText);
                        alert('上传失败：网络错误');
                    },
                    complete: function() {
                        // 恢复按钮状态
                        $('.avatar-save').prop('disabled', false).text('保存修改');
                    }
                });
            }, 'image/jpeg', 0.8);

        } catch (error) {
            console.error('保存失败:', error);
            alert('保存失败：' + error.message);
        }
    }

    // 重置模态框
    function resetModal() {
        // 清空文件输入
        $('#avatarInput').val('');
        $('#avatar-name').text('');

        // 清空预览区域
        $('.avatar-wrapper').empty();
        $('.avatar-preview').empty();

        // 销毁裁剪器
        if (cropper) {
            cropper.cropper('destroy');
            cropper = null;
        }
    }

    // 修改密码功能
    function alterPassword() {
        var newPassword = $('#new-password').val();
        var confirmPassword = $('#confirm-password').val();

        if (!newPassword || newPassword.trim() === '') {
            alert('请输入新密码！');
            return;
        }

        if (!confirmPassword || confirmPassword.trim() === '') {
            alert('请确认密码！');
            return;
        }

        if (newPassword !== confirmPassword) {
            alert('两次输入的密码不一致！');
            return;
        }

        if (newPassword.length < 6) {
            alert('密码长度不能少于6位！');
            return;
        }

        // 发送修改密码请求
        $.ajax({
            url: 'alterUserInfo.do',
            type: 'POST',
            data: {
                password: newPassword
            },
            success: function(response) {
                if (response === 'ok') {
                    alert('密码修改成功！');
                    $('#new-password').val('');
                    $('#confirm-password').val('');
                } else {
                    alert('密码修改失败！');
                }
            },
            error: function() {
                alert('网络错误，请稍后重试！');
            }
        });
    }

    // 新增：修改性别和年龄功能
    function alterUserInfo() {
        var gender = $('#user-gender').val();
        var age = $('#user-age').val();

        if (!gender) {
            alert('请选择性别！');
            return;
        }
        if (!age || isNaN(age) || age < 1 || age > 120) {
            alert('请输入有效的年龄（1-120）！');
            return;
        }

        $.ajax({
            url: 'alterUserInfo.do',
            type: 'POST',
            data: {
                gender: gender,
                age: age
            },
            success: function(response) {
                if (response === 'ok') {
                    alert('个人信息修改成功！');
                } else {
                    alert('个人信息修改失败！');
                }
            },
            error: function() {
                alert('网络错误，请稍后重试！');
            }
        });
    }
</script>

</body>

</html>

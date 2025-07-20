<%@ page import="domain.User" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<!-- 隐藏的电影名称元素，供JavaScript使用 -->
<div id="movieName" style="display: none;">${detail.name}</div>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>电影详情页</title>
    <link rel="stylesheet" href="font/iconfont.css">
    <link rel="icon" type="image/x-icon" href="img/logo.png">
    <link rel="stylesheet" href="css/comment.css"/>
    <link rel="stylesheet" href="css/sinaFaceAndEffec.css"/>
    <link rel="stylesheet" href="css/dreamlike.css"/>
    <!-- Bootstrap -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/info.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

</head>
<style>
  body {
    /*  字体  */
    font-family: -apple-system, BlinkMacSystemFont, 'Microsoft YaHei', sans-serif;

    /*  字号 */
    font-size: 16px;

    /*  字体颜色  */
    color: #333;

    /* 行距 */
    line-height: 1.75;
  }
  .detail-info {
    display: flex;
    align-items: flex-start;
    justify-content: center;
    background: none;
    border-radius: 0;
    box-shadow: none;
    padding: 0 0 0 0;
    color: #222;
    font-size: 17px;
    margin-top: 40px;
  }
  .detail-info .img-info-box {
    display: flex;
    flex-direction: row;
    align-items: flex-start;
    min-width: 480px;
    margin-right: 60px;
    margin-top: 40px;
    margin-left: 40px;
  }
  .detail-info .detail-img {
    border: 5px solid gray;
    border-radius: 12px;
    box-shadow: 0 2px 16px rgba(0,0,0,0.18);
    width: 220px;
    height: auto;
    display: block;
    margin-right: 60px;
  }
  .detail-info .info-table {
    width: 180px;
    min-width: 120px;
    margin-top: 0;
    font-size: 1em;
  }
  .detail-info .info-table td {
    padding: 6px 8px 6px 0;
    border: none;
    vertical-align: top;
    text-align: left;
    color: #444;
    font-size: 1em;
  }
  .detail-info .info-table td:first-child {
    font-weight: bold;
    color: #888;
    width: 60px;
    text-align: right;
    padding-right: 10px;
    white-space: nowrap;
  }
  .detail-info .info-table td:last-child {
    color: #222;
    font-weight: 500;
    word-break: break-all;
  }
  .detail-info .right-info {
    flex: 1;
    min-width: 0;
    margin-left: 0;
    display: flex;
    flex-direction: column;
    justify-content: flex-start;
    position: relative;
    height: 100%;
  }
  .detail-info .right-info-inner {
    display: flex;
    flex-direction: row;
    align-items: flex-start;
  }
  .detail-info .type-title {
    font-size: 2.2em;
    font-weight: 700;
    color: #222;
    margin-bottom: 0;
    margin-top: 40px;
    min-width: 120px;
    text-align: left;
  }
  .detail-info .desc {
    color: #333;
    font-size: 1.18em;
    line-height: 2.1;
    margin-top: 0;
    letter-spacing: 0.5px;
    word-break: break-word;
    margin-left: 0;
  }
  .detail-info .score {
    font-size: 1.5em;
    color: #ff6b6b;
    font-weight: bold;
    margin-left: 8px;
  }
  .detail-info .btn {
    font-size: 1.1em;
    border-radius: 8px;
    padding: 8px 28px;
    margin-top: 18px;
  }
  .detail-info .right-info-bottom {
    display: flex;
    justify-content: flex-end;
    width: 100%;
    margin-top: 24px;
  }
  .hot-title {
    font-size: 2.2em;
    font-weight: 700;
    color: #222;
    letter-spacing: 2px;
    margin: 40px 0 32px 0;
    text-shadow: 0 2px 12px rgba(0,0,0,0.08);
    transform: translateX(30px); /* 向右移动15px */
  }

  .hot-movie {
    display: flex !important;
    flex-wrap: nowrap !important;
    justify-content: space-between !important;
    gap: 32px;
    margin-left: 45px;
  }
  .hot-movie > li {
    flex: 1 1 0;
    max-width: 100%;
    min-width: 0;
    margin-bottom: 24px;
    background: #fff;
    border-radius: 18px;
    box-shadow: 0 4px 18px rgba(0,0,0,0.10);
    border: 1.5px solid #ececec;
    overflow: hidden;
    display: flex;
    flex-direction: column;
    align-items: center;
  }
  .hot-movie > li img {
    width: 100%;
    height: 260px;
    object-fit: cover;
    border-radius: 18px 18px 0 0;
  }
  .hot-movie > li span {
    display: block;
    width: 100%;
    text-align: center;
    background: #222;
    margin-top: -40px;
    height: 40px;
    line-height: 40px;
    opacity: 0.85;
    color: #fff;
    font-weight: bold;
    border-radius: 0 0 18px 18px;
    font-size: 1.1em;
  }
</style>
<body class="bg-dark">

<!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
<script src="js/jquery-3.4.1.min.js"></script>
<script src="js/popper.min.js"></script>
<!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
<script src="js/bootstrap.min.js"></script>
<script src="js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="js/comment.js"></script>
<script type="text/javascript" src="js/sinaFaceAndEffec.js"></script>
<div id="atome" class="atome">
    <div class="circle"><span class="dot"></span><span class="dot"></span></div>
    <div class="circle"><span class="dot"></span><span class="dot"></span></div>
    <div class="circle"><span class="dot"></span><span class="dot"></span></div>
    <div class="circle"><span class="dot"></span><span class="dot"></span></div>
    <div class="circle"><span class="dot"></span><span class="dot"></span></div>
    <div class="circle"><span class="dot"></span><span class="dot"></span></div>
    <div class="circle"><span class="dot"></span><span class="dot"></span></div>
    <div class="circle"><span class="dot"></span><span class="dot"></span></div>
    <div class="circle"><span class="dot"></span><span class="dot"></span></div>
    <div class="circle"><span class="dot"></span><span class="dot"></span></div>
    <div class="circle"><span class="dot"></span><span class="dot"></span></div>
    <div class="circle"><span class="dot"></span><span class="dot"></span></div>
    <div class="circle"><span class="dot"></span><span class="dot"></span></div>
</div>
<div id="main" class="d-none">
    <jsp:include page="header.jsp"/>

    <div class="mid" style="margin-top: 10px">
        <!--电影详情 开始 -->
        <div class="row detail-info">
            <div class="img-info-box">
                <img class="detail-img" src="${detail.image }" alt="">
                <table class="info-table">
                    <tr class="info-tr">
                        <td>年份</td>
                        <td>${detail.years}</td>
                    </tr>
                    <tr class="info-tr">
                        <td>导演</td>
                        <td>${detail.director}</td>
                    </tr>
                    <tr class="info-tr">
                        <td>地区</td>
                        <td>${detail.country}</td>
                    </tr>
                    <tr class="info-tr">
                        <td>类型</td>
                        <td>${detail.type }</td>
                    </tr>
                    <tr class="info-tr">
                        <td>主演</td>
                        <td><span style=" text-overflow: ellipsis; display: -webkit-box; -webkit-box-orient: vertical; -webkit-line-clamp: 8; overflow: hidden;">${detail.actor }</span></td>
                    </tr>
                    <tr class="info-tr">
                        <td>评分</td>
                        <td>${detail.score }分</td>
                    </tr>
                </table>
            </div>
            <div class="right-info">
                <h3 class="type-title">${detail.type}</h3>
                <span class="desc" style="width: auto; text-overflow:ellipsis; display: -webkit-box; -webkit-box-orient: vertical; -webkit-line-clamp:9; overflow: hidden;">${detail.des } </span>
                <div class="right-info-bottom">
                    <a class="btn btn-success" href="${detail.url}" role="button" style="margin-right: 60px">
                        <span class="">在线播放</span>
                    </a>
                </div>
            </div>
            <!-- 电影详情 结束 -->

        </div>
        <!-- Large modal -->
        <div class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
             aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                <div class="modal-content">
                    <div id="content" style="width: 700px; height: auto;">
                        <div class="wrap">
                            <div class="comment">
                                <div class="content">
                                    <div class="cont-box">
                                        <textarea class="text" placeholder="请输入..." id="description"></textarea>
                                    </div>
                                    <div class="tools-box">
                                        <div class="operator-box-btn">
                                            <span class="face-icon" style="margin-top: -5px">☺</span>
                                            <%--                                            <span class="img-icon" style="margin-top: -15px">▧</span>--%>
                                        </div>
                                        <div class="submit-btn">
                                            <input type="button" onClick="addComment()" value="提交评论"/>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <%-- <div id="info-show">
                                 <ul></ul>
                             </div>--%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- 评论部分 开始 -->
        <!-- 原有的评论功能 - 已注释
        <div class="row" style="width: 100%;">
            <div class="col-md-12">
                <%
                    User user = (User) request.getSession().getAttribute("user");
                    if (user == null) {

                %>
                <a href="${pageContext.request.contextPath}/login.do" class="float-right text-muted">
                    <span style="font-size: 1.2em;" data-toggle="modal" data-target=".bd-example-modal-lg">评论</span>
                </a>
                <%
                } else {


                %>
                <a href="#" class="float-right text-muted">
                    <span style="font-size: 1.2em;" data-toggle="modal" data-target=".bd-example-modal-lg">评论</span>
                </a>
                <%
                    }
                %>
            </div>
        </div>
        <div class="comment" style="width: 100%; display: flex; flex-direction: column; align-items: center; background: white;">
            <c:forEach var="comment" items="${comments}" varStatus="status">
                <c:choose>
                    <c:when test="${status.count <= 5}">
                        <div class="c-info d-flex align-items-center justify-content-start mb-4" style="width: 95%; min-height: 100px; box-shadow: 0 4px 18px rgba(0,0,0,0.10); border-radius: 18px; background: #fff; padding: 28px 36px; margin: 20px 0; border: 1.5px solid #ececec; transition: box-shadow 0.2s;">
                            <img src="img/bg2.png" alt="头像" class="rounded-circle mr-4" width="60px" height="60px" style="border: 2px solid #f6c624;">
                            <div style="flex:1;">
                                <div class="d-flex align-items-center mb-2">
                                    <h5 class="mb-0 mr-3" style="font-weight: bold; color: #333;">${comment.userName}</h5>
                                    <span style="color: #aaa; font-size: 0.95em;">${comment.addTime}</span>
                                </div>
                                <div class="hid des" style="font-size: 1.15em; color: #444;">${comment.description}</div>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="c-info d-none d-flex align-items-center justify-content-start mb-4" style="width: 95%; min-height: 100px; box-shadow: 0 4px 18px rgba(0,0,0,0.10); border-radius: 18px; background: #fff; padding: 28px 36px; margin: 20px 0; border: 1.5px solid #ececec; transition: box-shadow 0.2s;">
                            <img src="img/bg2.png" alt="头像" class="rounded-circle mr-4" width="60px" height="60px" style="border: 2px solid #f6c624;">
                            <div style="flex:1;">
                                <div class="d-flex align-items-center mb-2">
                                    <h5 class="mb-0 mr-3" style="font-weight: bold; color: #333;">${comment.userName}</h5>
                                    <span style="color: #aaa; font-size: 0.95em;">${comment.addTime}</span>
                                </div>
                                <div class="hid des" style="font-size: 1.15em; color: #444;">${comment.description}</div>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </div>
        <div class="row" style=" width: 100%; margin-top: 10px;">
            <c:if test="${commentsSize > 0}">
                <div class="col-md-12" style="text-align: center;">
                    <nav aria-label="Page navigation example">
                        <ul class="pagination justify-content-center" id="controllPage">
                            <li class="page-item">
                                <a class="page-link" href="#" aria-label="Previous"
                                   onclick="lastCommentPage();return false;">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                            <c:forEach var="i" begin="1" end="${commentsSize}" varStatus="status">
                                <li class="page-item${status.index == 0 ? ' active' : ''}" onclick="changeCommentPage(${i})">
                                    <a class="page-link" href="#">${i}</a>
                                </li>
                            </c:forEach>
                            <li class="page-item">
                                <a class="page-link" href="#" onclick="nextPageComment();return false;"
                                   aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </c:if>
        -->
        <!-- 全新的评论区域 -->
        <div class="comment-section" style="width: 100%; background: linear-gradient(135deg, #b7b5ac 0%, #a3b1a8 100%); padding: 40px 20px; border-radius: 20px; margin: 20px 0; box-shadow: 0 15px 35px rgba(0,0,0,0.1);">
            <div class="comment-header" style="text-align: center; margin-bottom: 30px;">
                <h3 style="color: white; font-weight: 700; font-size: 2.2em; text-shadow: 0 2px 10px rgba(0,0,0,0.3);">
                    <i class="fas fa-comments" style="margin-right: 10px;"></i>观众评论
                </h3>
                <div style="width: 80px; height: 4px; background: linear-gradient(90deg, rgba(255,255,255,0.6), rgba(255,255,255,0.4)); margin: 10px auto; border-radius: 2px;"></div>
            </div>

            <!-- 写评论组件 -->
            <%
                if (user != null) {
            %>
            <div class="write-comment-section" style="background: rgba(255,255,255,0.95); border-radius: 15px; padding: 25px; margin-bottom: 30px; backdrop-filter: blur(10px); border: 1px solid rgba(255,255,255,0.3); box-shadow: 0 8px 32px rgba(0,0,0,0.15);">
                <div class="d-flex align-items-start">
                    <div class="user-avatar" style="
                        width: 45px;
                        height: 45px;
                        border-radius: 50%;
                        background: linear-gradient(135deg, #b7b5ac 0%, #a3b1a8 100%);
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        color: white;
                        font-weight: bold;
                        font-size: 1.1em;
                        margin-right: 15px;
                        flex-shrink: 0;
                        border: 2px solid rgba(183,181,172,0.2);
                        box-shadow: 0 4px 12px rgba(183,181,172,0.25);
                    ">
                        <%= user.getUsername().charAt(0) %>
                    </div>
                    <div class="write-comment-content" style="flex: 1;">
                        <div class="comment-input-wrapper" style="position: relative;">
                            <textarea
                                    id="inlineDescription"
                                    class="form-control"
                                    placeholder="写下您的观影感受..."
                                    rows="3"
                                    style="
                                    border: 2px solid rgba(183,181,172,0.3);
                                    border-radius: 15px;
                                    background: #ffffff;
                                    padding: 15px 20px;
                                    font-size: 1em;
                                    resize: none;
                                    transition: all 0.3s ease;
                                    box-shadow: 0 2px 10px rgba(183,181,172,0.1);
                                    color: #2c2c2c;
                                "
                                    onfocus="this.style.borderColor='#a3b1a8'; this.style.boxShadow='0 4px 15px rgba(163,177,168,0.2)'"
                                    onblur="this.style.borderColor='rgba(183,181,172,0.3)'; this.style.boxShadow='0 2px 10px rgba(183,181,172,0.1)'"
                            ></textarea>
                            <div class="comment-tools" style="display: flex; justify-content: space-between; align-items: center; margin-top: 15px;">
                                <div class="emoji-selector" style="flex: 1;">
                                    <span class="inline-face-icon" style="
                                        background: rgba(183,181,172,0.1);
                                        padding: 8px 15px;
                                        border-radius: 20px;
                                        color: #6c6b66;
                                        cursor: pointer;
                                        font-size: 1.1em;
                                        transition: all 0.3s ease;
                                        border: 1px solid rgba(183,181,172,0.2);
                                        font-weight: 500;
                                    "
                                          onmouseover="this.style.background='rgba(183,181,172,0.2)'; this.style.transform='translateY(-1px)'; this.style.boxShadow='0 4px 12px rgba(183,181,172,0.15)'"
                                          onmouseout="this.style.background='rgba(183,181,172,0.1)'; this.style.transform='translateY(0)'; this.style.boxShadow='none'"
                                    >
                                        ☺ 表情
                                    </span>
                                </div>
                                <button
                                        onclick="addInlineComment()"
                                        class="btn"
                                        style="
                                        background: linear-gradient(135deg, #b7b5ac 0%, #a3b1a8 100%);
                                        border: none;
                                        color: white;
                                        padding: 10px 25px;
                                        border-radius: 25px;
                                        font-weight: 600;
                                        font-size: 1em;
                                        transition: all 0.3s ease;
                                        box-shadow: 0 4px 15px rgba(183,181,172,0.3);
                                        border: 1px solid rgba(255,255,255,0.2);
                                    "
                                        onmouseover="this.style.transform='translateY(-2px)'; this.style.boxShadow='0 6px 20px rgba(183,181,172,0.4)'; this.style.background='linear-gradient(135deg, #c2c0b6 0%, #aebbb2 100%)'"
                                        onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='0 4px 15px rgba(183,181,172,0.3)'; this.style.background='linear-gradient(135deg, #b7b5ac 0%, #a3b1a8 100%)'"
                                >
                                    <i class="fas fa-paper-plane" style="margin-right: 8px;"></i>发表评论
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <%
            } else {
            %>
            <div class="login-prompt-section" style="background: rgba(255,255,255,0.95); border-radius: 15px; padding: 25px; margin-bottom: 30px; backdrop-filter: blur(10px); text-align: center; border: 1px solid rgba(255,255,255,0.3); box-shadow: 0 8px 32px rgba(0,0,0,0.15);">
                <div style="color: #5a5a5a; margin-bottom: 15px;">
                    <i class="fas fa-user-circle" style="font-size: 2em; margin-bottom: 10px; opacity: 0.7; color: #a3b1a8;"></i>
                    <p style="font-size: 1.1em; margin: 0; color: #5a5a5a; font-weight: 500;">登录后即可发表评论，分享您的观影感受</p>
                </div>
                <a href="${pageContext.request.contextPath}/loginOrRegister.do"
                   class="btn"
                   style="
                       background: linear-gradient(135deg, #b7b5ac 0%, #a3b1a8 100%);
                       border: 1px solid rgba(255,255,255,0.2);
                       color: white;
                       padding: 12px 30px;
                       border-radius: 25px;
                       font-weight: 600;
                       font-size: 1em;
                       text-decoration: none;
                       transition: all 0.3s ease;
                       box-shadow: 0 4px 15px rgba(183,181,172,0.25);
                       display: inline-block;
                   "
                   onmouseover="this.style.transform='translateY(-2px)'; this.style.boxShadow='0 6px 20px rgba(183,181,172,0.35)'; this.style.background='linear-gradient(135deg, #c2c0b6 0%, #aebbb2 100%)'"
                   onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='0 4px 15px rgba(183,181,172,0.25)'; this.style.background='linear-gradient(135deg, #b7b5ac 0%, #a3b1a8 100%)'"
                >
                    <i class="fas fa-sign-in-alt" style="margin-right: 8px;"></i>立即登录
                </a>
            </div>
            <%
                }
            %>

            <!-- 评论统计信息 -->
            <div class="comment-stats" style="background: rgba(255, 255, 255, 0.2); padding: 15px 25px; border-radius: 15px; margin-bottom: 25px; backdrop-filter: blur(10px); border: 1px solid rgba(255,255,255,0.3);">
                <div class="row text-center">
                    <div class="col-md-4">
                        <div style="color: #fff;">
                            <h4 id="totalCommentsCount" style="margin: 0; font-weight: 600; color: #fff;">-</h4>
                            <small style="opacity: 0.8; color: #fff;">总评论数</small>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div style="color: #fff;">
                            <h4 id="currentPageInfo" style="margin: 0; font-weight: 600; color: #fff;">-</h4>
                            <small style="opacity: 0.8; color: #fff;">当前页</small>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div style="color: #fff;">
                            <h4 id="totalPagesCount" style="margin: 0; font-weight: 600; color: #fff;">-</h4>
                            <small style="opacity: 0.8; color: #fff;">总页数</small>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 评论列表容器 -->
            <div id="commentsList" style="min-height: 400px;">
                <!-- 评论内容将通过Ajax加载 -->
                <div class="text-center" style="padding: 60px 0; color: white;">
                    <div class="spinner-border" role="status" style="width: 3rem; height: 3rem;">
                        <span class="sr-only">加载中...</span>
                    </div>
                    <p style="margin-top: 20px; font-size: 1.1em;">正在加载评论...</p>
                </div>
            </div>

            <!-- 分页导航 -->
            <div class="comment-pagination" style="margin-top: 30px;">
                <nav aria-label="评论分页">
                    <ul class="pagination justify-content-center" id="commentPagination" style="margin: 0;">
                        <!-- 分页按钮将通过JavaScript动态生成 -->
                    </ul>
                </nav>
            </div>
        </div>

        <!-- 热门电影 开始 -->
        <div class="row bottom-menu">
            <div class="row">
                <!-- 标题 -->
                <div class="col-md-12">
                    <h3 class="hot-title">
                        热门电影
                    </h3>
                </div>
                <div class="col-md-12">
                    <ul class="list-unstyled hot-movie" style="display: flex; flex-wrap: wrap; justify-content: space-between;">
                        <c:forEach var="movie" items="<%=request.getAttribute(\"hotMovies\") %>" varStatus="status">
                            <c:if test="${status.count <= 4}">
                                <li style="width: 23%; margin-bottom: 24px; background: #fff; border-radius: 18px; box-shadow: 0 4px 18px rgba(0,0,0,0.10); border: 1.5px solid #ececec; overflow: hidden; display: flex; flex-direction: column; align-items: center;">
                                    <a href="${pageContext.request.contextPath}/detail.do?movieName=${movie.name}"
                                       style="display: block; width: 100%; height: 260px; border-radius: 18px 18px 0 0; overflow: hidden;">
                                        <img src="${movie.image}" alt="" style="width: 100%; height: 100%; object-fit: cover; border-radius: 18px 18px 0 0;">
                                    </a>
                                    <span style="display: block; width: 100%; text-align: center; background: #222; margin-top: -40px; height: 40px; line-height: 40px; opacity: 0.85; color: #fff; font-weight: bold; border-radius: 0 0 18px 18px;">${movie.name}</span>
                                </li>
                            </c:if>
                        </c:forEach>
                    </ul>
                </div>
            </div>
            <div class="row more-info" style="width: 100%;">
                <div class="col-md-12" style="text-align: center;">
                    <a class="btn btn-default"
                       href="${pageContext.request.contextPath}/category.do?category=${detail.type}"
                       role="button"
                       style="font-size: 1.2em; border-radius: 20px; width: 150px; background:#f6c624;"><strong>查看更多</strong></a>
                </div>
            </div>
            <!-- 热门电影 结束 -->

        </div>

        <script type="text/javascript">
          // 绑定表情
          $('.face-icon').SinaEmotion($('.text'));

          // 全局变量
          var currentPage = 1;
          var pageSize = 5;
          var movieName = $("#movieName").text();

          // 提交评论函数
          function addComment() {
            var description = $("#description").val();
            var movieName = $("#movieName").text();

            if (!description.trim()) {
              alert("请输入评论内容！");
              return;
            }

            console.log(description + " " + movieName);
            $.ajax({
              url: "comment.do",
              data: "description=" + description + "&movieName=" + movieName,
              type: "POST",
              success: function (data) {
                if (data === "ok") {
                  $("#description").val("");
                  $(".modal").modal('hide');
                  // 重新加载第一页评论
                  loadComments(1);
                }
              },
              error: function (e) {
                console.log(e);
                alert("评论提交失败，请重试！");
              }
            });
          }

          // 加载评论数据
          function loadComments(page) {
            currentPage = page;

            // 显示加载状态
            var loadingHtml = '<div class="text-center" style="padding: 60px 0; color: white;">' +
                '<div class="spinner-border" role="status" style="width: 3rem; height: 3rem;">' +
                '<span class="sr-only">加载中...</span>' +
                '</div>' +
                '<p style="margin-top: 20px; font-size: 1.1em;">正在加载评论...</p>' +
                '</div>';
            $("#commentsList").html(loadingHtml);

            $.ajax({
              url: "commentPage.do",
              data: {
                movieName: movieName,
                page: page,
                pageSize: pageSize
              },
              type: "GET",
              dataType: "json",
              success: function (data) {
                if (data.success) {
                  renderComments(data);
                  renderPagination(data);
                  updateStats(data);
                } else {
                  var errorHtml = '<div class="text-center" style="padding: 60px 0; color: white;">' +
                      '<i class="fas fa-exclamation-triangle" style="font-size: 3em; margin-bottom: 20px; opacity: 0.6;"></i>' +
                      '<p style="font-size: 1.1em;">加载评论失败</p>' +
                      '</div>';
                  $("#commentsList").html(errorHtml);
                }
              },
              error: function (e) {
                console.log(e);
                var networkErrorHtml = '<div class="text-center" style="padding: 60px 0; color: white;">' +
                    '<i class="fas fa-wifi" style="font-size: 3em; margin-bottom: 20px; opacity: 0.6;"></i>' +
                    '<p style="font-size: 1.1em;">网络连接失败</p>' +
                    '</div>';
                $("#commentsList").html(networkErrorHtml);
              }
            });
          }

          // 内联评论提交函数
          function addInlineComment() {
            var description = $("#inlineDescription").val();
            var movieName = $("#movieName").text();

            if (!description.trim()) {
              alert("请输入评论内容！");
              return;
            }

            // 禁用按钮，防止重复提交
            var submitBtn = event.target;
            submitBtn.disabled = true;
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin" style="margin-right: 8px;"></i>发表中...';

            console.log(description + " " + movieName);
            $.ajax({
              url: "comment.do",
              data: "description=" + description + "&movieName=" + movieName,
              type: "POST",
              success: function (data) {
                if (data === "ok") {
                  $("#inlineDescription").val("");
                  // 重新加载第一页评论
                  loadComments(1);
                  // 显示成功提示
                  showSuccessMessage("评论发表成功！");
                } else {
                  alert("评论提交失败，请重试！");
                }
              },
              error: function (e) {
                console.log(e);
                alert("评论提交失败，请重试！");
              },
              complete: function() {
                // 恢复按钮状态
                submitBtn.disabled = false;
                submitBtn.innerHTML = '<i class="fas fa-paper-plane" style="margin-right: 8px;"></i>发表评论';
              }
            });
          }

          // 显示成功消息
          function showSuccessMessage(message) {
            var successAlert = '<div class="alert alert-success" style="' +
                'position: fixed; top: 20px; right: 20px; z-index: 9999; ' +
                'background: linear-gradient(135deg, #28a745, #20c997); ' +
                'color: white; border: none; border-radius: 10px; ' +
                'box-shadow: 0 4px 15px rgba(40,167,69,0.3);' +
                '" id="successMessage">' +
                '<i class="fas fa-check-circle" style="margin-right: 8px;"></i>' +
                message +
                '</div>';
            $("body").append(successAlert);

            // 3秒后自动消失
            setTimeout(function() {
              $("#successMessage").fadeOut(500, function() {
                $(this).remove();
              });
            }, 3000);
          }

          // 渲染评论列表
          function renderComments(data) {
            var html = '';

            if (data.comments.length === 0) {
              html = '<div class="text-center" style="padding: 60px 0; color: white;">' +
                  '<i class="fas fa-comment-slash" style="font-size: 3em; margin-bottom: 20px; opacity: 0.6;"></i>' +
                  '<p style="font-size: 1.1em;">暂无评论，来写第一条评论吧！</p>' +
                  '</div>';
            } else {
              for (var i = 0; i < data.comments.length; i++) {
                var comment = data.comments[i];
                var animationDelay = i * 0.1;
                var firstLetter = comment.userName ? comment.userName.charAt(0).toUpperCase() : 'U';

                // 改进的日期处理逻辑
                var dateDisplay = '今天';
                if (comment.addTime) {
                  try {
                    var date;
                    // 如果addTime是数字（时间戳）
                    if (typeof comment.addTime === 'number') {
                      date = new Date(comment.addTime);
                    }
                    // 如果addTime是字符串
                    else if (typeof comment.addTime === 'string') {
                      date = new Date(comment.addTime);
                    }
                    // 如果addTime是对象（可能包含时间戳）
                    else if (typeof comment.addTime === 'object' && comment.addTime.time) {
                      date = new Date(comment.addTime.time);
                    }
                    // 其他情况，尝试直接转换
                    else {
                      date = new Date(comment.addTime);
                    }

                    // 检查日期是否有效
                    if (date && !isNaN(date.getTime())) {
                      var year = date.getFullYear();
                      var month = ('0' + (date.getMonth() + 1)).slice(-2);
                      var day = ('0' + date.getDate()).slice(-2);
                      dateDisplay = year + '-' + month + '-' + day;
                    } else {
                      // 如果日期解析失败，尝试字符串处理
                      var dateStr = comment.addTime.toString();
                      if (dateStr.includes('-') && dateStr.length >= 10) {
                        var parts = dateStr.substring(0, 10).split('-');
                        if (parts.length === 3) {
                          dateDisplay = parts[0] + '-' + parts[1] + '-' + parts[2];
                        }
                      } else {
                        // 显示当前日期
                        var today = new Date();
                        var todayYear = today.getFullYear();
                        var todayMonth = ('0' + (today.getMonth() + 1)).slice(-2);
                        var todayDay = ('0' + today.getDate()).slice(-2);
                        dateDisplay = todayYear + '-' + todayMonth + '-' + todayDay;
                      }
                    }
                  } catch (e) {
                    console.log('日期解析错误:', e, comment.addTime);
                    // 发生错误时显示当前日期
                    var today = new Date();
                    var todayYear = today.getFullYear();
                    var todayMonth = ('0' + (today.getMonth() + 1)).slice(-2);
                    var todayDay = ('0' + today.getDate()).slice(-2);
                    dateDisplay = todayYear + '-' + todayMonth + '-' + todayDay;
                  }
                }

                html += '<div class="comment-item" style="' +
                    'background: rgba(255,255,255,0.95);' +
                    'border-radius: 20px;' +
                    'padding: 25px;' +
                    'margin-bottom: 20px;' +
                    'box-shadow: 0 8px 32px rgba(0,0,0,0.1);' +
                    'border: 1px solid rgba(255,255,255,0.2);' +
                    'backdrop-filter: blur(10px);' +
                    'animation: slideInUp 0.6s ease ' + animationDelay + 's both;' +
                    'position: relative;' +
                    'overflow: hidden;' +
                    '">' +
                    '<div class="d-flex align-items-start">' +
                    '<div class="comment-avatar" style="' +
                    'width: 50px;' +
                    'height: 50px;' +
                    'border-radius: 50%;' +
                    'background: linear-gradient(135deg, #b7b5ac 0%, #a3b1a8 100%);' +
                    'display: flex;' +
                    'align-items: center;' +
                    'justify-content: center;' +
                    'color: white;' +
                    'font-weight: bold;' +
                    'font-size: 1.2em;' +
                    'margin-right: 15px;' +
                    'flex-shrink: 0;' +
                    'border: 2px solid rgba(183,181,172,0.2);' +
                    'box-shadow: 0 4px 12px rgba(183,181,172,0.25);' +
                    '">' + firstLetter + '</div>' +
                    '<div class="comment-content" style="flex: 1;">' +
                    '<div class="comment-header d-flex justify-content-between align-items-center mb-2">' +
                    '<h6 class="mb-0" style="' +
                    'font-weight: 600;' +
                    'color: #2c3e50;' +
                    'font-size: 1.1em;' +
                    '">' + comment.userName + '</h6>' +
                    '</div>' +
                    '<div class="comment-text" style="' +
                    'color: #34495e;' +
                    'line-height: 1.6;' +
                    'font-size: 1em;' +
                    'word-break: break-word;' +
                    '">' + comment.description + '</div>' +
                    '</div>' +
                    '</div>' +
                    '<div class="comment-date-decoration" style="' +
                    'position: absolute;' +
                    'top: 15px;' +
                    'right: 15px;' +
                    'background: linear-gradient(135deg, rgba(108, 117, 125, 0.9), rgba(73, 80, 87, 0.9));' +
                    'color: white;' +
                    'padding: 6px 12px;' +
                    'border-radius: 12px;' +
                    'font-size: 0.8em;' +
                    'font-weight: 600;' +
                    'text-align: center;' +
                    'box-shadow: 0 2px 8px rgba(0,0,0,0.2);' +
                    'backdrop-filter: blur(5px);' +
                    'border: 1px solid rgba(255,255,255,0.3);' +
                    'min-width: 50px;' +
                    'z-index: 10;' +
                    '">' + dateDisplay + '</div>' +
                    '</div>';

                // 添加调试信息到控制台
                console.log('评论日期信息:', {
                  userName: comment.userName,
                  addTime: comment.addTime,
                  dateDisplay: dateDisplay
                });
              }
            }

            $("#commentsList").html(html);

            // 应用表情解析 - 改为安全的异步处理
            setTimeout(function() {
              $(".comment-text").each(function () {
                var info = $(this).text().trim();
                // 只有在表情数据已加载且AnalyticEmotion函数可用时才处理
                if (typeof AnalyticEmotion === 'function' && window.flag) {
                  var newInfo = AnalyticEmotion(info);
                  $(this).html(newInfo);
                }
                // 如果表情数据未加载，什么都不做，保持原文本
              });
            }, 100);
          }

          // 渲染分页导航
          function renderPagination(data) {
            var html = '';
            var totalPages = data.totalPages;
            var currentPage = data.currentPage;

            if (totalPages <= 1) {
              $("#commentPagination").html('');
              return;
            }

            // 上一页按钮
            var prevDisabled = currentPage === 1 ? 'disabled' : '';
            html += '<li class="page-item ' + prevDisabled + '">' +
                '<a class="page-link" href="javascript:void(0)" onclick="loadComments(' + (currentPage - 1) + ')" ' +
                'style="border-radius: 10px 0 0 10px; border: none; background: rgba(255,255,255,0.2); color: white; margin-right: 5px;">' +
                '<i class="fas fa-chevron-left"></i>' +
                '</a>' +
                '</li>';

            // 页码按钮
            var startPage = Math.max(1, currentPage - 2);
            var endPage = Math.min(totalPages, currentPage + 2);

            if (startPage > 1) {
              html += '<li class="page-item">' +
                  '<a class="page-link" href="javascript:void(0)" onclick="loadComments(1)" ' +
                  'style="border-radius: 10px; border: none; background: rgba(255,255,255,0.2); color: white; margin-right: 5px;">1</a>' +
                  '</li>';
              if (startPage > 2) {
                html += '<li class="page-item disabled">' +
                    '<span class="page-link" style="border: none; background: transparent; color: white;">...</span>' +
                    '</li>';
              }
            }

            for (var i = startPage; i <= endPage; i++) {
              var activeClass = i === currentPage ? ' active' : '';
              var bgColor = i === currentPage ? 'rgba(255,255,255,0.3)' : 'rgba(255,255,255,0.2)';
              var fontWeight = i === currentPage ? 'bold' : 'normal';

              html += '<li class="page-item' + activeClass + '">' +
                  '<a class="page-link" href="javascript:void(0)" onclick="loadComments(' + i + ')" ' +
                  'style="border-radius: 10px; border: none; background: ' + bgColor + '; color: white; margin-right: 5px; font-weight: ' + fontWeight + ';">' + i + '</a>' +
                  '</li>';
            }

            if (endPage < totalPages) {
              if (endPage < totalPages - 1) {
                html += '<li class="page-item disabled">' +
                    '<span class="page-link" style="border: none; background: transparent; color: white;">...</span>' +
                    '</li>';
              }
              html += '<li class="page-item">' +
                  '<a class="page-link" href="javascript:void(0)" onclick="loadComments(' + totalPages + ')" ' +
                  'style="border-radius: 10px; border: none; background: rgba(255,255,255,0.2); color: white; margin-right: 5px;">' + totalPages + '</a>' +
                  '</li>';
            }

            // 下一页按钮
            var nextDisabled = currentPage === totalPages ? 'disabled' : '';
            html += '<li class="page-item ' + nextDisabled + '">' +
                '<a class="page-link" href="javascript:void(0)" onclick="loadComments(' + (currentPage + 1) + ')" ' +
                'style="border-radius: 0 10px 10px 0; border: none; background: rgba(255,255,255,0.2); color: white;">' +
                '<i class="fas fa-chevron-right"></i>' +
                '</a>' +
                '</li>';

            $("#commentPagination").html(html);
          }

          // 更新统计信息
          function updateStats(data) {
            $("#totalCommentsCount").text(data.totalComments);
            $("#currentPageInfo").text(data.currentPage + "/" + data.totalPages);
            $("#totalPagesCount").text(data.totalPages);
          }

          // 表情解析函数 - 安全版本
          function transform() {
            $(".des").each(function () {
              var info = $(this).text().trim();
              var newInfo = AnalyticEmotion(info);
              console.log("newInfo: " + newInfo);
              $(this).text("");
              var newEle = '<p>';
              newEle += newInfo;
              newEle += '</p>';
              $(this).append(newEle)
            });
            return true;

          }

          // 页面加载完成后的初始化
          $(window).on('load', function () {
            console.log("页面开始初始化");

            // 直接显示页面
            $("#atome").addClass("d-none");
            $("#main").removeClass("d-none");

            // 立即加载评论
            loadComments(1);

            // 恢复表情功能绑定，现在是安全的
            if ($('.inline-face-icon').length > 0) {
              $('.inline-face-icon').SinaEmotion($('#inlineDescription'));
            }
          });
        </script>

        <!-- 添加评论动画样式 -->
        <style>
          @keyframes slideInUp {
            from {
              opacity: 0;
              transform: translateY(30px);
            }
            to {
              opacity: 1;
              transform: translateY(0);
            }
          }

          .comment-item:hover {
            transform: translateY(-2px);
            transition: all 0.3s ease;
            box-shadow: 0 12px 40px rgba(0,0,0,0.15);
          }

          .page-link:hover {
            background: rgba(255,255,255,0.4) !important;
            transform: translateY(-2px);
            transition: all 0.2s ease;
          }
        </style>
        <jsp:include page="foot.jsp"/>
    </div>
</body>

</html>

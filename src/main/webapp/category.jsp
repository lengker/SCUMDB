<%--
  Created by IntelliJ IDEA.
  User: zhuhaipeng
  Date: 2019/11/6
  Time: 14:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="referrer" content="no-referrer"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="font/iconfont.css">


    <script src="js/jquery-3.4.1.min.js"></script>
    <script src="js/bootstrap.bundle.min.js"></script>
    <script src="js/bootstrap.min.js"></script>

    <link rel="stylesheet" href="css/category.css">
    <link rel="stylesheet" href="css/dreamlike.css"/>
    <title>分类</title>
    <link rel="icon" type="image/x-icon" href="img/logo.png">
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

    a {
        text-decoration: none;
        color: grey;
    }
</style>
<link rel="stylesheet" href="css/mofang.css">

<script>
    function hideOrShow() {
        var $left = $("#left-arr");
        var $right = $("#right-arr");
        var $dongzuo = $("#dongzuo");
        var $xuanyi = $("#xuanyi");
        // 判断动作按钮是否已经移动
        if ($dongzuo.offset().left >= 107) {
            console.log($dongzuo.offset().left)
            $right.show();
            $left.hide();
            $dongzuo.css("margin-left", "-=110px");
            $dongzuo.hide();
            $xuanyi.show();

        } else {
            console.log($dongzuo.offset().left)
            $left.show()
            $right.hide()
            $xuanyi.hide();
            $dongzuo.css("margin-left", "+=110px");
            $dongzuo.show();

        }
    }
</script>

<body class="bg-dark">
<script>
    $(document).ready(function () {
        if ($(window).load) {
            $("#atome").addClass("d-none");
            $("#main").removeClass("d-none")
        }
    });

</script>
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
</div>
<div id="main" class="d-none">
    <div id="trans3DDemo1">
        <div id="trans3DBoxes1">
            <div class="a1"></div>
            <div class="a2"></div>
            <div class="a3"></div>
            <div class="a4"></div>
            <div class="a5"></div>
            <div class="a6"></div>
        </div>
    </div>


    <script src='js/TweenMax.min.js'></script>
    <script src="js/index.js"></script>
    <jsp:include page="header.jsp"/>
    <div class="middle-show clearfix">
        <div class="row mt-4">
            <div class="col-md-12" id="menu">
                <span id="left-arr" class="iconfont iconxiangzuo mr-2" style="color: white;"
                      onclick="hideOrShow()"></span>
                <a href="${pageContext.request.contextPath}/category.do?category=动作" id="dongzuo">动作</a>
                <a href="${pageContext.request.contextPath}/category.do?category=冒险" class="ml-3">冒险</a>
                <a href="${pageContext.request.contextPath}/category.do?category=动画" class="ml-3">动画</a>
                <a href="${pageContext.request.contextPath}/category.do?category=惊悚" class="ml-3">惊悚</a>
                <a href="${pageContext.request.contextPath}/category.do?category=犯罪" class="ml-3">犯罪</a>
                <a href="${pageContext.request.contextPath}/category.do?category=喜剧" class="ml-3">喜剧</a>
                <a href="${pageContext.request.contextPath}/category.do?category=剧情" class="ml-3">剧情</a>
                <a href="${pageContext.request.contextPath}/category.do?category=奇幻" class="ml-3">奇幻</a>
                <a href="${pageContext.request.contextPath}/category.do?category=科幻" class="ml-3">科幻</a>
                <a href="${pageContext.request.contextPath}/category.do?category=恐怖" class="ml-3">恐怖</a>
                <a href="${pageContext.request.contextPath}/category.do?category=悬疑" class="ml-3" id="xuanyi"
                   style="display: none;">悬疑</a>
                <span id="right-arr" class="iconfont iconyou ml-2" style="color: white; display: none;"
                      onclick="hideOrShow()"></span>
            </div>
        </div>


        <div class="row mt-3 clearfix">
            <div class="col-md-8" id="category">
                <h5 class="text-secondary d-inline-block">排序：</h5>
                <div class="dropdown d-inline-block ml-3" id="year">
                    <a class="dropdown-toggle" href="#" role="" id="dropdownMenuLink" data-toggle="dropdown"
                       aria-haspopup="true" aria-expanded="false">年</a>
                    <div class="dropdown-menu bg-dark border-0" aria-labelledby="dropdownMenuLink">
                        <a class="dropdown-item" href="#">2019</a>
                        <a class="dropdown-item mt-1" href="#">2018</a>
                        <a class="dropdown-item mt-1" href="#">2017</a>
                    </div>
                </div>
                <div class="dropdown d-inline-block ml-3" id="country">
                    <a class="dropdown-toggle" href="#" role="" id="dropdownMenuLink" data-toggle="dropdown"
                       aria-haspopup="true" aria-expanded="false">
                        国家
                    </a>
                    <div class="dropdown-menu bg-dark border-0" aria-labelledby="dropdownMenuLink">
                        <a class="dropdown-item" href="#">中国</a>
                        <a class="dropdown-item mt-1" href="#">美国</a>
                        <a class="dropdown-item mt-1" href="#">英国</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="row text-center">
                    <span class="iconfont iconwujiaoxing-" style="color: yellow; font-size: 1.2em;"></span>
                    <div class="myprogress  ">
                        <div class="myprogress_bg">
                            <div class="myprogress_bar"></div>
                        </div>
                        <div class="myprogress_btn"></div>
                    </div>
                    <span class="text d-block" style="color: white;">0.0</span><span class="text-white">&nbsp; - &nbsp;10.0</span>
                </div>
            </div>
        </div>

        <div class="row mt-4" style="opacity: 0.7">
            <div class="row">
                <div class="col-md-12">
                    <div class="card-deck text-white">
                        <c:forEach var="m" items="${movies}" varStatus="status">
                            <c:if test="${status.index < 6}">
                                <div class="card bg-dark" style="max-width: 200px; max-height: 450px">
                                    <a href="${pageContext.request.contextPath}/detail.do?movieName=${m.name}">
                                        <img src="${m.image }" class="card-img-top" alt="">
                                    </a>
                                    <div class="card-body">
                                        <h5 class="card-title">${m.name}</h5>
                                        <p class="card-text  align-middle">
                                            <small class="text-muted">${m.years}</small>
                                            <small class="float-right">
                                                <a href="#" onclick="collection(this);return false;"
                                                   style="text-decoration: none">
                                                    <span class="iconfont iconaixin">&nbsp;</span>
                                                </a>
                                                <a href="###" style="text-decoration: none">
                                                    <span class="iconfont iconai-eye">&nbsp;</span>
                                                </a>
                                                <span class="iconfont iconwujiaoxing-"
                                                      style="color: yellow;">&nbsp;</span>
                                                <span id="m-score" class="align-middle"
                                                      style="color: yellow;">${m.score}</span>
                                            </small>
                                        </p>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>


                    </div>
                </div>
            </div>
            <div class="row mt-3">
                <div class="col-md-12">
                    <div class="card-deck text-white">
                        <c:forEach var="m" items="${movies}" varStatus="status">
                            <c:if test="${status.index >= 6}">
                                <div class="card bg-dark" style="max-width: 200px; max-height: 450px">
                                    <a href="${pageContext.request.contextPath}/detail.do?movieName=${m.name}">
                                        <img src="${m.image }" class="card-img-top" alt="">
                                    </a>
                                    <div class="card-body">
                                        <h5 class="card-title">${m.name}</h5>
                                        <p class="card-text  align-middle">
                                            <small class="text-muted">${m.years}
                                            </small>
                                            <small class="float-right">

                                                <a href="#" onclick="collection(this);return false;"
                                                   style="text-decoration: none">
                                                    <span class="iconfont iconaixin">&nbsp;</span>
                                                </a>

                                                <a href="###" style="text-decoration: none">
                                                    <span class="iconfont iconai-eye">&nbsp;</span>
                                                </a>
                                                <span class="iconfont iconwujiaoxing-"
                                                      style="color: yellow;">&nbsp;</span>
                                                <span id="m-score" class="align-middle"
                                                      style="color: yellow;">${m.score}</span>
                                            </small>
                                        </p>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>
                </div>
            </div>


            <div class="row mt-3" style="width: 1420px">
                <div class="col-md-12">
                    <nav aria-label="Page navigation example">
                        <ul class="pagination justify-content-center " id="fenye">

                            <li class="page-item disabled" id="leftArr">
                                <a class="bg-dark page-link border-secondary"
                                   href="#" tabindex="-1" aria-disabled="true">&laquo;</a>
                            </li>
                            <%
                                int number = (Integer) request.getAttribute("pageNumber");
                                for (int i = 0; i < number; i++) {
                                    if (i != 0) {

                            %>
                            <li class="page-item">
                                <a class="bg-dark  page-link border-secondary "
                                   href="#"><%=(i + 1)%>
                                </a>
                            </li>
                            <%
                            } else {
                            %>
                            <li class="page-item">
                                <a class="bg-dark myactive page-link border-secondary "
                                   href="#"><%=(i + 1)%>
                                </a>

                            </li>
                            <%
                                }
                            %>

                            <%
                                }
                            %>
                            <li class="page-item " id="rightArr">
                                <a class="bg-dark page-link border-secondary" href="#">&raquo;</a>
                            </li>

                        </ul>
                    </nav>
                </div>
            </div>
        </div>

    </div>

    <script src="js/category.js"></script>

    <jsp:include page="foot.jsp"/>
</div>
</body>
</html>

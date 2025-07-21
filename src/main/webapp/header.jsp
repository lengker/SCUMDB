<%@page import="domain.User" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
  /* 实时搜索样式 */
  .search-result-item:hover {
    background-color: #343a40 !important;
  }

  .search-result-item {
    transition: background-color 0.2s ease;
  }

  #searchResults {
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.3);
  }

  #searchInput:focus {
    box-shadow: 0 0 0 0.2rem rgba(40, 167, 69, 0.25);
    border-color: #28a745;
  }
</style>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>

<div class="container-fluid bg-dark">
    <header class="ml-5">
        <nav class="navbar navbar-expand-md navbar-dark bg-dark">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/main.do">
                <img src="images/movie.png" alt="" style="height: auto; width: 40px;">
            </a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse"
                    aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarCollapse">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item active">
                        <a class="nav-link" href="${pageContext.request.contextPath}/main.do">首页
                            <span class="sr-only">(current)</span>
                        </a>
                    </li>
                    <li class="nav-item"><a class="nav-link"
                                            href="${pageContext.request.contextPath}/category.do?category=喜剧">喜剧</a></li>
                    <li class="nav-item"><a class="nav-link"
                                            href="${pageContext.request.contextPath}/category.do?category=剧情">剧情</a></li>
                    <li class="nav-item"><a class="nav-link"
                                            href="${pageContext.request.contextPath}/category.do?category=奇幻">奇幻</a></li>
                    <li class="nav-item"><a class="nav-link"
                                            href="${pageContext.request.contextPath}/category.do?category=科幻">科幻</a></li>
                    <li class="nav-item"><a class="nav-link"
                                            href="${pageContext.request.contextPath}/category.do?category=动画">动画</a></li>
                    <li class="nav-item"><a class="nav-link"
                                            href="${pageContext.request.contextPath}/category.do?category=恐怖">恐怖</a></li>
                    <li class="nav-item"><a class="nav-link"
                                            href="${pageContext.request.contextPath}/category.do?category=悬疑">悬疑</a></li>
                    <li class="nav-item"><a class="nav-link"
                                            href="${pageContext.request.contextPath}/category.do?category=犯罪">犯罪</a></li>
                    <li class="nav-item"><a class="nav-link"
                                            href="${pageContext.request.contextPath}/category.do?category=冒险">冒险</a></li>
                    <li class="nav-item"><a class="nav-link"
                                            href="${pageContext.request.contextPath}/category.do?category=动作">动作</a></li>
                </ul>


                <div class="form-inline mt-2 mt-md-0 mr-3 position-relative">
                    <input class="form-control mr-sm-2" type="text" id="searchInput" placeholder="搜索电影..."
                           aria-label="Search" autocomplete="off">
                    <button class="btn btn-outline-success my-2 my-sm-0" type="button" onclick="performSearch()">
                        <span class="iconfont iconsousuo"></span>
                    </button>
                    <!-- 实时搜索结果下拉框 -->
                    <div id="searchResults" class="position-absolute bg-dark border border-secondary rounded"
                         style="top: 100%; left: 0; right: 0; z-index: 1000; max-height: 400px; overflow-y: auto; display: none;">
                    </div>
                </div>


                <ul class="navbar-nav mr-4">
                    <li class="nav-item dropdown" >
                        <%
                            User user = (User) session.getAttribute("user");
                            if (user != null) {
                        %>
                        <c:if test="${user.username == \"admin\"}">
                            <a href="management/index.jsp" onclick="jump()" style="color: rgba(255,255,255,.5)">
                                    ${user.username }
                            </a>
                        </c:if>
                        <c:if test="${user.username != \"admin\"}">
                            <a class="nav-link dropdown-toggle" href=""
                               id="navbardrop" data-toggle="dropdown" style="color: rgba(255,255,255,.5)">
                                    ${user.username }
                            </a>
                        </c:if>
                        <%
                        } else {
                        %>
                        <a href="${pageContext.request.contextPath}/loginOrRegister.do" id="navbardrop" style="color: rgba(255,255,255,.5)">我的账户</a>
                        <%
                            }
                        %>
                        <div class="dropdown-menu">
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/history">历史浏览</a>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/userInfo">修改账户</a>
                            <div class="dropdown-divider"></div>
                            <%
                                if (user != null) {
                            %>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/logout.do">退出</a>
                            <%
                            } else {
                            %>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/login.do">登录</a>
                            <%
                                }
                            %>
                        </div>
                    </li>
                </ul>
                <script>
                  function jump() {
                    window.location.href="http://localhost:8080/MovieWebsite/management/index.jsp";
                  }
                </script>
            </div>
        </nav>
    </header>

    <!-- 结束 -->
</div>

<script>
  // 确保jQuery已加载
  if (typeof $ === 'undefined') {
    document.write('<script src="${pageContext.request.contextPath}/js/jquery-3.4.1.min.js"><\/script>');
  }

  var url = decodeURI(window.location.search);
  var type = url.substring(url.lastIndexOf("=") + 1);
  $(".navbar-nav").children().each(function () {
    var temp = $(this).children().text().trim();
    if (type !== temp) {
      $(this).removeClass("active");
    } else {
      $(this).addClass("active");
    }
  });

  // 实时搜索功能
  var searchTimeout;
  var searchInput = document.getElementById('searchInput');
  var searchResults = document.getElementById('searchResults');

  // 监听输入事件
  searchInput.addEventListener('input', function() {
    clearTimeout(searchTimeout);
    var searchTerm = this.value.trim();

    if (searchTerm.length === 0) {
      searchResults.style.display = 'none';
      return;
    }

    // 延迟300ms执行搜索，避免频繁请求
    searchTimeout = setTimeout(function() {
      performRealTimeSearch(searchTerm);
    }, 300);
  });

  // 点击其他地方隐藏搜索结果
  document.addEventListener('click', function(e) {
    if (!searchInput.contains(e.target) && !searchResults.contains(e.target)) {
      searchResults.style.display = 'none';
    }
  });

  // 实时搜索函数
  function performRealTimeSearch(searchTerm) {
    $.ajax({
      url: '${pageContext.request.contextPath}/realtimeSearch.do',
      type: 'POST',
      data: {search: searchTerm},
      dataType: 'json',
      success: function(data) {
        displaySearchResults(data);
      },
      error: function() {
        searchResults.innerHTML = '<div class="p-3 text-light">搜索出错，请重试</div>';
        searchResults.style.display = 'block';
      }
    });
  }

  // 显示搜索结果
  function displaySearchResults(movies) {
    if (movies.length === 0) {
      searchResults.innerHTML = '<div class="p-3 text-light">未找到相关电影</div>';
    } else {
      var html = '';
      movies.forEach(function(movie) {
        html += '<div class="search-result-item p-2 border-bottom border-secondary" style="cursor: pointer;" onclick="goToMovie(\'' + movie.name + '\')">';
        html += '<div class="d-flex align-items-center">';
        html += '<img src="' + movie.image + '" alt="' + movie.name + '" style="width: 40px; height: 60px; object-fit: cover; margin-right: 10px;">';
        html += '<div>';
        html += '<div class="text-light font-weight-bold">' + movie.name + '</div>';
        html += '<div class="text-muted small">' + movie.years + ' · ' + movie.score + '分</div>';
        html += '</div>';
        html += '</div>';
        html += '</div>';
      });
      searchResults.innerHTML = html;
    }
    searchResults.style.display = 'block';
  }

  // 跳转到电影详情页
  function goToMovie(movieName) {
    window.location.href = '${pageContext.request.contextPath}/detail.do?movieName=' + encodeURIComponent(movieName);
  }

  // 执行搜索（点击搜索按钮）
  function performSearch() {
    var searchTerm = searchInput.value.trim();
    if (searchTerm) {
      window.location.href = '${pageContext.request.contextPath}/search.do?search=' + encodeURIComponent(searchTerm);
    }
  }

  // 回车键搜索
  searchInput.addEventListener('keypress', function(e) {
    if (e.key === 'Enter') {
      performSearch();
    }
  });
</script>
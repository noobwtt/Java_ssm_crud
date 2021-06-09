<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>首页</title>
    <%
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>

    <%--引入jquery--%>
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-2.0.3.min.js"></script>
    <!-- 最新版本的 Bootstrap 核心 CSS 文件 -->
    <link rel="stylesheet" href="${APP_PATH}/static/bootstrap-3.4.1-dist/css/bootstrap.min.css" integrity="sha384-HSMxcRTRxnN+Bdg0JdbxYKrThecOKuH5zCYotlSAcp1+c8xmyTe9GYg1l9a69psu" crossorigin="anonymous">
    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="${APP_PATH}/static/bootstrap-3.4.1-dist/js/bootstrap.min.js" integrity="sha384-aJ21OjlMXNL5UyIl/XNwTMqvzeRMZH2w8c5cRVpzpU8Y5bApTppSuUkhZXN0VxHd" crossorigin="anonymous"></script>

</head>
<body>

<div class="emp_container">
    <!-- 导航条 -->
    <%@ include file="head.jsp"%>

    <!-- 中间部分（包括左边栏和员工/部门表单显示部分） -->
    <div class="div_body" style="position:relative; top:-15px;">
        <!-- 左侧栏 -->
        <%@ include file="leftsidebar.jsp"%>

        <div class="col-sm-10">
            <img src="${APP_PATH}/static/img/pikachu.png" style="height:500px;width:1000px"/>
        </div>

        <!-- 尾部 -->
        <%@ include file="foot.jsp"%>
    </div>
</div>

</body>
</html>

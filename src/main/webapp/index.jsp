<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登录页面</title>
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

<%--登录框布局--%>
<div class="container">
    <div class="row">
        <div class="col-md-4 col-md-offset-4">
            <div class="login-panel panel panel-default" style="text-align: -moz-center">
                <%--面板标题--%>
                <div class="panel-heading">
                    <h3 class="panel-title" style="text-align: center;">登录</h3>
                </div>
                <%--面板内容--%>
                <div class="panel-body">
                    <form role="form" action="#" method="post" id="login_form">
                        <div class="form-group">
                            <input class="form-control" placeholder="用户名:admin" name="username">
                        </div>
                        <div class="form-group">
                            <input class="form-control" placeholder="密码:1234" name="password" type="password">
                        </div>
                        <div>
                            <%--默认情况下button的长度是自动的，如果你想设置跟父容器等宽的话，可以加一个btn-block--%>
                            <button class="btn btn-success btn-block" id="login_btn">登录</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    //首页进行登录
    $(function () {
        $("#login_btn").click(function () {
            $.ajax({
                url:"${APP_PATH}/dologin",
                type:"post",
                data:$("#login_form").serialize(),
                success:function (result) {
                    if(result.code == 100){
                        alert("登录成功");
                        window.location.href="${APP_PATH}/main";
                    }else {
                        alert(result.extend.login_error);
                    }
                }
            });
        });
    });
</script>
</body>
</html>

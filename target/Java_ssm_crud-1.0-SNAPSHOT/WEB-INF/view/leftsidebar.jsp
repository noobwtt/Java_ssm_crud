<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    pageContext.setAttribute("APP_PATH",request.getContextPath());
%>

<div class="panel-group col-sm-2" id="sidebar_left" role="tablist" aria-multiselectable="true">
    <%--首页--%>
    <ul class="nav nav-pills nav-stacked">
        <li role="presentation" class="active">
            <a href="#" class="home_page">
                <span class="glyphicon glyphicon-home" aria-hidden="true">首页</span>
            </a>
        </li>
        <li role="presentation" class="divider"></li>
    </ul>
    <%--员工管理--%>
    <ul class="nav nav-pills nav-stacked">
        <li role="presentation" class="active">
            <a href="#" data-toggle="collapse" data-target="#collapse_emp">
                <span class="glyphicon glyphicon-user" aria-hidden="true">员工管理</span>
            </a>
            <ul class="nav nav-pills nav-stacked" id="collapse_emp">
                <li role="presentation"><a href="#" class="emp_info">员工信息</a></li>
                <li role="presentation"><a href="#">新增员工</a></li>
                <li role="presentation"><a href="#">删除员工</a></li>
            </ul>
        </li>
        <li role="presentation" class="divider"></li>
    </ul>
    <%--部门管理--%>
    <ul class="nav nav-pills nav-stacked">
        <li role="presentation" class="active">
            <a href="#" data-toggle="collapse" data-target="#collapse_dept">
                <span class="glyphicon glyphicon-user" aria-hidden="true">部门管理</span>
            </a>
            <ul class="nav nav-pills nav-stacked" id="collapse_dept">
                <li role="presentation"><a href="#" class="dept_info">部门信息</a></li>
                <li role="presentation"><a href="#">新增部门</a></li>
                <li role="presentation"><a href="#">删除部门</a></li>
            </ul>
        </li>
    </ul>

</div>

<script type="text/javascript">
    //跳转到首页
    $(".home_page").click(function () {
        $(this).attr("href", "/main");
    });
    // 跳转到员工页面
    $(".emp_info").click(function () {
        $(this).attr("href", "/employeePage");
    });
    //跳转到部门页面
    $(".dept_info").click(function () {
        $(this).attr("href","/departmentPage");
    });
</script>


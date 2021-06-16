<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>部门信息</title>
    <%
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>

    <%--引入jquery--%>
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-2.0.3.min.js"></script>
    <!-- 最新版本的 Bootstrap 核心 CSS 文件 -->
    <link rel="stylesheet" href="${APP_PATH}/static/bootstrap-3.4.1-dist/css/bootstrap.min.css" integrity="sha384-HSMxcRTRxnN+Bdg0JdbxYKrThecOKuH5zCYotlSAcp1+c8xmyTe9GYg1l9a69psu" crossorigin="anonymous">
    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="${APP_PATH}/static/bootstrap-3.4.1-dist/js/bootstrap.min.js" integrity="sha384-aJ21OjlMXNL5UyIl/XNwTMqvzeRMZH2w8c5cRVpzpU8Y5bApTppSuUkhZXN0VxHd" crossorigin="anonymous"></script>
    <!-- 自定义的js文件-->
    <script type="text/javascript"  src="${APP_PATH}/static/js/MyFunction.js"></script>
</head>
<body>

<div class="emp_container">
    <!-- 导航条 -->
    <%@ include file="head.jsp"%>

    <!-- 中间部分（包括左边栏和员工/部门表单显示部分） -->
    <div class="div_body" style="position:relative; top:-15px;">
        <!-- 左侧栏 -->
        <%@ include file="leftsidebar.jsp"%>

        <div class="emp_info col-sm-10">
            <div class="container">
                <%--俩按钮和搜索框--%>
                <div class="row">
                    <div class="col-md-2">
                        <button class="btn btn-success" id="emp_add_btn">
                            <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
                        </button>
                        <button class="btn btn-success" id="emp_deleteBatch_btn">
                            <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>删除
                        </button>
                    </div>
                    <%--搜索框--%>
                    <div class="col-md-2 col-md-offset-8">
                        <div class="input-group">
                            <input type="text" class="form-control"  placeholder="部门id" id="search_input">
                            <span class="input-group-btn">
                            <button class="btn btn-default" type="button" id="search_emp">搜索</button>
                        </span>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <table class="table table-hover" id="MyDeptTable">
                        <thead>
                        <tr>
                            <th><input type="checkbox" id="checkAll"></th>
                            <th>deptId</th>
                            <th>deptName</th>
                            <th>deptLeader</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%--表格内容--%>
                        </tbody>
                    </table>
                </div>

                <div class="row">
                    <%--分页信息--%>
                    <div class="col-md-6" id="page_info_area"></div>
                    <%--分页条--%>
                    <div class="col-md-6" id="page_nav_area"></div>
                </div>

                <!-- 尾部 -->
                <%@ include file="foot.jsp"%>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(function () {
        to_page(1)
    });
    function to_page(pn) {
        $.ajax({
            url:"${APP_PATH}/allDepts",
            data:"pn="+pn,
            type:"GET",
            success:function (result) {
                // 解析显示部门数据
                build_depts_table(result);
            }
        });
    }
    function build_depts_table(result) {
        //清空table表格
        $("#MyDeptTable tbody").empty();
        var depts = result.extend.MyPageInfo.list;

        $.each(depts,function (index,item) {
            var checkTd = $("<td><input type='checkbox' class='checkOne'></td>");
            var deptIdTd = $("<td></td>").append(item.deptId);
            var deptNameTd = $("<td></td>").append(item.deptName);
            var deptLeaderTd = $("<td></td>").append(item.deptLeader);
            var edit_btn = $("<button></button>").addClass("btn btn-primary btn-xs edit_input")
                .append("<span></span>").addClass("glyphicon glyphicon-pencil").append("编辑");
            var del_btn = $("<button></button>").addClass("btn btn-danger btn-xs del_input")
                .append("<span></span>").addClass("glyphicon glyphicon-trash").append("删除");
            var btnTd = $("<td></td>").append(edit_btn).append(" ").append(del_btn);

            $("<tr></tr>")
                .append(checkTd)
                .append(deptIdTd)
                .append(deptNameTd)
                .append(deptLeaderTd)
                .append(btnTd)
                .appendTo("#MyDeptTable tbody")
        });
    }

    //checkbox全选，全不选
    $("#checkAll").click(function () {
        $(".checkOne").prop("checked",$("#checkAll").prop("checked"));
    });
    $(document).on("click",".checkOne",function () {
        if ($(".checkOne:checked").length==$(".checkOne").length){
            $("#checkAll").prop("checked",true);
        }else {
            $("#checkAll").prop("checked",false);
        }
    });
</script>

</body>
</html>

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
    <script type="text/javascript"  src="${APP_PATH}/static/js/getDept.js"></script>
    <script type="text/javascript"  src="${APP_PATH}/static/js/pageInfo.js"></script>
</head>
<body>

<div class="emp_container">
    <!-- 导航条 -->
    <%@ include file="head.jsp"%>

    <!-- 中间部分（包括左边栏和员工/部门表单显示部分） -->
    <div class="div_body" style="position:relative; top:-15px;">
        <!-- 左侧栏 -->
        <%@ include file="leftsidebar.jsp"%>

        <!-- 中间内容 -->
        <div class="emp_info col-sm-10">

            <div class="panel panel-default">
                <%--面板头部--%>
                <div class="panel panel-heading">
                    <div class="row">
                        <%--按钮--%>
                        <div class="col-md-2">
                            <button class="btn btn-success" id="dept_deleteBatch_btn">
                                <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>删除
                            </button>
                        </div>
                    </div>
                </div>

                <%--表格数据--%>
                <table class="table table-hover" id="MyDeptTable">
                    <thead>
                        <tr>
                            <th><input type="checkbox" id="checkAll"></th>
                            <th>部门id</th>
                            <th>部门名</th>
                            <th>部长</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%--表格内容--%>
                    </tbody>
                </table>

                <div class="panel panel-body">
                        <%--分页信息--%>
                        <div class="col-md-6" id="page_info_area"></div>
                        <%--分页条--%>
                        <div class="col-md-6" id="page_nav_area"></div>
                </div>

            </div>

            <!-- 尾部 -->
            <%@ include file="foot.jsp"%>
        </div>
    </div>
</div>

<%@ include file="departmentAdd.jsp"%>
<%@ include file="departmentUpdate.jsp"%>

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
                //1.解析显示部门数据
                build_depts_table(result);
                //2.解析显示分页信息
                build_page_info(result);
                //3.解析显示分页条
                build_page_name(result);
            }
        });
    }
    //解析显示部门数据
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

            //为编辑按钮添加一个自定义的属性，来表示当前员工id
            edit_btn.attr("edit-id",item.deptId);

            var del_btn = $("<button></button>").addClass("btn btn-danger btn-xs del_input")
                .append("<span></span>").addClass("glyphicon glyphicon-trash").append("删除");

            //为删除按钮添加一个自定义的属性，来表示当前员工id
            del_btn.attr("del-id",item.deptId);

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

    //点击删除，发送ajax请求
    $(document).on("click",".del_input",function () {
        var delId = $(this).attr("del-id");
        if (confirm("确认删除吗?")){
            $.ajax({
                url:"${APP_PATH}/delDept/"+delId,
                type:"DELETE",
                success:function (result) {
                    to_page(current_page);
                }
            });
        }
    });

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

    //批量删除
    $("#dept_deleteBatch_btn").click(function () {
        if ($(".checkOne:checked").length == 0){
            alert("请勾选需要删除的部门");
        }else {
            var del_idstr = "";
            $.each($(".checkOne:checked"),function () {
                //勾选的部门id字符串
                del_idstr += $(this).parents("tr").find("td:eq(1)").text()+",";
            });
            //去除末位
            del_idstr = del_idstr.substring(0, del_idstr.length-1);

            if(confirm("确认删除该部门吗？")){
                //发送ajax请求删除
                $.ajax({
                    url:"${APP_PATH}/delDeptBatch/"+del_idstr,
                    type:"DELETE",
                    success:function (result) {
                        //回到当前页面
                        to_page(current_page);
                        //checkAll的状态变更为false
                        $("#checkAll").prop("checked",false);
                    }
                });
            }
        }
    });

</script>

</body>
</html>

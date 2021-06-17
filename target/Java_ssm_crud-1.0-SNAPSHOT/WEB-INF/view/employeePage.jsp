<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>员工信息</title>
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
                            <button class="btn btn-success" id="emp_deleteBatch_btn">
                                <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>删除
                            </button>
                        </div>
                        <%--搜索框--%>
                        <div class="col-md-2 col-md-offset-8">
                            <div class="input-group">
                                <input type="text" class="form-control"  placeholder="员工id" id="search_input">
                                <span class="input-group-btn">
                                    <button class="btn btn-default" type="button" id="search_emp">搜索</button>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>

                <%--表格数据--%>
                <table class="table table-hover" id="MyEmpTable">
                    <thead>
                        <tr>
                            <th><input type="checkbox" id="checkAll"></th>
                            <th>员工id</th>
                            <th>员工名</th>
                            <th>性别</th>
                            <th>邮箱</th>
                            <th>所属部门</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%--表格内容--%>
                    </tbody>
                </table>

                <div class="panel panel-body">
                    <%--分页信息和分页条--%>
                    <div class="row">
                        <%--分页信息--%>
                        <div class="col-md-6" id="page_info_area"></div>
                        <%--分页条--%>
                        <div class="col-md-6" id="page_nav_area"></div>
                    </div>
                </div>
            </div>

            <!-- 尾部 -->
            <%@ include file="foot.jsp"%>
        </div>
    </div>
</div>

<%@ include file="employeeAdd.jsp"%>
<%@ include file="employeeUpdate.jsp"%>


<script type="text/javascript">
    var current_page;

    //页面加载完成后，得到分页数据
    $(function () {
        to_page(1);
    });
    //分页数据，跳转
    function to_page(pn){
        $.ajax({
            url:"${APP_PATH}/emps",
            data:"pn="+pn,
            type:"GET",
            success:function (result) {
                // console.log(result);
                //1.解析显示员工数据
                build_emps_table(result);
                //2.解析显示分页信息
                build_page_info(result);
                //3.解析显示分页条
                build_page_name(result);
            }
        });
    }
    //1.解析显示员工数据
    function build_emps_table(result) {
        //清空table表格
        $("#MyEmpTable tbody").empty();
        var emps = result.extend.MyPageInfo.list;
        $.each(emps,function (index,item) {

            var checkTd = $("<td><input type='checkbox' class='checkOne'></td>");
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender=='M'?'男':'女');
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);

            // <button class="btn btn-primary btn-xs edit_input">
            //         <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑
            // </button>
            var edit_btn = $("<button></button>").addClass("btn btn-primary btn-xs edit_input")
                .append("<span></span>").addClass("glyphicon glyphicon-pencil").append("编辑");

            //为编辑按钮添加一个自定义的属性，来表示当前员工id
            edit_btn.attr("edit-id",item.empId);

            var del_btn = $("<button></button>").addClass("btn btn-danger btn-xs del_input")
                .append("<span></span>").addClass("glyphicon glyphicon-trash").append("删除");

            //为删除按钮添加一个自定义的属性，来表示当前员工id
            del_btn.attr("del_id",item.empId);

            var btnTd = $("<td></td>").append(edit_btn).append(" ").append(del_btn);

            //append执行完成后，返回原来的元素
            $("<tr></tr>")
                .append(checkTd)
                .append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptNameTd)
                .append(btnTd)
                .appendTo("#MyEmpTable tbody")
        });
    }

    //点击删除，发送ajax请求
    $(document).on("click",".del_input",function () {
        var delId = $(this).attr("del_id");
        if (confirm("确认删除吗?")){
            $.ajax({
                url:"${APP_PATH}/del/"+delId,
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
    $("#emp_deleteBatch_btn").click(function () {
        if ($(".checkOne:checked").length == 0){
            alert("请勾选需要删除的员工");
        }else {
            var empNames = "";
            var del_idstr = "";
            $.each($(".checkOne:checked"),function(){
                //员工name字符串
                empNames += $(this).parents("tr").find("td:eq(2)").text()+",";
                //员工id字符串
                del_idstr += $(this).parents("tr").find("td:eq(1)").text()+",";
            });
            //去除末位
            empNames = empNames.substring(0, empNames.length-1);
            del_idstr = del_idstr.substring(0, del_idstr.length-1);

            if(confirm("确认删除【"+empNames+"】吗？")){
                //发送ajax请求删除
                $.ajax({
                    url:"${APP_PATH}/delBatch/"+del_idstr,
                    type:"DELETE",
                    success:function(result){
                        //回到当前页面
                        to_page(current_page);
                        //checkAll的状态变更为false
                        $("#checkAll").prop("checked",false);

                    }
                });
            }
        }
    });

    //搜索员工
    $("#search_emp").click(function () {
        //获取input框输入的值
        var empId = $("#search_input").val();
        //发送ajax请求查询指定姓名的员工
        $.ajax({
            url:"${APP_PATH}/selectById",
            data:"empId="+empId,
            type:"GET",
            success:function (result) {
                //清空表格,分页信息，分页条
                emptyDiv();

                if (result.code == 100){
                    alert("已找到该员工");
                    build_emp_table(result);
                }
                if (result.code == 200){
                    alert("该员工不存在");
                    emptyDiv();
                }
            }
        });
    });

    //清空表格,分页信息，分页条
    function emptyDiv() {
        $("#MyEmpTable tbody").empty();
        $("#page_info_area").empty();
        $("#page_nav_area").empty();
    }

    //解析显示员工数据
    function build_emp_table(result) {
        var emp = result.extend.OneEmp;
        var checkTd = $("<td><input type='checkbox' class='checkOne'></td>");
        var empIdTd = $("<td></td>").append(emp.empId);
        var empNameTd = $("<td></td>").append(emp.empName);
        var genderTd = $("<td></td>").append(emp.gender=='M'?'男':'女');
        var emailTd = $("<td></td>").append(emp.email);
        var deptNameTd = $("<td></td>").append(emp.department.deptName);

        // <button class="btn btn-primary btn-xs">
        //     <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑
        // </button>
        var edit_btn = $("<button></button>").addClass("btn btn-primary btn-xs edit_input")
            .append("<span></span>").addClass("glyphicon glyphicon-pencil").append("编辑");
        //为编辑按钮添加一个自定义的属性，来表示当前员工id
        edit_btn.attr("edit-id",emp.empId);
        var del_btn = $("<button></button>").addClass("btn btn-danger btn-xs del_input")
            .append("<span></span>").addClass("glyphicon glyphicon-trash").append("删除");
        //为删除按钮添加一个自定义的属性，来表示当前员工id
        del_btn.attr("del_id",emp.empId);
        var btnTd = $("<td></td>").append(edit_btn).append(" ").append(del_btn);

        //append执行完成后，返回原来的元素
        $("<tr></tr>")
            .append(checkTd)
            .append(empIdTd)
            .append(empNameTd)
            .append(genderTd)
            .append(emailTd)
            .append(deptNameTd)
            .append(btnTd)
            .appendTo("#MyEmpTable tbody");
    }
</script>

</body>
</html>

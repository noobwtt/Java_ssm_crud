<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>员工页面</title>
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
<!-- 员工新增模态框 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">新增员工</h4>
            </div>
            <div class="modal-body">

                <%--模态框中的内容--%>
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
                            <%--校验需要↓--%>
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@123.com">
                            <%--校验需要↓--%>
                            <span class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">

                            <label class="radio-inline">
                                <%--checked="checked"默认是男--%>
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>

                        </div>
                    </div>

                    <%--deptName,下拉列表--%>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <%--部门提交部门id即可--%>
                            <select class="form-control" name="dId">
                            </select>
                        </div>
                    </div>
                </form>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>

<!-- 员工编辑模态框 -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update_input" placeholder="email@atguigu.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <!-- 部门提交部门id即可 -->
                            <select class="form-control" name="dId">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>

    <%--页面布局--%>
    <div class="container">
            <%--页面第一行：标题--%>
        <div class="row">
            <div class="col-md-4 col-md-offset-4">
                <h1>员工管理</h1>
            </div>
        </div>
            <%--页面第二行：俩按钮和搜索框--%>
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
                    <input type="text" class="form-control"  placeholder="员工id" id="search_input">
                    <span class="input-group-btn">
                        <button class="btn btn-default" type="button" id="search_emp">搜索</button>
                    </span>
                </div>
            </div>
        </div>
            <%--页面第三行：表格数据--%>
        <div class="row">
            <table class="table table-hover" id="MyEmpTable">
                <thead>
                    <tr>
                        <th><input type="checkbox" id="checkAll"></th>
                        <th>empid</th>
                        <th>empname</th>
                        <th>gender</th>
                        <th>email</th>
                        <th>deptname</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                    <%--表格内容--%>
                </tbody>
            </table>
        </div>
            <%--页面第四行，分页信息和分页条--%>
        <div class="row">
            <%--分页信息--%>
            <div class="col-md-6" id="page_info_area"></div>
            <%--分页条--%>
            <div class="col-md-6" id="page_nav_area"></div>
        </div>
    </div>

    <script type="text/javascript">
        var current_page;

        //1.页面加载完成后，要到分页数据
        $(function () {
            to_page(1);
        });

        function to_page(pn){
            $.ajax({
                url:"${APP_PATH}/emps",
                data:"pn="+pn,
                type:"GET",
                success:function (result) {
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

                <%--<button class="btn btn-primary btn-xs">--%>
                <%--    <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑--%>
                <%--</button>--%>
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
        //2.解析显示分页信息
        function build_page_info(result) {
            var pageinfo = result.extend.MyPageInfo;
            $("#page_info_area").empty();
            $("#page_info_area").append("当前是第"+pageinfo.pageNum+"页,总共"+pageinfo.pages+"页，共有"+pageinfo.total+"条数据");
            current_page = pageinfo.pageNum;
        }

        //3.解析显示分页条
        function build_page_name(result) {
            $("#page_nav_area").empty();

            var ul =$("<ul></ul>").addClass("pagination");

            //a.构建元素
            var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
            var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
            //如果没有前一页，disable
            if (result.extend.MyPageInfo.hasPreviousPage == false){
                firstPageLi.addClass("disabled");
                prePageLi.addClass("disabled");
            }else {
                //b.为元素添加点击翻页的事件
                firstPageLi.click(function () {
                    to_page(1);
                });
                prePageLi.click(function () {
                    to_page(result.extend.MyPageInfo.pageNum-1);
                });
            }

            var nexPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
            var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
            //如果没有后一页，disable
            if (result.extend.MyPageInfo.hasNextPage == false){
                nexPageLi.addClass("disabled");
                lastPageLi.addClass("disabled");
            }else {
                nexPageLi.click(function () {
                    to_page(result.extend.MyPageInfo.pageNum+1);
                });
                lastPageLi.click(function () {
                    to_page(result.extend.MyPageInfo.pages);
                });
            }

            //添加首页，上页
            ul.append(firstPageLi).append(prePageLi);
            //遍历给ul中添加页码提示
            $.each(result.extend.MyPageInfo.navigatepageNums,function (index,item) {

                var numLi = $("<li></li>").append($("<a></a>").append(item));
                //如果当前页=正在遍历的页，active
                if (result.extend.MyPageInfo.pageNum==item){
                    numLi.addClass("active");
                }
                //li点击以后，再发ajax请求，去指定页码
                numLi.click(function (){
                    to_page(item);
                });
                ul.append(numLi);
            });
            //添加下页，末页
            ul.append(nexPageLi).append(lastPageLi);
            //把ul加入到nav
            var navEle = $("<nav></nav>").append(ul);
            navEle.appendTo("#page_nav_area");
        }

        /*------------------------------------------------------------------------------------------------------------*/
        /*点击新增，弹出模态框*/
        $("#emp_add_btn").click(function () {
            //初始化form
            init_form();
            //弹出前，发送ajax请求，查出部门信息,显示在下拉列表中
            getDepts("#empAddModal select");
            /*弹出模态框*/
            $("#empAddModal").modal({
                //backdrop设置为static后，点击背景，模态框不会消失
                backdrop:"static"
            });
        });

        //初始化form
        function init_form(){
            //初始化数据
            $("#empAddModal form")[0].reset();
            //初始化样式
            $("#empAddModal form").find("*").removeClass("has-success has-error");
            //初始化提示信息的内容
            $("#empAddModal form").find(".help-block").text("");
        }

        //查出部门信息
        function getDepts(ele){
            $(ele).empty();
            $.ajax({
                url: "${APP_PATH}/depts",
                type: "get",
                success:function (result) {
                    $.each(result.extend.MyDepts,function(){
                        var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
                        optionEle.appendTo(ele);
                    });
                }
            });
        }

        //新增模态框上的保存按钮，绑定事件
        $("#emp_save_btn").click(function () {
            //发ajax请求前，先进行校验
            if (!validate_form()){
                return false;
            }
            //邮箱唯一性校验失败的场合
            if ($("#emp_save_btn").attr("email_ajax_va") == "false"){
                return false;
            }
            //点击保存后，发送ajax请求，保存员工
            $.ajax({
                url:"${APP_PATH}/saveEmp",
                type:"post",
                data: $("#empAddModal form").serialize(),
                success:function (result) {
                    if (result.code == 100){
                        //关闭模态框
                        $("#empAddModal").modal('hide');
                        //去最新页
                        to_page(99999);
                    }else {
                        //显示JSR303校验的错误信息,哪个字段有就显示哪个
                        if (result.extend.JSR303_result.empName != undefined){
                            validate_msg("0","#empName_add_input",result.extend.JSR303_result.empName);
                        }
                        if (result.extend.JSR303_result.email != undefined){
                            validate_msg("0","#empName_add_input",result.extend.JSR303_result.email);
                        }
                    }
                }
            });
        });

        //校验新增模态框的员工名和邮箱
        function validate_form() {
            //失败
            var validate0 = "0";
            //成功
            var validate1 = "1";
            //员工名校验失败msg
            var validate0_empName_msg = "员工为2~5位中文，或3~20位英文";
            //邮箱校验失败msg
            var validate0_email_msg = "邮箱格式有误";
            //校验成功msg
            var validate1_msg = "";
            //empName_add_input
            var empNameObj = "#empName_add_input";
            //email_add_input
            var emailObj = "#email_add_input"

            //员工名
            var empName = $("#empName_add_input").val();
            //员工名的正则
            var reg_empName = /^([\u4e00-\u9fa5]{2,5}|[a-zA-Z\s]{3,20})$/;

            if (!reg_empName.test(empName)){
                validate_msg(validate0,empNameObj,validate0_empName_msg);
                return false;
            } else {
                validate_msg(validate1,empNameObj,validate1_msg);
            }

            //邮箱
            var email = $("#email_add_input").val();
            //邮箱的正则
            var reg_eamil = /^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/;

            if (!reg_eamil.test(email)){
                validate_msg(validate0,emailObj,validate0_email_msg);
                return false;
            }else {
                validate_msg(validate1,emailObj,validate1_msg);
            }
            return true;
        }

        //校验信息显示
        function validate_msg(validateStatus,obj,msg) {
            //初始化input框的校验信息显示
            $(obj).parent().removeClass("has-error has-success");

            //validateStatus：1成功，0失败
            if (validateStatus == "1"){
                $(obj).parent().addClass("has-success");
                $(obj).next("span").text(msg);
            }
            if (validateStatus == "0"){
                $(obj).parent().addClass("has-error");
                $(obj).next("span").text(msg);
            }
        }

        //新增模态框的emailinput内容改变时，进行校验
        $("#email_add_input").change(function () {
            //发ajax请求验证邮箱
            var email = this.value;
            $.ajax({
                url:"${APP_PATH}/checkEmail",
                data:"email="+email,
                type:"post",
                success:function (result) {
                    if (result.code == 100){
                        validate_msg("1","#email_add_input","该邮箱可用");
                        $("#emp_save_btn").attr("email_ajax_va",true);
                    }
                    if (result.code == 200){
                        validate_msg("0","#email_add_input",result.extend.va_email_msg);
                        $("#emp_save_btn").attr("email_ajax_va",false);
                    }
                }
            });
        });

        //新增模态框的empName input内容改变时，进行校验
        $("#empName_add_input").change(function () {
            //发ajax请求验证员工名
            var empName = this.value;
            $.ajax({
                url:"${APP_PATH}/checkEmpName",
                data:"empName="+empName,
                type:"post",
                success:function (result) {
                    console.log(result);
                    if (result.code == 100){
                        validate_msg("1","#empName_add_input","该员工名可用");
                        $("#emp_save_btn").attr("email_ajax_va",true);
                    }
                    if (result.code == 200){
                        validate_msg("0","#empName_add_input","员工为2~5位中文，或3~20位英文");
                        $("#emp_save_btn").attr("email_ajax_va",false);
                    }
                }
            });
        });

        /*------------------------------------------------------------------------------------------------------------*/
        //点击编辑，弹出模态框
        $(document).on("click",".edit_input",function () {
            //1.发送ajax请求，查出部门信息,显示在下拉列表中
            getDepts("#empUpdateModal select");
            //2.发送ajax请求，根据id查询员工信息，把员工姓名显示在模态框中
            getEmp($(this).attr("edit-id"));

            $("#emp_update_btn").attr("update-id",$(this).attr("edit-id"));

            $("#empUpdateModal").modal({
                //点击背景，框不会关闭
                backdrop:"static"
            });
        });

        //根据id查询员工信息，把员工姓名显示在模态框中
        function getEmp(id) {
            $.ajax({
                url:"${APP_PATH}/emp/"+id,
                type: "get",
                success:function (result) {
                    // console.log(result);
                    var empData = result.extend.EMP;
                    $("#empName_update_static").text(empData.empName);
                    $("#email_update_input").val(empData.email);
                    $("#empUpdateModal input[name=gender]").val([empData.gender]);
                    $("#empUpdateModal select").val([empData.dId]);
                }
            });
        }

        //点击编辑模态框的保存按钮，发送ajax请求，保存员工数据
        $("#emp_update_btn").click(function () {
            //发送ajax请求
            $.ajax({
                url:"${APP_PATH}/update/"+$(this).attr("update-id"),
                type:"put",
                data:$("#empUpdateModal form").serialize(),
                success:function (result) {
                    //关闭模态框
                    $("#empUpdateModal").modal("hide");
                    //回到当前页
                    to_page(current_page);
                }
            });
        });
        /*------------------------------------------------------------------------------------------------------------*/
        //点击删除，发送ajax请求
        //delId名字要和controller方法中的一样
        $(document).on("click",".del_input",function () {
            var delId = $(this).attr("del_id");

            if (confirm("确认删除吗?")){
                $.ajax({
                    url:"${APP_PATH}/del/"+delId,
                    type:"delete",
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
                alert("请选择需要删除的员工");
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
                type:"get",
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

            <%--<button class="btn btn-primary btn-xs">--%>
            <%--    <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑--%>
            <%--</button>--%>
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

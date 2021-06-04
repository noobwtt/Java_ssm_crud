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


    <div class="container">
            <%--页面第一行：标题--%>
        <div class="row">
            <div class="col-md-12"><h1>SSM-CRUD</h1></div>
        </div>
            <%--页面第二行：按钮--%>
        <div class="row">
            <div class="col-md-2">
                <button class="btn btn-success" id="emp_add_modal_btn">新增</button>
            </div>
        </div>
            <%--页面第三行：表格数据--%>
        <div class="row">
            <table class="table table-bordered" id="MyEmpTable">
                <thead>
                    <tr>
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
                // alert(item.empName);
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
        $("#emp_add_modal_btn").click(function () {
            //弹出前，发送ajax请求，查出部门信息,显示在下拉列表中
            getDepts("#empAddModal select");
            /*弹出模态框*/
            $("#empAddModal").modal({
                //backdrop设置为static后，点击背景，模态框不会消失
                backdrop:"static"
            });
        });
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
            // alert($("#empAddModal form").serialize());弹出：empName=&email=&gender=M&dId=1
            //点击保存后，发送ajax请求，保存员工
            $.ajax({
                url:"${APP_PATH}/saveEmp",
                type:"post",
                data: $("#empAddModal form").serialize(),
                success:function (result) {
                    $("#empAddModal").modal('hide');
                    to_page(99999);
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
    </script>
</body>
</html>

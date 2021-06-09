<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Employee Add</title>

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

<script type="text/javascript">
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
            type:"POST",
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
            type:"POST",
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
            type:"POST",
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
</script>

</body>
</html>

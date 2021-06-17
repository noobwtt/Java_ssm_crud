<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Employee Update</title>

</head>
<body>
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

<script type="text/javascript">
    //点击编辑，弹出模态框
    $(document).on("click",".edit_input",function () {
        //获取点击修改员工的id
        var updateEmpId = $(this).attr("edit-id");
        //1.发送ajax请求，查出部门信息,显示在下拉列表中
        getDept("#empUpdateModal select");
        //2.发送ajax请求，根据id查询员工信息，把员工姓名显示在模态框中
        getEmp(updateEmpId);

        $("#emp_update_btn").attr("updateEmpId",updateEmpId);

        $("#empUpdateModal").modal({
            //点击背景，框不会关闭
            backdrop:"static"
        });
    });

    //根据id查询员工信息，把员工姓名显示在模态框中
    function getEmp(id) {
        $.ajax({
            url:"${APP_PATH}/emp/"+id,
            type: "GET",
            success:function (result) {
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
        var updateEmpId = $(this).attr("updateEmpId");
        //发送ajax请求
        $.ajax({
            url:"${APP_PATH}/update/"+updateEmpId,
            type:"PUT",
            data:$("#empUpdateModal form").serialize(),
            success:function (result) {
                //关闭模态框
                $("#empUpdateModal").modal("hide");
                //回到当前页
                to_page(current_page);
                //提示msg
                alert("id:"+updateEmpId+"的员工更新成功");
            }
        });
    });
</script>
</body>
</html>

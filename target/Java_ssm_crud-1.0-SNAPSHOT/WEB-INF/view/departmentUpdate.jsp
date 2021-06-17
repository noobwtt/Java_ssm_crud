<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Department Update</title>
</head>
<body>

<!-- 部门编辑模态框 -->
<div class="modal fade" id="deptUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">部门修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">部门名</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="deptName_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">部长名</label>
                        <div class="col-sm-10">
                            <input type="text" name="deptLeader" class="form-control" id="deptLeader_update_input" placeholder="部长名">
                            <span class="help-block"></span>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="dept_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(document).on("click",".edit_input",function () {
        //获取对应部门的id
        var updateDeptId = $(this).attr("edit-id");
        //发送ajax请求，根据id查询部门信息，把部门名显示在模态框中
        getDeptNameById(updateDeptId);

        $("#dept_update_btn").attr("updateDeptId",updateDeptId);

        $("#deptUpdateModal").modal({
            //点击背景，框不会关闭
            backdrop:"static"
        });
    });

    //根据id查询部门信息，把部门名显示在模态框中
    function getDeptNameById(id) {
        $.ajax({
            url:"${APP_PATH}/dept/"+id,
            type: "GET",
            success:function (result) {
                var deptData = result.extend.DEPT;
                $("#deptName_update_static").text(deptData.deptName);
                $("#deptLeader_update_input").val(deptData.deptLeader);
            }
        });
    }

    //点击编辑模态框的更新按钮，发送ajax请求，保存部门数据
    $("#dept_update_btn").click(function () {
        var updateDeptId = $(this).attr("updateDeptId");
        //发送ajax请求
        $.ajax({
            url: "${APP_PATH}/updateDept/"+updateDeptId,
            type: "PUT",
            data: $("#deptUpdateModal form").serialize(),
            success:function (result) {
                //关闭模态框
                $("#deptUpdateModal").modal("hide");
                //回到当前页
                to_page(current_page);
                //提示msg
                alert("id:"+updateDeptId+"的部门更新成功");
            }
        });
    });
</script>

</body>
</html>

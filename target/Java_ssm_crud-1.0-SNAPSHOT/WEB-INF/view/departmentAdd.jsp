<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Department Add</title>
</head>
<body>

<!-- 部门新增模态框 -->
<div class="modal fade dept_add_modal" id="deptAddModal" tabindex="-1" role="dialog" aria-labelledby="dept_add_modal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">新增部门</h4>
            </div>

            <div class="modal-body">
                <%--模态框中的内容--%>
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">部门名</label>
                        <div class="col-sm-10">
                            <input type="text" name="deptName" class="form-control" id="deptName_add_input" placeholder="部门名">
                            <%--校验需要↓--%>
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">部长名</label>
                        <div class="col-sm-10">
                            <input type="text" name="deptLeader" class="form-control" id="deptLeader_add_input" placeholder="部长名">
                            <%--校验需要↓--%>
                            <span class="help-block"></span>
                        </div>
                    </div>
                </form>

            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="dept_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(".dept_add").click(function () {
        //初始化form
        init_form();
        //弹出模态框
        $("#deptAddModal").modal({
            //backdrop设置为static后，点击背景，模态框不会消失
            backdrop:"static"
        });
    });

    //初始化form
    function init_form(){
        //初始化数据
        $("#deptAddModal form")[0].reset();
        //初始化样式
        $("#deptAddModal form").find("*").removeClass("has-success has-error");
        //初始化提示信息的内容
        $("#deptAddModal form").find(".help-block").text("");
    }

    //新增模态框上的保存按钮，绑定事件
    $("#dept_save_btn").click(function () {
        //点击保存后，发送ajax请求，保存部门信息
        $.ajax({
            url:"${APP_PATH}/saveDept",
            type:"POST",
            data:$("#deptAddModal form").serialize(),
            success:function (result) {
                if (result.code == 100){
                    //关闭模态框
                    $("#deptAddModal").modal('hide');
                    //去最新页
                    to_page(99999);
                }
            }
        });
    });
</script>

</body>
</html>

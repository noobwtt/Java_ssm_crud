//回显部门信息
function getDepts(ele){
    $(ele).empty();
    $.ajax({
        url: "/depts",
        type: "GET",
        success:function (result) {
            $.each(result.extend.MyDepts,function(){
                var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
                optionEle.appendTo(ele);
            });
        }
    });
}
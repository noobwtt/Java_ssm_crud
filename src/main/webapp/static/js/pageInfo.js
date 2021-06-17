//解析显示分页信息
function build_page_info(result) {
    var pageInfo = result.extend.MyPageInfo;
    $("#page_info_area").empty();
    $("#page_info_area").append("当前是第"+pageInfo.pageNum+"页,总共"+pageInfo.pages+"页，共有"+pageInfo.total+"条数据");
    current_page = pageInfo.pageNum;
}

//解析显示分页条
function build_page_name(result) {
    $("#page_nav_area").empty();

    var ul =$("<ul></ul>").addClass("pagination");

    //a.构建元素
    var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
    var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
    //如果没有前一页，disable
    if (!result.extend.MyPageInfo.hasPreviousPage){
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

    var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
    var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
    //如果没有后一页，disable
    if (!result.extend.MyPageInfo.hasNextPage){
        nextPageLi.addClass("disabled");
        lastPageLi.addClass("disabled");
    }else {
        nextPageLi.click(function () {
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
    ul.append(nextPageLi).append(lastPageLi);
    //把ul加入到nav
    var navEle = $("<nav></nav>").append(ul);
    navEle.appendTo("#page_nav_area");
}
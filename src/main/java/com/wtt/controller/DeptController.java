package com.wtt.controller;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.wtt.bean.Department;
import com.wtt.bean.Msg;
import com.wtt.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class DeptController {

    @Autowired
    private DepartmentService departmentService;


    @RequestMapping(value = "/depts",method = RequestMethod.GET)
    @ResponseBody
    public Msg getDeptsWithJson(){
        List<Department> departmentList = departmentService.getDeptsWithJson();
        return Msg.success().add("MyDepts",departmentList);
    }

    /**
     * 跳转到departmentPage页面
     * @return
     */
    @RequestMapping("/departmentPage")
    public String deptPage(){
        return "departmentPage";
    }

    @ResponseBody
    @RequestMapping(value = "/allDepts")
    public Msg getAllDepts(@RequestParam(value = "pn",defaultValue = "1") Integer pn){
        //设置分页信息
        PageHelper.startPage(pn, 8);
        //查询所有部门
        List<Department> departmentList = departmentService.getAllDepts();
        //将查询结果封装到pageinfo中
        PageInfo pageInfo = new PageInfo(departmentList, 5);
        //将pageinfo交给页面
        return Msg.success().add("MyPageInfo",pageInfo);
    }
}

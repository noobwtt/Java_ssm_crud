package com.wtt.controller;

import com.wtt.bean.Department;
import com.wtt.bean.Msg;
import com.wtt.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class DeptController {

    @Autowired
    private DepartmentService departmentService;


    @RequestMapping("/depts")
    @ResponseBody
    public Msg getDeptsWithJson(){
        List<Department> departmentList = departmentService.getDeptsWithJson();
        return Msg.success().add("MyDepts",departmentList);
    }
}

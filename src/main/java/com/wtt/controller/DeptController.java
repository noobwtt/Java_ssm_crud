package com.wtt.controller;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.wtt.bean.Department;
import com.wtt.bean.Msg;
import com.wtt.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class DeptController {

    @Autowired
    private DepartmentService departmentService;


    @RequestMapping(value = "/getDept",method = RequestMethod.GET)
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

    /**
     * 查询所有部门
     * @param pn
     * @return
     */
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

    /**
     * 保存部门信息
     * @param department
     * @return
     */
    @ResponseBody
    @RequestMapping("/saveDept")
    public Msg saveDeptWithJson(Department department){
        departmentService.saveDeptWithJson(department);
        return Msg.success();
    }

    /**
     * 根据id查询部门信息
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/dept/{id}")
    public Msg getDeptNameById(@PathVariable("id") Integer id){
        Department department = departmentService.getDeptNameById(id);
        return Msg.success().add("DEPT",department);
    }

    /**
     * 根据id更新部门信息
     * @param department
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/updateDept/{deptId}",method = RequestMethod.PUT)
    public Msg updateDeptById(Department department){
        departmentService.updateDeptById(department);
        return Msg.success();
    }

    /**
     * 根据id删除部门
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/delDept/{delId}",method = RequestMethod.DELETE)
    public Msg delDeptById(@PathVariable("delId") Integer id){
        departmentService.delDeptById(id);
        return Msg.success();
    }

    /**
     * 批量删除和单条删除
     * @param del_idstr
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/delDeptBatch/{del_idstr}",method = RequestMethod.DELETE)
    public Msg delDeptBatch(@PathVariable("del_idstr") String del_idstr){
        if (del_idstr.contains(",")){
            //批量删除
            String[] ids = del_idstr.split(",");
            for (String id : ids) {
                departmentService.delDeptById(Integer.parseInt(id));
            }
        }else {
            //单条删除
            departmentService.delDeptById(Integer.parseInt(del_idstr));
        }
        return Msg.success();
    }
}

package com.wtt.controller;


import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.wtt.bean.Employee;
import com.wtt.bean.Msg;
import com.wtt.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class EmpController {

    @Autowired
    private EmployeeService employeeService;

    /**
     * 以json字符串形式返回给游览器
     * 查询所有员工
     * @param pn
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emps")
    //@RequestParam 将请求参数绑定到你控制器的方法参数上
    public Msg getEmpsWithJson(@RequestParam(value = "pn",defaultValue = "1") Integer pn){
        //设置分页信息
        PageHelper.startPage(pn,8);
        //查询所有员工通过service层
        List<Employee> employeeList = employeeService.getEmps();
        //将查询结果封装到pageinfo中
        PageInfo pageInfo = new PageInfo(employeeList,5);
        //将pageinfo交给页面
        return Msg.success().add("MyPageInfo",pageInfo);
    }

    /**
     * 保存员工
     * @param employee
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/saveEmp",method = RequestMethod.POST)
    public Msg saveEmpWithJson(Employee employee){
        employeeService.saveEmpWithJson(employee);
        return Msg.success();
    }

    /**
     * 根据指定员工id查询员工
     * @param id
     * @return
     */
    @RequestMapping("/emp/{id}")
    @ResponseBody
    public Msg getEmpById(@PathVariable("id") Integer id){
        Employee employee = employeeService.getEmpById(id);
        return Msg.success().add("EMP",employee);
    }

    /**
     * 根据指定id更新员工
     * @param employee
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/update/{empId}",method = RequestMethod.PUT)
    public Msg updateEmpById(Employee employee){
        employeeService.updateEmpById(employee);
        return Msg.success();
    }

//    /**
//     * 根据id删除员工
//     * @param delId
//     * @return
//     */
//    @RequestMapping(value = "/del/{delId}",method = RequestMethod.DELETE)
//    @ResponseBody
//    public Msg deleteEmpById(@PathVariable("delId") Integer id){
//        employeeService.deleteEmpById(id);
//        return Msg.success();
//    }


    /**
     * 批量和单条删除
     * @param del_idstr
     * @return
     */
    @RequestMapping(value = "/delBatch/{del_idstr}",method = RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteEmpById(@PathVariable("del_idstr") String del_idstr){
        if (del_idstr.contains(",")){
            //批量删除
            String[] ids = del_idstr.split(",");
            for (String id : ids) {
                employeeService.deleteEmpById(Integer.parseInt(id));
            }
        }else {
            //单条删除
            employeeService.deleteEmpById(Integer.parseInt(del_idstr));
        }
        return Msg.success();
    }

}

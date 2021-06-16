package com.wtt.controller;


import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.wtt.bean.Employee;
import com.wtt.bean.Msg;
import com.wtt.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.validation.Valid;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class EmpController {

    @Autowired
    private EmployeeService employeeService;

    /**
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
        //查询所有员工
        List<Employee> employeeList = employeeService.getEmps();
        //将查询结果封装到pageinfo中
        PageInfo pageInfo = new PageInfo(employeeList,5);
        //将pageinfo交给页面
        return Msg.success().add("MyPageInfo",pageInfo);
    }

    /**
     * 跳转到employeePage页面
     * @return
     */
    @RequestMapping("/employeePage")
    public String empPage(){
        return "employeePage";
    }

    /**
     * 通过id查询员工
     * @param empId
     * @return
     */
    @ResponseBody
    @RequestMapping("/selectById")
    public Msg selectById(@RequestParam("empId") Integer empId){
        Employee employee = employeeService.selectById(empId);
        if (employee != null){
            return Msg.success().add("OneEmp",employee);
        }else {
            return Msg.fail();
        }
    }

    /**
     * 保存员工
     * Valid注解进行JSR303校验，BindingResult接收校验结果
     * @param employee
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/saveEmp",method = RequestMethod.POST)
    public Msg saveEmpWithJson(@Valid Employee employee,BindingResult result){
        if (result.hasErrors()){
            Map<String,String> resultMap = new HashMap<>();
            List<FieldError> fieldErrors = result.getFieldErrors();
            for (FieldError fieldError : fieldErrors) {
                resultMap.put(fieldError.getField(),fieldError.getDefaultMessage());
            }
            return Msg.fail().add("JSR303_result",resultMap);
        }else {
            employeeService.saveEmpWithJson(employee);
            return Msg.success();
        }
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

    /**
     * 根据id删除员工
     * @param id
     * @return
     */
    @RequestMapping(value = "/del/{delId}",method = RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteEmpById(@PathVariable("delId") Integer id){
        employeeService.deleteEmpById(id);
        return Msg.success();
    }


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

    /**
     * 校验邮箱
     * @param email
     * @return
     */
    @ResponseBody
    @RequestMapping("/checkEmail")
    public Msg checkEmail(@RequestParam("email") String email){
        //校验邮箱是否合法
        String regEmail = "^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$";
        if (!email.matches(regEmail)){
            return Msg.fail().add("va_email_msg","邮箱格式有误");
        }

        //数据库中校验email是否唯一
        boolean b = employeeService.checkEmail(email);
        if (b){
            return Msg.success();
        }else{
            return Msg.fail().add("va_email_msg","邮箱已被使用");
        }
    }

    /**
     * 校验员工名是否合法
     * @param empName
     * @return
     */
    @ResponseBody
    @RequestMapping("/checkEmpName")
    public Msg checkEmpName(@RequestParam("empName")String empName){
        //员工名正则
        String regEmpName = "^([\\u4e00-\\u9fa5]{2,5}|[a-zA-Z\\s]{3,20})$";
        if (!empName.matches(regEmpName)){
            return Msg.fail();
        }else {
            return Msg.success();
        }
    }

}

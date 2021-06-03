package com.wtt.service.impl;

import com.wtt.bean.Employee;
import com.wtt.dao.EmployeeMapper;
import com.wtt.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeServiceImpl implements EmployeeService {

    @Autowired
    private EmployeeMapper employeeMapper;

    @Override
    //查询所有员工
    public List<Employee> getEmps() {
        List<Employee> employeeList = employeeMapper.selectByExampleWithDept(null);
        return employeeList;
    }

    @Override
    //保存员工
    public void saveEmpWithJson(Employee employee) {
        employeeMapper.insertSelective(employee);
    }

    @Override
    //查询员工by id
    public Employee getEmpById(Integer id) {
        Employee employee = employeeMapper.selectByPrimaryKeyWithDept(id);
        return employee;
    }

    @Override
    //更新员工，通过id
    public void updateEmpById(Employee employee) {
        employeeMapper.updateByPrimaryKeySelective(employee);
    }

    @Override
    //删除员工，通过id
    public void deleteEmpById(Integer id) {
        employeeMapper.deleteByPrimaryKey(id);
    }


}

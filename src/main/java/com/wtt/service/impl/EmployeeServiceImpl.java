package com.wtt.service.impl;

import com.wtt.bean.Employee;
import com.wtt.bean.EmployeeExample;
import com.wtt.dao.EmployeeMapper;
import com.wtt.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeServiceImpl implements EmployeeService {

    @Autowired
    private EmployeeMapper employeeMapper;

    /**
     * 查询所有员工
     * @return employeeList查到的所有表中的员工list
     */
    @Override
    public List<Employee> getEmps() {
        List<Employee> employeeList = employeeMapper.selectByExampleWithDept(null);
        return employeeList;
    }

    /**
     * 保存员工
     * @param employee
     */
    @Override
    public void saveEmpWithJson(Employee employee) {
        employeeMapper.insertSelective(employee);
    }

    /**
     * 查询员工by id
     * @param id
     * @return employee查询到的指定id的员工
     */
    @Override
    public Employee getEmpById(Integer id) {
        Employee employee = employeeMapper.selectByPrimaryKeyWithDept(id);
        return employee;
    }

    /**
     * 更新员工，通过id
     * @param employee
     */
    @Override
    public void updateEmpById(Employee employee) {
        employeeMapper.updateByPrimaryKeySelective(employee);
    }

    /**
     * 删除员工，通过id
     * @param id
     */
    @Override
    public void deleteEmpById(Integer id) {
        employeeMapper.deleteByPrimaryKey(id);
    }

    /**
     * 检验邮箱在表中是否唯一
     * @param email
     * @return true：表中不存在这个邮箱   fasle：表中已经存在这个邮箱
     */
    @Override
    public boolean checkEmail(String email) {
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmailEqualTo(email);
        return employeeMapper.countByExample(example) == 0;
    }

    /**
     * 通过id查询员工
     * @param empId
     * @return
     */
    @Override
    public Employee selectById(Integer empId) {
        Employee employee = employeeMapper.selectByPrimaryKeyWithDept(empId);
        return employee;
    }


}

package com.wtt.service.impl;

import com.wtt.bean.Department;
import com.wtt.dao.DepartmentMapper;
import com.wtt.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DepartmentServiceImpl implements DepartmentService {

    @Autowired
    private DepartmentMapper departmentMapper;

    @Override
    public List<Department> getDeptsWithJson() {
        List<Department> departmentList = departmentMapper.selectByExample(null);
        return departmentList;
    }

    @Override
    public List<Department> getAllDepts() {
        List<Department> departmentList = departmentMapper.selectByExample(null);
        return departmentList;
    }

    @Override
    public void saveDeptWithJson(Department department) {
        departmentMapper.insertSelective(department);
    }

    @Override
    public Department getDeptNameById(Integer id) {
        Department department = departmentMapper.selectByPrimaryKey(id);
        return department;
    }

    @Override
    public void updateDeptById(Department department) {
        departmentMapper.updateByPrimaryKeySelective(department);
    }

    @Override
    public void delDeptById(Integer id) {
        departmentMapper.deleteByPrimaryKey(id);
    }
}

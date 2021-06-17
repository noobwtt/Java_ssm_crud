package com.wtt.service;

import com.wtt.bean.Department;

import java.util.List;

public interface DepartmentService {
    List<Department> getDeptsWithJson();

    List<Department> getAllDepts();

    void saveDeptWithJson(Department department);

    Department getDeptNameById(Integer id);

    void updateDeptById(Department department);

    void delDeptById(Integer id);
}

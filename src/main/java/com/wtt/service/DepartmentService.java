package com.wtt.service;

import com.wtt.bean.Department;

import java.util.List;

public interface DepartmentService {
    List<Department> getDeptsWithJson();

    List<Department> getAllDepts();

}

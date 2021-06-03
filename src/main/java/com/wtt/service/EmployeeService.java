package com.wtt.service;

import com.wtt.bean.Employee;

import java.util.List;

public interface EmployeeService {
    List<Employee> getEmps();

    void saveEmpWithJson(Employee employee);

    Employee getEmpById(Integer id);

    void updateEmpById(Employee employee);

    void deleteEmpById(Integer id);
}

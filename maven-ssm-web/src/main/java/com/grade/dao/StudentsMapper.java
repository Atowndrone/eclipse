package com.grade.dao;

import java.util.List;

import com.grade.entity.Students;

public interface StudentsMapper {
    int deleteByPrimaryKey(Integer xh);

    int insert(Students record);

    int insertSelective(Students record);

    Students selectByPrimaryKey(Integer xh);

    int updateByPrimaryKeySelective(Students record);

    int updateByPrimaryKey(Students record);
    
    List<Students> getAllStudents();
    
    public int delMoreStudentArray(int []ids);
    
    public int delMoreStudentList(List<Object> arry);
}
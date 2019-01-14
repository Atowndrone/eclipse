package com.grade.service;

import java.util.List;

import com.grade.entity.Students;

public interface StudentsService {
	//查询所有学生信息
	 List<Students> getAllStudents();
	 //删除单条学生信息
	 int deleteByPrimaryKey(Integer xh);
	 //选择添加
	 int insertSelective(Students record);
	 //更新学生信息
	 int updateByPrimaryKeySelective(Students record);
	 //查询单条学生信息
	 Students selectByPrimaryKey(Integer xh);
	 
	 public void delTransaction();
	 //删除多条信息数组方式
	 public int delMoreStudentArray(int []ids);
	 //删除多条信息集合方式   
	 public int delMoreStudentList(List<Object> arry);
}

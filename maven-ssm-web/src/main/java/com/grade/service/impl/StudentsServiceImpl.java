package com.grade.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.grade.dao.GradeMapper;
import com.grade.dao.StudentsMapper;
import com.grade.entity.Students;
import com.grade.service.StudentsService;

@Service//bean的默认id为类名首字母小写，实现service接口，给controller层调用,反注入到容器
@Transactional
public class StudentsServiceImpl implements StudentsService {
	//自动装配dao实现
	@Autowired
	private StudentsMapper studentsMapper; 
	//查询所有学生
	@Override
	public List<Students> getAllStudents() {
		
		return studentsMapper.getAllStudents();
	}
	//删除单条学生信息
	@Override
	public int deleteByPrimaryKey(Integer xh) {
		int temp = -1;
		temp = studentsMapper.deleteByPrimaryKey(xh);
		return temp;
	}
	//选择添加
	@Override
	public int insertSelective(Students record) {
		int temp = -1;
		temp = studentsMapper.insertSelective(record);
		return temp;
	}
	//更新学生信息
	@Override
	public int updateByPrimaryKeySelective(Students record) {
		int temp = -1;
		temp = studentsMapper.updateByPrimaryKeySelective(record);
		return temp;
	}
	//查询单条学生信息
	@Override
	public Students selectByPrimaryKey(Integer xh) {
		Students students = studentsMapper.selectByPrimaryKey(xh);
		return students;
	}
	
	public void delTransaction() {
		deleteByPrimaryKey(2015111408);
		/*int i=10,j=0;
		i = i/j;*/
		deleteByPrimaryKey(2015111409);
	}
	
	//数组删除多个学生
	@Override
	public int delMoreStudentArray(int[] ids) {
		int temp = -1;
		temp = studentsMapper.delMoreStudentArray(ids);
		return temp;
	}
	//集合方式删除多个学生
	@Override
	public int delMoreStudentList(List<Object> arry) {
		int temp = -1;
		temp = studentsMapper.delMoreStudentList(arry);
		return temp;
	}

}

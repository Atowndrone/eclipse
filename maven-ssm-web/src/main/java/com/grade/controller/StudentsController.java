package com.grade.controller;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.google.gson.Gson;
import com.grade.entity.Students;
import com.grade.service.StudentsService;

import net.sf.jsqlparser.statement.create.table.Index;
//123
@Controller
@RequestMapping("/")
public class StudentsController {
	//设置编码格式
	@InitBinder
    public void initBinder(WebDataBinder binder){
           binder.registerCustomEditor(Date.class,new CustomDateEditor(new SimpleDateFormat("yyyy-MM-dd"),true));
    }
	//自动装配service接口实现
	@Autowired
	private StudentsService studentsService;
	//显示所以学生信息
	@ResponseBody
	@RequestMapping("show1.do")
	public PageInfo<Students> show(Integer pageNum)throws Exception{
		//开启分页支持
		PageHelper.startPage(pageNum==null?1:pageNum,5);
		List<Students> list = studentsService.getAllStudents();
		PageInfo<Students> pageInfo = new PageInfo<>(list);
		return pageInfo;
	}
	
	@RequestMapping("show.do")
	public String Show(Model model ,Integer pageNum) {
		//开启分页支持
		PageHelper.startPage(pageNum==null?1:pageNum,5);
		List<Students> list = studentsService.getAllStudents();
		PageInfo<Students> pageInfo = new PageInfo<>(list);
		/*System.out.println("当前页："+pageInfo.getPageNum());
		System.out.println("页大小："+pageInfo.getPageSize());
		System.out.println("总页数："+pageInfo.getPages());
		System.out.println("总记录数："+pageInfo.getTotal());
		System.out.println("首页："+pageInfo.getNavigateFirstPage());
		System.out.println("上一页："+pageInfo.getPrePage());
		System.out.println("下一页："+pageInfo.getNextPage());
		System.out.println("尾页："+pageInfo.getNavigateLastPage());*/
		model.addAttribute("pageInfo", pageInfo);
		//System.out.println(pageInfo);
		return "students/show";
	}
	
	//删除单条学生信息
	@RequestMapping("del.do")
	public String del(HttpServletRequest request)throws Exception{
		int id = Integer.valueOf(request.getParameter("operate"));
		int temp = -1 ;
		temp = studentsService.deleteByPrimaryKey(id);
		return "redirect:show.do";
	}
	
	//选择添加学生
	@RequestMapping("add.do")
	public String add(Students students)throws Exception{
		int temp = -1;
		temp = studentsService.insertSelective(students);
		return "redirect:show.do";
	}
	
	//修改学生信息
	@RequestMapping("update.do")
	public String update(Students students)throws Exception {
		int temp = -1;
		temp = studentsService.updateByPrimaryKeySelective(students);
		return "redirect:show.do";
	}
	
	//异步修改
		@RequestMapping("asynchronous.do")
		public void asynchronous(HttpServletRequest request,HttpServletResponse response)throws Exception {
			((ServletRequest) response).setCharacterEncoding("utf-8");
			int xh = Integer.valueOf(request.getParameter("operate"));
			Students students = studentsService.selectByPrimaryKey(xh);
			PrintWriter out = response.getWriter();
			Gson gson = new Gson();
			String gsonstr = gson.toJson(students);
			out.println(gsonstr);
		}
	
	//查询单条学生信息
	@RequestMapping("singleFind.do")
	public String singFind(HttpServletRequest request,Model model)throws Exception{
		int id = Integer.valueOf(request.getParameter("operate"));
		Students students = studentsService.selectByPrimaryKey(id);
		model.addAttribute("students", students);
		return "students/update";
	}
	
	//删除多条信息
	@RequestMapping("delMore.do")
	public void delMore(HttpServletRequest request ,HttpServletResponse response)throws Exception {
		int tem = -1;
		String list = request.getParameter("check_ed");
		Gson gson=new Gson();
		@SuppressWarnings("unchecked")
		List<Object> strings=gson.fromJson(list, List.class);
		tem = studentsService.delMoreStudentList((strings));
		PrintWriter out = response.getWriter();
		String gsonstr = new Gson().toJson(tem);
		out.println(gsonstr);
	}
}

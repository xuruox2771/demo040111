package com.cykj.demo.controller;

import com.alibaba.fastjson.JSON;
import com.cykj.demo.entity.Admin;
import com.cykj.demo.entity.User;
import com.cykj.demo.service.AdminService;
import com.cykj.demo.service.UserService;
import com.cykj.demo.utils.LayuiData;
import com.cykj.demo.utils.ResultUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;


//import com.cykj.demo.service.UserService;


@Controller
@RequestMapping("/userControl")
public class UserControl {
	@Autowired  //自动装配,消除代码Java代码里面的getter/setter与bean属性中的property
	private UserService userService;

	@RequestMapping(value = "/login")
	@ResponseBody
	public Object login(HttpServletRequest request, HttpServletResponse response) {
		String username = request.getParameter("username");
		String password = request.getParameter("pwd");
		User user = new User();
		user.setLoginName(username);
		user.setPwd(password);
		user = userService.login(user);
		Map<String ,Object> map = null;
		if (user!=null){
			System.out.println("当前登录用户"+user.getTrueName());
			map = ResultUtil.success();
			request.getSession().setAttribute("user",user);
		}else {
			System.out.println("登录失败");
			map = ResultUtil.fail("登录失败");
		}
		return JSON.toJSONString(map);
	}

	@RequestMapping(value = "/reg")
	@ResponseBody
	public Object reg(HttpServletRequest request, HttpServletResponse response) {
		String loginName = request.getParameter("loginName");
		String pwd = request.getParameter("pwd");
		String trueName = request.getParameter("trueName");
		User user = new User();
		user.setLevelId(2);
		user.setState("启用");
		user.setScore(10);
		user.setTrueName(trueName);
		user.setLoginName(loginName);
		user.setPwd(pwd);
		Map<String, Object> map = new HashMap<String, Object>();
		int num=0;
		try {
			num = userService.regUser(user);
			if (num > 0) {
				System.out.println("当前注册用户信息："+user);
				map = ResultUtil.success();
			} else {
				System.out.println("注册失败");
				map = ResultUtil.fail("注册失败");
			}
		} catch (Exception e) {
			System.out.println("注册失败");
			e.printStackTrace();
			map = ResultUtil.fail("注册失败");
		}
		return JSON.toJSONString(map);
	}


//	@RequestMapping(value = "/userList") //用来处理请求地址映射的注解
//	@ResponseBody
//	public String userList(HttpServletRequest request, HttpServletResponse response) {
//
//		response.setContentType("text/html;charset=utf-8");
//
//		String pageStr = request.getParameter("page");//页码
//		String pageSizeStr = request.getParameter("limit");//每页记录数
//		String trueName = request.getParameter("trueName");
//		String adminName = request.getParameter("adminName");
//		String draw = request.getParameter("draw");//重绘次数 和前台对应
//
//		System.out.println("adminName:" + adminName + " trueName:" + trueName + "start:" + pageStr + " pageSize:" + pageSizeStr);
//		Admin admin = new Admin();
//		admin.setTrueName(trueName);
//		admin.setAdminName(adminName);
//		LayuiData layuiData = userService.selectList(admin, Integer.parseInt(pageStr), Integer.parseInt(pageSizeStr));
//		return JSON.toJSONString(layuiData);
//	}


	@RequestMapping(value = "/delete/{delId}")
	public ModelAndView delete(HttpServletRequest request, HttpServletResponse response, @PathVariable(value = "delId") String delId) {
		System.out.println(delId);
		return null;
	}

	@RequestMapping(value = "/testJson")
	@ResponseBody
	public Object testJson(@RequestBody String jsonStr) {
		System.out.println(jsonStr);
		return jsonStr;
	}

	/**
	 * 添加及保存操作
	 */
	@RequestMapping(value = "/upload")
	@ResponseBody
	public Object saveNews(HttpServletRequest request, HttpServletResponse response, MultipartFile file) {

		try {
			//获取文件名
			String originalName = file.getOriginalFilename();
			//扩展名
			String prefix = originalName.substring(originalName.lastIndexOf(".") + 1);
			Date date = new Date();
			//使用UUID+后缀名保存文件名，防止中文乱码问题
			String uuid = UUID.randomUUID() + "";
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
			String dateStr = simpleDateFormat.format(date);
			String savePath = request.getSession().getServletContext().getRealPath("/upload/");
			String projectPath = savePath + dateStr + File.separator + uuid + "." + prefix;

			System.out.println("projectPath==" + projectPath);
			File files = new File(projectPath);
			//打印查看上传路径
			if (!files.getParentFile().exists()) {//判断目录是否存在
				System.out.println("files11111=" + files.getPath());
				files.getParentFile().mkdirs();
			}
			file.transferTo(files); // 将接收的文件保存到指定文件中
			System.out.println(projectPath);
			LayuiData layuiData = new LayuiData();
			layuiData.setCode(1);
			layuiData.setMsg("上传成功");
			return JSON.toJSONString(layuiData);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

}

package com.cykj.demo.interceptors;

import com.cykj.demo.entity.Admin;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class loginInter implements HandlerInterceptor
{

public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
	throws Exception{
	System.out.println("进入登录拦截器");
	Admin admin = (Admin) request.getSession().getAttribute("admin");
	System.out.println("当前登录信息："+admin);
	if (admin == null) {
		//未登录im
		if (request.getHeader("x-requested-with") != null
				&& request.getHeader("x-requested-with").equalsIgnoreCase("XMLHttpRequest")) {
			//处理ajax请求
			System.out.println("ajax调用");
			response.setHeader("sessionstatus", "timeout");
			response.setStatus(403);
			return false;
		} else {
			//处理controller请求
			String loginStr=request.getContextPath() + "/login.jsp";
			System.out.println("页面请求");
			System.out.println("登录界面:"+loginStr);
			response.sendRedirect(loginStr);
			return false;
		}

	}
//	else
		return true;

}

	public void postHandle(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, java.lang.Object handler, @org.springframework.lang.Nullable org.springframework.web.servlet.ModelAndView modelAndView)
		throws java.lang.Exception { /* compiled code */ }


	public void afterCompletion(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, java.lang.Object handler, @org.springframework.lang.Nullable java.lang.Exception ex)
			throws java.lang.Exception { /* compiled code */ }
}


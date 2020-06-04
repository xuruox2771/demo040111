package com.cykj.demo.controller;


import com.cykj.demo.entity.Admin;
import com.cykj.demo.entity.Menu;
import com.cykj.demo.entity.Role;
import com.cykj.demo.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/menuControl")
public class MenuControl {

    @Autowired
    private MenuService menuService;

    @RequestMapping(value = "/searchMenu")
    public  ModelAndView selectAdminMenu(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try{
            Admin admin = (Admin) request.getSession().getAttribute("admin");
            System.out.println("当前登录的管理员："+admin);
            List<Role> list = menuService.findAllByIdResult(admin.getRoleId());
            List<Integer> menuIdList = new ArrayList<Integer>();
            for (Menu menu : list.get(0).getMenuList()) {
                Integer menuID = menu.getId();
                menuIdList.add(menuID);
            }
            List<Menu> menuList = menuService.findSecondMenu(menuIdList);
            System.out.println("获取菜单："+menuList);
            Map<String, List<Menu>> menuMap = new HashMap<String, List<Menu>>();
            List<Menu> secondMenuList = null;
            for (Menu fristMenu : list.get(0).getMenuList()) {
                secondMenuList = new ArrayList<Menu>();
                if (!menuMap.containsKey(fristMenu.getMenuName())) {
                    for (Menu secondMenu : menuList) {
                        if (fristMenu.getId() == secondMenu.getParentId()) {
                            secondMenuList.add(secondMenu);
                        }
                    }
                    menuMap.put(fristMenu.getMenuName(), secondMenuList);
                }
            }
            request.getSession().setAttribute("list",menuMap);
        } catch (Exception e) {
            e.printStackTrace();
        }
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("menu");
        return modelAndView;

    }

}

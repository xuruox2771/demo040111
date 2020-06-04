package com.cykj.demo.service.imp;

import com.cykj.demo.entity.Menu;
import com.cykj.demo.entity.Role;
import com.cykj.demo.mapper.MenuMapper;
import com.cykj.demo.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("menuService")
public class MenuServiceImpl implements MenuService {
    @Autowired
    public MenuMapper menuMapper;

    public List<Role> findAllByIdResult(Integer roleId) {
        return menuMapper.findAllByIdResult(roleId);
    }

    public List<Menu> findSecondMenu(List<Integer> list) {
        return menuMapper.findSecondMenu(list);
    }
}

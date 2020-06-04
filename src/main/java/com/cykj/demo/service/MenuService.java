package com.cykj.demo.service;

import com.cykj.demo.entity.Menu;
import com.cykj.demo.entity.Role;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface MenuService {
   public List<Role>  findAllByIdResult(@Param("roleId") Integer roleId);
   public List<Menu> findSecondMenu(@Param("upidlist") List<Integer> list);

}

package com.cykj.demo.mapper;

import com.cykj.demo.entity.Menu;
import com.cykj.demo.entity.Role;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface MenuMapper {
     List<Role> findAllByIdResult(@Param("roleId") Integer roleId);
     List<Menu> findSecondMenu(@Param("upidlist") List<Integer> list);
}

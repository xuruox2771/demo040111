package com.cykj.demo.mapper;

import com.cykj.demo.entity.Admin;
import com.cykj.demo.entity.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;


public interface UserMapper {
    public User login(User user);
    public int regUser(User user);
    public List<User> selectList(@Param("e") User user, @Param("start") int start, @Param("pageSize") int pageSize);
    public int selectListCount(@Param("e") User user);
    public int delete(String[] ids);

}

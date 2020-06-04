package com.cykj.demo.service.imp;

import com.cykj.demo.entity.Admin;
import com.cykj.demo.entity.User;
import com.cykj.demo.mapper.UserMapper;
import com.cykj.demo.service.AdminService;
import com.cykj.demo.service.UserService;
import com.cykj.demo.utils.LayuiData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("userService")
public class UserServiceImp implements UserService {
    @Autowired
    public UserMapper userMapper;

    public User login(User user) {
        User loginuser = null;
        loginuser = userMapper.login(user);
        return loginuser;
    }

    public LayuiData selectList(User user, int page, int pageSize) {
        int start = (page - 1) * pageSize;//计算出起始查询位置
        if(start<0){
            start=0;
        }
        List<User> list = userMapper.selectList(user, start, pageSize);
        int count = userMapper.selectListCount(user);

        LayuiData layuiData = new LayuiData();
        if (list.size() > 0) {
            layuiData.setCode(0);
            layuiData.setMsg("");
            layuiData.setCount(count);
            layuiData.setData(list);
            System.out.println(user);
        } else {
            layuiData.setCode(1);
            layuiData.setMsg("查询失败");
        }
        return layuiData;
    }

    public int regUser(User user) {
        return userMapper.regUser(user);
    }
}

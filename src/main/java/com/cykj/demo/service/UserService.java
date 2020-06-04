package com.cykj.demo.service;

import com.cykj.demo.entity.Admin;
import com.cykj.demo.entity.User;
import com.cykj.demo.utils.LayuiData;

public interface UserService {
    public User login(User user);
    public LayuiData selectList(User user, int page, int pageSize);
    public int regUser(User user);
}

package com.study.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.study.dao.UserDao;
import com.study.model.User;
import com.study.model.UserRole;
import com.study.service.UserService;
import com.study.util.MD5Util2;
@Service
public class UserServiceImpl implements UserService{
	
	@Resource
	private UserDao userDao;
	
	@Override
	public User findUserByName(String name) {
		return userDao.findUserByName(name);
	}

	@Override
	public PageInfo<User> selectByPage(User user,int start, int length) {
		int page = start/length+1;
        //分页查询
        PageHelper.startPage(page, length);
        List<User> userlist = userDao.queryAll(user);
        return new PageInfo<>(userlist);
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED,readOnly=false,rollbackFor={Exception.class})
	public void saveUserRoles(UserRole userRole) {
		userDao.delRolesByUserId(userRole.getUserId());
		String[] roleids = userRole.getRoleId().split(",");
		for (String roleId : roleids) {
			UserRole u = new UserRole();
			u.setUserId(userRole.getUserId());
			u.setRoleId(roleId);
			userDao.addUserRole(u);
		}
	}
	
	public void addUser(User user){
		BCryptPasswordEncoder md5=new BCryptPasswordEncoder();
		String encodePassword = md5.encode(user.getPassword());
//		String encodePassword = MD5Util2.string2MD5(user.getPassword());
		user.setPassword(encodePassword);
		userDao.addEntity(user);
	}

	@Override
	public void delUser(Integer id) {
		userDao.deleteEntity(id);
	}

	@Override
	public User queryByName(String username) {
		return userDao.queryByName(username);
	}
	
}

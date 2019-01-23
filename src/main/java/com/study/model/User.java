package com.study.model;

import java.io.Serializable;
import java.util.Set;
/**
 * 用户实体类
 * @author Administrator
 *
 */
public class User implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -1223385920196007622L;
	private Integer id;
	private String username;
	private String password;
	private Integer enable;
	
	private Set<Role> roles;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	public Integer getEnable() {
		return enable;
	}
	public void setEnable(Integer enable) {
		this.enable = enable;
	}
	public Set<Role> getRoles() {
		return roles;
	}
	public void setRoles(Set<Role> roles) {
		this.roles = roles;
	}
	@Override
	public String toString() {
		return "User [id=" + id + ", username=" + username + ", password="
				+ password + ", enable=" + enable + ", roles=" + roles + "]";
	}
	
	
}

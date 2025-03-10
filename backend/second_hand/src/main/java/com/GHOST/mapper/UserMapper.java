package com.GHOST.mapper;

import com.GHOST.pojo.User;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

@Mapper
public interface UserMapper {
    @Select("select * from user where username = #{username}")
    User findByUsername(String username);

    @Insert("insert into user(username, password, email, create_time, update_time)" +
            "values(#{username}, #{password}, #{email}, now(), now())")
    void add(String username, String password, String email);

    @Update("update user set nickname = #{nickname}, email = #{email}, update_time = #{updateTime} where id = #{id}")
    void update(User user);

    @Update("update user set user_pic = #{avatarUrl}, update_time = now() where id = #{id}")
    void updateAvatar(String avatarUrl, Integer id);

    @Update("update user set password = #{md5Password}, update_time = now() where id = #{id}")
    void updatePwd(String md5Password, Integer id);

    @Select("select * from user where id = #{id}")
    User findById(Integer id);
}

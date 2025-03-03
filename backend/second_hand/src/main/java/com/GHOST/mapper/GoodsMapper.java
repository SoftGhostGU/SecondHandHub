package com.GHOST.mapper;

import com.GHOST.pojo.Goods;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface GoodsMapper {
    @Insert("insert into goods(title, content, cover_img, price, state, category_id, create_user, create_time, update_time)" +
            " values(#{title}, #{content}, #{coverImg}, #{price}, #{state}, #{categoryId}, #{createUser}, #{createTime}, #{updateTime})")
    void add(Goods goods);

    List<Goods> list(Integer userId, String categoryId, String state);

    @Select("select * from goods where id = #{id}")
    Goods findById(Integer id);

    @Update("update goods set title = #{title}, content = #{content}, cover_img = #{coverImg}, price = #{price}, state = #{state}, category_id = #{categoryId}, update_time = #{updateTime} where id = #{id}")
    void update(Goods goods);

    @Delete("delete from goods where id = #{id}")
    void delete(Integer id);
}

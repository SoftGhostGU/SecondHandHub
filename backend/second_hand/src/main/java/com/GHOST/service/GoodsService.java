package com.GHOST.service;

import com.GHOST.pojo.Goods;
import com.GHOST.pojo.PageBean;

public interface GoodsService {
    void add(Goods goods);

    PageBean<Goods> list(Integer pageNum, Integer pageSize, String categoryId, String state);

    Goods findById(Integer id);

    void update(Goods goods);

    void delete(Integer id);
}

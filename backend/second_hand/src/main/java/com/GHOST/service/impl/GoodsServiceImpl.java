package com.GHOST.service.impl;

import com.GHOST.mapper.GoodsMapper;
import com.GHOST.pojo.Goods;
import com.GHOST.pojo.PageBean;
import com.GHOST.service.GoodsService;
import com.GHOST.utils.ThreadLocalUtil;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.awt.*;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

@Service
public class GoodsServiceImpl implements GoodsService {

    @Autowired
    private GoodsMapper goodsMapper;

    @Override
    public void add(Goods goods) {
        goods.setCreateTime(LocalDateTime.now());
        goods.setUpdateTime(LocalDateTime.now());
        Map<String, Object> map = ThreadLocalUtil.get();
        Integer userId = (Integer) map.get("id");
        goods.setCreateUser(userId);

        goodsMapper.add(goods);
    }

    @Override
    public PageBean<Goods> list(Integer pageNum, Integer pageSize, String categoryId, String state) {
        PageBean<Goods> pageBean = new PageBean<>();
        // 利用PageHelper插件实现分页
        PageHelper.startPage(pageNum, pageSize);
        // 调用GoodsMapper的list方法查询商品列表
        Map<String, Object> map = ThreadLocalUtil.get();
        Integer userId = (Integer) map.get("id");
        List<Goods> goodsList = goodsMapper.list(userId, categoryId, state);

        // Page中提供了方法，可以获取PageHelper分页查询后得到的总记录条数和当前页数据
        Page<Goods> p = (Page<Goods>) goodsList;
        // 把数据填充的PageBean对象中
        pageBean.setTotal(p.getTotal());
        pageBean.setItems(p.getResult());
        return pageBean;
    }

    @Override
    public PageBean<Goods> listAll(Integer pageNum, Integer pageSize, String categoryId, String state) {
        PageBean<Goods> pageBean = new PageBean<>();
        // 利用PageHelper插件实现分页
        PageHelper.startPage(pageNum, pageSize);
        // 调用GoodsMapper的listAll方法查询所有商品列表
        Map<String, Object> map = ThreadLocalUtil.get();
        List<Goods> goodsList = goodsMapper.listAll(categoryId, state);

        // Page中提供了方法，可以获取PageHelper分页查询后得到的总记录条数和当前页数据
        Page<Goods> p = (Page<Goods>) goodsList;
        // 把数据填充的PageBean对象中
        pageBean.setTotal(p.getTotal());
        pageBean.setItems(p.getResult());
        return pageBean;
    }

    @Override
    public Goods findById(Integer id) {
        Goods g = goodsMapper.findById(id);
        return g;
    }

    @Override
    public void update(Goods goods) {
        goods.setUpdateTime(LocalDateTime.now());
        goodsMapper.update(goods);
    }

    @Override
    public void delete(Integer id) {
        goodsMapper.delete(id);
    }

    @Override
    public void buy(Goods goods) {
        goods.setState("已被购买");
        goods.setUpdateTime(LocalDateTime.now());
        goodsMapper.buy(goods);
    }
}

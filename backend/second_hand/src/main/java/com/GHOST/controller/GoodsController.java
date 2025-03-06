package com.GHOST.controller;

import com.GHOST.pojo.Category;
import com.GHOST.pojo.Goods;
import com.GHOST.pojo.PageBean;
import com.GHOST.pojo.Result;
import com.GHOST.service.GoodsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/goods")
public class GoodsController {

    @Autowired
    private GoodsService goodsService;

    @PostMapping("/add")
    public Result add(@RequestBody @Validated(Category.Add.class) Goods goods) {
        goodsService.add(goods);
        return Result.success();
    }

    @GetMapping("/list")
    public Result<PageBean<Goods>> list(Integer pageNum, Integer pageSize,
                                        @RequestParam(required = false) String categoryId,
                                        @RequestParam(required = false) String state) {
        PageBean<Goods> pageBean = goodsService.list(pageNum, pageSize, categoryId, state);
        return Result.success(pageBean);
    }

    @GetMapping("/get")
    public Result<Goods> get(Integer id) {
        Goods goods = goodsService.findById(id);
        return Result.success(goods);
    }

    @PostMapping("/update")
    public Result update(@RequestBody @Validated(Category.Update.class) Goods goods) {
        goodsService.update(goods);
        return Result.success();
    }

    @DeleteMapping("/delete")
    public Result delete(Integer id) {
        Goods g = goodsService.findById(id);
        if (g == null) {
            return Result.error("商品不存在");
        } else {
            goodsService.delete(id);
            return Result.success();
        }
    }

    @PostMapping("/buy")
    public Result buy(@RequestBody @Validated(Category.Update.class) Goods goods) {
        goodsService.buy(goods);
        return Result.success();
    }
}

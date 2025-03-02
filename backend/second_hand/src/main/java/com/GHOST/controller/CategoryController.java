package com.GHOST.controller;

import com.GHOST.pojo.Category;
import com.GHOST.pojo.Result;
import com.GHOST.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/category")
public class CategoryController {

    @Autowired
    private CategoryService categoryService;

    @PostMapping("/add")
    public Result add(@RequestBody @Validated(Category.Add.class) Category category) {
        categoryService.add(category);
        return Result.success();
    }

    @GetMapping("/list")
    public Result<List<Category>> list() {
        List<Category> categories = categoryService.list();
        return Result.success(categories);
    }

    @GetMapping("/detail")
    public Result<Category> detail(Integer id) {
        Category c = categoryService.findById(id);
        return Result.success(c);
    }

    @PutMapping("/update")
    public Result update(@RequestBody @Validated(Category.Update.class) Category category) {
        categoryService.update(category);
        return Result.success();
    }

    @DeleteMapping("/delete")
    public Result delete(Integer id) {
        Category c = categoryService.findById(id);
        if (c == null) {
            return Result.error("分类不存在");
        } else {
            categoryService.delete(id);
            return Result.success();
        }
    }
}

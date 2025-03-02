package com.GHOST.pojo;

import com.fasterxml.jackson.annotation.JsonFormat;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;

import java.time.LocalDateTime;

public class Category {
    @NotNull(groups = Update.class)
    private int id;                // ID

    @NotEmpty(groups = {Add.class, Update.class})
    private String categoryName;   // 分类名称

    @NotEmpty(groups = {Add.class, Update.class})
    private String categoryDetail; // 细分分类
    private int createUser;        // 创建人ID

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createTime;       // 创建时间

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime updateTime;       // 修改时间

    public interface Add {}
    public interface Update {}

    public Category() {
    }

    public Category(int id, String categoryName, String categoryDetail, int createUser, LocalDateTime createTime, LocalDateTime updateTime) {
        this.id = id;
        this.categoryName = categoryName;
        this.categoryDetail = categoryDetail;
        this.createUser = createUser;
        this.createTime = createTime;
        this.updateTime = updateTime;
    }

    /**
     * 获取
     * @return id
     */
    public int getId() {
        return id;
    }

    /**
     * 设置
     * @param id
     */
    public void setId(int id) {
        this.id = id;
    }

    /**
     * 获取
     * @return categoryName
     */
    public String getCategoryName() {
        return categoryName;
    }

    /**
     * 设置
     * @param categoryName
     */
    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    /**
     * 获取
     * @return categoryDetail
     */
    public String getCategoryDetail() {
        return categoryDetail;
    }

    /**
     * 设置
     * @param categoryDetail
     */
    public void setCategoryDetail(String categoryDetail) {
        this.categoryDetail = categoryDetail;
    }

    /**
     * 获取
     * @return createUser
     */
    public int getCreateUser() {
        return createUser;
    }

    /**
     * 设置
     * @param createUser
     */
    public void setCreateUser(int createUser) {
        this.createUser = createUser;
    }

    /**
     * 获取
     * @return createTime
     */
    public LocalDateTime getCreateTime() {
        return createTime;
    }

    /**
     * 设置
     * @param createTime
     */
    public void setCreateTime(LocalDateTime createTime) {
        this.createTime = createTime;
    }

    /**
     * 获取
     * @return updateTime
     */
    public LocalDateTime getUpdateTime() {
        return updateTime;
    }

    /**
     * 设置
     * @param updateTime
     */
    public void setUpdateTime(LocalDateTime updateTime) {
        this.updateTime = updateTime;
    }

    public String toString() {
        return "category{id = " + id + ", categoryName = " + categoryName + ", categoryDetail = " + categoryDetail + ", createUser = " + createUser + ", createTime = " + createTime + ", updateTime = " + updateTime + "}";
    }
}

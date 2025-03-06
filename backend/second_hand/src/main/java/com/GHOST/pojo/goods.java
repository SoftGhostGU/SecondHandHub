package com.GHOST.pojo;

import com.GHOST.anno.State;
import com.fasterxml.jackson.annotation.JsonFormat;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import org.hibernate.validator.constraints.URL;

import java.time.LocalDateTime;

public class Goods {
    @NotNull(groups = {Update.class})
    private Integer id;                 // ID

    @NotEmpty(groups = {Add.class, Update.class})
    @Pattern(regexp = "^\\S{1,30}$")
    private String title;               // 物品标题

    @NotEmpty(groups = {Add.class, Update.class})
    private String content;             // 细致描述

    @NotEmpty(groups = {Add.class, Update.class})
    @URL
    private String coverImg;            // 物品图片

    @NotNull(groups = {Add.class, Update.class})
    private Integer price;              // 物品价格

    @State(groups = {Add.class, Update.class})
    private String state = "未被购买";    // 文章状态: 只能是[已被购买]或者[未被购买]

    @NotNull(groups = {Add.class, Update.class})
    private Integer categoryId;         // 物品分类ID
    private Integer createUser;         // 创建人ID
    private Integer BuyerUser;          // 购买人ID

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createTime;   // 创建时间

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime updateTime;   // 修改时间

    public Goods(Integer id, String title, String content, String coverImg, Integer price, String state, Integer categoryId, Integer createUser, Integer BuyerUser, LocalDateTime createTime, LocalDateTime updateTime) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.coverImg = coverImg;
        this.price = price;
        this.state = state;
        this.categoryId = categoryId;
        this.createUser = createUser;
        this.BuyerUser = BuyerUser;
        this.createTime = createTime;
        this.updateTime = updateTime;
    }

    /**
     * 获取
     * @return BuyerUser
     */
    public Integer getBuyerUser() {
        return BuyerUser;
    }

    /**
     * 设置
     * @param BuyerUser
     */
    public void setBuyerUser(Integer BuyerUser) {
        this.BuyerUser = BuyerUser;
    }

    public interface Add {}
    public interface Update {}

    public Goods() {
    }

    public Goods(Integer id, String title, String content, String coverImg, String state, Integer categoryId, Integer createUser, LocalDateTime createTime, LocalDateTime updateTime) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.coverImg = coverImg;
        this.state = state;
        this.categoryId = categoryId;
        this.createUser = createUser;
        this.createTime = createTime;
        this.updateTime = updateTime;
    }

    public Goods(Integer id, String title, String content, String coverImg, Integer price, String state, Integer categoryId, Integer createUser, LocalDateTime createTime, LocalDateTime updateTime) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.coverImg = coverImg;
        this.price = price;
        this.state = state;
        this.categoryId = categoryId;
        this.createUser = createUser;
        this.createTime = createTime;
        this.updateTime = updateTime;
    }

    /**
     * 获取
     *
     * @return id
     */
    public Integer getId() {
        return id;
    }

    /**
     * 设置
     *
     * @param id
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * 获取
     *
     * @return title
     */
    public String getTitle() {
        return title;
    }

    /**
     * 设置
     *
     * @param title
     */
    public void setTitle(String title) {
        this.title = title;
    }

    /**
     * 获取
     *
     * @return content
     */
    public String getContent() {
        return content;
    }

    /**
     * 设置
     *
     * @param content
     */
    public void setContent(String content) {
        this.content = content;
    }

    /**
     * 获取
     *
     * @return coverImg
     */
    public String getCoverImg() {
        return coverImg;
    }

    /**
     * 设置
     *
     * @param coverImg
     */
    public void setCoverImg(String coverImg) {
        this.coverImg = coverImg;
    }

    /**
     * 获取
     *
     * @return state
     */
    public String getState() {
        return state;
    }

    /**
     * 设置
     *
     * @param state
     */
    public void setState(String state) {
        this.state = state;
    }

    /**
     * 获取
     *
     * @return categoryId
     */
    public Integer getCategoryId() {
        return categoryId;
    }

    /**
     * 设置
     *
     * @param categoryId
     */
    public void setCategoryId(Integer categoryId) {
        this.categoryId = categoryId;
    }

    /**
     * 获取
     *
     * @return createUser
     */
    public Integer getCreateUser() {
        return createUser;
    }

    /**
     * 设置
     *
     * @param createUser
     */
    public void setCreateUser(Integer createUser) {
        this.createUser = createUser;
    }

    /**
     * 获取
     *
     * @return createTime
     */
    public LocalDateTime getCreateTime() {
        return createTime;
    }

    /**
     * 设置
     *
     * @param createTime
     */
    public void setCreateTime(LocalDateTime createTime) {
        this.createTime = createTime;
    }

    /**
     * 获取
     *
     * @return updateTime
     */
    public LocalDateTime getUpdateTime() {
        return updateTime;
    }

    /**
     * 设置
     *
     * @param updateTime
     */
    public void setUpdateTime(LocalDateTime updateTime) {
        this.updateTime = updateTime;
    }

    public String toString() {
        return "goods{id = " + id + ", title = " + title + ", content = " + content + ", coverImg = " + coverImg + ", state = " + state + ", categoryId = " + categoryId + ", createUser = " + createUser + ", createTime = " + createTime + ", updateTime = " + updateTime + "}";
    }

    /**
     * 获取
     * @return price
     */
    public Integer getPrice() {
        return price;
    }

    /**
     * 设置
     * @param price
     */
    public void setPrice(Integer price) {
        this.price = price;
    }
}

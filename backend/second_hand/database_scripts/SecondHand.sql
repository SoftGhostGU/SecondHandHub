-- 创建数据库
create database second_hand;

-- 使用数据库
use second_hand;

DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS category;
DROP TABLE IF EXISTS goods;

-- 用户表
create table user
(
    id          int unsigned primary key auto_increment comment 'ID',
    username    varchar(20) not null unique comment '用户名',
    password    varchar(32) comment '密码',
    nickname    varchar(10)  default '' comment '昵称',
    email       varchar(128) default '' comment '邮箱',
    user_pic    varchar(128) default '' comment '头像',
    create_time datetime    not null comment '创建时间',
    update_time datetime    not null comment '修改时间'
) comment '用户表';

-- 分类表
create table category
(
    id              int unsigned primary key auto_increment comment 'ID',
    category_name   varchar(32)  not null comment '分类名称',
    category_detail varchar(32)  not null comment '细分分类',
    create_user     int unsigned not null comment '创建人ID',
    create_time     datetime     not null comment '创建时间',
    update_time     datetime     not null comment '修改时间',
    constraint fk_category_user foreign key (create_user) references user (id) -- 外键
);

create table goods
(
    id          int unsigned primary key auto_increment comment 'ID',
    title       varchar(30)    not null comment '物品标题',
    content     varchar(10000) not null comment '细致描述',
    cover_img   varchar(128)   not null comment '物品图片',
    price       int            not null comment '物品价格',
    state       varchar(4) default '未被购买' comment '文章状态: 只能是[已被购买]或者[未被购买]',
    category_id int unsigned comment '物品分类ID',
    create_user int unsigned   not null comment '创建人ID',
    buyer_user  int unsigned   comment '购买者ID',
    create_time datetime       not null comment '创建时间',
    update_time datetime       not null comment '修改时间',
    constraint fk_goods_category foreign key (category_id) references category (id),
    constraint fk_goods_create_user foreign key (create_user) references user (id),
    constraint fk_goods_buyer_user foreign key (buyer_user) references user (id)
);

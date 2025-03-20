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

-- 创建两个用户
INSERT INTO user (username, password, nickname, email, user_pic, create_time, update_time)
VALUES
    ('test-1', MD5('test-1'), 'test_1', '3089308393@qq.com', 'https://s21.ax1x.com/2025/03/02/pEGVjw4.jpg', NOW(), NOW()),
    ('test-2', MD5('test-2'), 'test_2', '3089308393@qq.com', 'https://s21.ax1x.com/2025/03/20/pEwqt4P.jpg', NOW(), NOW());


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

INSERT INTO category (id, category_name, category_detail, create_user, create_time, update_time)
VALUES (1, '服装', '衣服', 1, '2025-03-09 23:26:04', '2025-03-09 23:26:04'),
       (2, '服装', '裤子', 1, '2025-03-09 23:26:08', '2025-03-09 23:26:08'),
       (3, '服装', '鞋子', 1, '2025-03-09 23:26:13', '2025-03-09 23:26:13'),
       (4, '数码', '手机', 1, '2025-03-09 23:29:00', '2025-03-09 23:29:00'),
       (5, '数码', '相机', 1, '2025-03-09 23:29:10', '2025-03-09 23:29:10'),
       (6, '数码', '耳机', 1, '2025-03-09 23:29:20', '2025-03-09 23:29:20'),
       (7, '数码', '笔记本电脑', 1, '2025-03-09 23:29:30', '2025-03-09 23:29:30'),
       (8, '数码', '智能手表', 1, '2025-03-09 23:29:40', '2025-03-09 23:29:40'),
       (9, '美妆', '口红', 1, '2025-03-09 23:31:00', '2025-03-09 23:31:00'),
       (10, '美妆', '眼影', 1, '2025-03-09 23:31:10', '2025-03-09 23:31:10'),
       (11, '美妆', '粉底', 1, '2025-03-09 23:31:20', '2025-03-09 23:31:20'),
       (12, '美妆', '护肤套装', 1, '2025-03-09 23:31:30', '2025-03-09 23:31:30'),
       (13, '美妆', '香水', 1, '2025-03-09 23:31:40', '2025-03-09 23:31:40'),
       (14, '食品', '零食', 1, '2025-03-09 23:32:00', '2025-03-09 23:32:00'),
       (15, '食品', '饮料', 1, '2025-03-09 23:32:10', '2025-03-09 23:32:10'),
       (16, '食品', '坚果', 1, '2025-03-09 23:32:20', '2025-03-09 23:32:20');

-- 商品表
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
    buyer_user  int unsigned comment '购买者ID',
    create_time datetime       not null comment '创建时间',
    update_time datetime       not null comment '修改时间',
    constraint fk_goods_category foreign key (category_id) references category (id),
    constraint fk_goods_create_user foreign key (create_user) references user (id),
    constraint fk_goods_buyer_user foreign key (buyer_user) references user (id)
);

-- 插入商品数据
INSERT INTO goods (title, content, cover_img, price, state, category_id, create_user, buyer_user, create_time,
                   update_time)
VALUES
-- 服装 -> 衣服
('T恤', '夏季舒适的棉质T恤', 'https://s21.ax1x.com/2025/03/02/pEGYVYV.jpg', 150, '未被购买', 1, 1, NULL,
 '2025-03-09 23:34:00', '2025-03-09 23:34:00'),
('羽绒服', '保暖羽绒服', 'https://s.coze.cn/t/DKcTbK0zS-0/', 500, '未被购买', 1, 1, NULL, '2025-03-09 23:35:00',
 '2025-03-09 23:35:00'),
('牛仔裤', '经典牛仔裤，适合各种场合', 'https://s.coze.cn/t/OXxGYEA9DCk/', 200, '未被购买', 2, 1, NULL,
 '2025-03-09 23:36:00',
 '2025-03-09 23:36:00'),
('连衣裙', '适合春夏的连衣裙', 'https://s.coze.cn/t/j1n9rfJJA_0/', 350, '未被购买', 1, 2, NULL, '2025-03-09 23:37:00',
 '2025-03-09 23:37:00'),
('运动裤', '适合运动的宽松裤子',
 'https://img.alicdn.com/bao/uploaded/i3/353050747/TB2AlrEdgaTBuNjSszfXXXgfpXa_!!353050747.jpg?1521531836#h', 180,
 '未被购买', 2, 2, NULL, '2025-03-09 23:38:00',
 '2025-03-09 23:38:00');

-- 服装 -> 裤子
INSERT INTO goods (title, content, cover_img, price, state, category_id, create_user, buyer_user, create_time,
                   update_time)
VALUES ('短裤', '透气舒适的夏季短裤', 'https://s.coze.cn/t/tgLoUe_07AU/', 120, '未被购买', 2, 1, NULL,
        '2025-03-09 23:39:00', '2025-03-09 23:39:00'),
       ('西装裤', '正式场合穿着的西装裤', 'https://s.coze.cn/t/4gUcQOKTFKg/', 350, '未被购买', 2, 1, NULL,
        '2025-03-09 23:40:00',
        '2025-03-09 23:40:00'),
       ('工装裤', '耐用的工装裤', 'https://s.coze.cn/t/C5jGwCvAkkU/', 220, '未被购买', 2, 2, NULL,
        '2025-03-09 23:41:00',
        '2025-03-09 23:41:00'),
       ('皮裤', '时尚的皮裤，适合冬季穿着', 'https://s.coze.cn/t/q8vGm07zrbw/', 450, '未被购买', 2, 2, NULL,
        '2025-03-09 23:42:00',
        '2025-03-09 23:42:00'),
       ('瑜伽裤', '适合瑜伽和运动的舒适裤子', 'https://s.coze.cn/t/knl0D6lVyE0/', 160, '未被购买', 2, 2, NULL,
        '2025-03-09 23:43:00',
        '2025-03-09 23:43:00');

-- 服装 -> 鞋子
INSERT INTO goods (title, content, cover_img, price, state, category_id, create_user, buyer_user, create_time,
                   update_time)
VALUES ('运动鞋', '舒适的运动鞋，适合跑步', 'https://s.coze.cn/t/_Ivh-oa-ezU/', 300, '未被购买', 3, 1, NULL,
        '2025-03-09 23:44:00',
        '2025-03-09 23:44:00'),
       ('皮鞋', '优雅的皮鞋，适合正式场合', 'https://s.coze.cn/t/CbEraUWeQLg/', 400, '未被购买', 3, 1, NULL,
        '2025-03-09 23:45:00',
        '2025-03-09 23:45:00'),
       ('高跟鞋', '适合搭配裙子的高跟鞋', 'https://s.coze.cn/t/4aIF-SWx_rY/', 500, '未被购买', 3, 1, NULL,
        '2025-03-09 23:46:00',
        '2025-03-09 23:46:00'),
       ('靴子', '适合秋冬季节穿着的靴子', 'https://s.coze.cn/t/1emLTrMT_-o/', 350, '未被购买', 3, 2, NULL,
        '2025-03-09 23:47:00',
        '2025-03-09 23:47:00'),
       ('凉鞋', '夏季凉爽的凉鞋', 'https://s.coze.cn/t/1emLTrMT_-o/', 120, '未被购买', 3, 2, NULL,
        '2025-03-09 23:48:00', '2025-03-09 23:48:00');

-- 数码 -> 手机
INSERT INTO goods (title, content, cover_img, price, state, category_id, create_user, buyer_user, create_time,
                   update_time)
VALUES ('iPhone 14', '最新款的iPhone 14，支持5G',
        'https://static1.makeuseofimages.com/wordpress/wp-content/uploads/2022/09/iPhone-14-next-to-MacBook.jpg', 8000,
        '未被购买', 4, 1, NULL, '2025-03-09 23:49:00',
        '2025-03-09 23:49:00'),
       ('Samsung Galaxy S22', '三星最新款手机，性能强劲',
        'https://www.etradesupply.com/blog/wp-content/uploads/2022/10/The-Samsung-Galaxy-S23-and-iPhone-14.png', 7000,
        '未被购买', 4, 1, NULL, '2025-03-09 23:50:00',
        '2025-03-09 23:50:00'),
       ('OnePlus 9', 'OnePlus 9，超快充电速度',
        'https://m.360buyimg.com/mobilecms/s750x750_jfs/t1/80346/6/6503/170087/5d49255dE551443af/0d0601b02dbb38e9.jpg!q80.dpg',
        4500, '未被购买', 4, 2, NULL, '2025-03-09 23:51:00',
        '2025-03-09 23:51:00'),
       ('Xiaomi Mi 11', '小米最新款手机，性能稳定',
        'https://p7.itc.cn/images01/20220710/9a195248c104494c8c48e67274a00e10.png', 3500, '未被购买', 4, 2, NULL,
        '2025-03-09 23:52:00',
        '2025-03-09 23:52:00'),
       ('Oppo Find X3', 'Oppo Find X3，极致拍照体验',
        'https://image.oppo.com/content/dam/oppo/product-asset-library/specs/reno6-5g/color-1920.png', 6000, '未被购买',
        4, 2, NULL, '2025-03-09 23:53:00',
        '2025-03-09 23:53:00');

-- 数码 -> 相机
INSERT INTO goods (title, content, cover_img, price, state, category_id, create_user, buyer_user, create_time,
                   update_time)
VALUES ('Canon EOS 90D', '佳能EOS 90D，适合摄影爱好者',
        'https://n.sinaimg.cn/sinakd20121/617/w1684h1333/20220907/22b2-2c31dd5c69e92577f9fa4f2b7ab6f1e7.jpg', 6000,
        '未被购买', 5, 2, NULL,
        '2025-03-09 23:54:00', '2025-03-09 23:54:00'),
       ('Nikon D7500', '尼康D7500，适合旅行摄影',
        'https://www.wanwupai.com/upload/product/20190718-1/267bd7192573c047ab050b1b17f548b1.png', 5500, '未被购买', 5,
        2, NULL, '2025-03-09 23:55:00',
        '2025-03-09 23:55:00'),
       ('Sony Alpha 7', '索尼Alpha 7，专业单反相机',
        'http://article.fansimg.com/attachment/portal/202211/16/153707fad5jsu3x6d3hup6.jpg', 9000, '未被购买', 5, 1,
        NULL, '2025-03-09 23:56:00',
        '2025-03-09 23:56:00'),
       ('Fujifilm X-T4', '富士X-T4，适合街头摄影',
        'https://pic4.zhimg.com/50/v2-a234f28ae17b74f35815d35692d24495_hd.jpg?source=1940ef5c', 7500, '未被购买', 5, 1, NULL,
        '2025-03-09 23:57:00',
        '2025-03-09 23:57:00'),
       ('Panasonic Lumix GH5', '松下Lumix GH5，适合视频拍摄',
        'http://img13.360buyimg.com/n0/jfs/t5917/334/1976498737/207306/a8d66d90/5937695aNce4daa59.jpg', 8000,
        '未被购买', 5, 1, NULL,
        '2025-03-09 23:58:00', '2025-03-09 23:58:00');


-- 数码 -> 耳机
INSERT INTO goods (title, content, cover_img, price, state, category_id, create_user, buyer_user, create_time,
                   update_time)
VALUES ('AirPods Pro', '苹果AirPods Pro，优秀的音质和降噪',
        'https://tse3-mm.cn.bing.net/th/id/OIP-C.134VJ44OStJo8DrF8-JnyAHaHa?rs=1&pid=ImgDetMain', 1200, '未被购买', 6,
        2, NULL,
        '2025-03-09 23:59:00', '2025-03-09 23:59:00'),
       ('Sony WH-1000XM4', '索尼WH-1000XM4，行业领先的降噪耳机',
        'http://www.ugainian.com/yzp/20180611/e3b96f5e58396e264947ab781093b489_cd614b48232901.58922c4f550ed.jpg', 1800,
        '未被购买', 6, 2, NULL,
        '2025-03-10 00:00:00', '2025-03-10 00:00:00'),
       ('Bose QuietComfort 35', 'Bose QuietComfort 35，卓越的舒适性和音质',
        'https://img.zcool.cn/community/0198a25d886cdca8012060bee545b4.jpg', 2000, '未被购买', 6, 1,
        NULL,
        '2025-03-10 00:01:00', '2025-03-10 00:01:00'),
       ('JBL Live 650BTNC', 'JBL Live 650BTNC，便捷的蓝牙耳机',
        'https://tse1-mm.cn.bing.net/th/id/OIP-C.M9S0vGkLqmg1VkGrEjlFYQHaHa?rs=1&pid=ImgDetMain', 800,
        '未被购买', 6, 1, NULL,
        '2025-03-10 00:02:00', '2025-03-10 00:02:00'),
       ('Sennheiser Momentum 3', 'Sennheiser Momentum 3，音质极佳的耳机',
        'https://n.sinaimg.cn/sinakd20221001s/0/w1200h1200/20221001/266e-885ccb3acd1a720e353d963617aa226f.jpg', 2500,
        '未被购买',
        2, 1,
        NULL, '2025-03-10 00:03:00', '2025-03-10 00:03:00');

-- 数码 -> 笔记本电脑
INSERT INTO goods (title, content, cover_img, price, state, category_id, create_user, buyer_user, create_time,
                   update_time)
VALUES ('MacBook Pro 16', '苹果MacBook Pro 16，强大的性能和显示效果',
        'https://tse3-mm.cn.bing.net/th/id/OIP-C.hjV8H8ddOWZ4DCsFDfvMzgHaE8?rs=1&pid=ImgDetMain', 15000, '未被购买', 7,
        2,
        NULL, '2025-03-10 00:04:00', '2025-03-10 00:04:00'),
       ('Dell XPS 13', 'Dell XPS 13，超便携设计，适合学生使用',
        'https://pic2.zhimg.com/v2-5055124f793237180ab22b7c93c993ed_r.jpg', 8000, '未被购买', 7, 1, NULL,
        '2025-03-10 00:05:00', '2025-03-10 00:05:00'),
       ('HP Spectre x360', 'HP Spectre x360，适合商务使用',
        'https://imgslim.geekpark.net/uploads/image/file/bd/8f/bd8fb3d1ded2562f2dec7357badf060a.jpeg', 9000, '未被购买',
        7, 2, NULL,
        '2025-03-10 00:06:00', '2025-03-10 00:06:00'),
       ('Lenovo ThinkPad X1', '联想ThinkPad X1，轻便且高效的商务笔记本',
        'https://pic1.zhimg.com/v2-609133465a959a10b5e4482b42f0d274_b.jpg', 12000, '未被购买', 7,
        1, NULL, '2025-03-10 00:07:00', '2025-03-10 00:07:00'),
       ('Asus ZenBook 14', '华硕ZenBook 14，适合旅行和日常使用，轻便且强大',
        'http://seopic.699pic.com/photo/50056/4304.jpg_wh1200.jpg', 9500, '未被购买', 7,
        1, NULL, '2025-03-10 00:08:00', '2025-03-10 00:08:00');

-- 数码 -> 智能手表
INSERT INTO goods (title, content, cover_img, price, state, category_id, create_user, buyer_user, create_time,
                   update_time)
VALUES ('Apple Watch Series 8', 'Apple Watch Series 8，强大的健康监测功能和时尚设计',
        'https://zhongces3.sina.com.cn/product/20220908/6f25089ed770a065cb9744060393ae64.jpeg', 4000,
        '未被购买', 8, 2, NULL, '2025-03-10 00:09:00', '2025-03-10 00:09:00'),
       ('Samsung Galaxy Watch 5', '三星Galaxy Watch 5，完美融合健康和娱乐',
        'https://doc-fd.zol-img.com.cn/t_s640x2000/g7/M00/07/0E/ChMkK2L5rMuIGpRsAACDJihMPvwAAGfJwPdCkoAAIM-506.jpg', 3500,
        '未被购买', 8, 2, NULL, '2025-03-10 00:10:00', '2025-03-10 00:10:00'),
       ('Garmin Fenix 7', 'Garmin Fenix 7，适合户外运动和极限挑战',
        'https://cbu01.alicdn.com/img/ibank/2014/401/626/1704626104_1559713944.jpg', 5500, '未被购买', 8, 1, NULL,
        '2025-03-10 00:11:00', '2025-03-10 00:11:00'),
       ('Fitbit Versa 4', 'Fitbit Versa 4，专业运动健康监控，适合健身爱好者',
        'http://www.timenetwork.com.cn/uploadfile/2019/0909/20190909102027176.jpg', 2500, '未被购买', 8,
        1, NULL, '2025-03-10 00:12:00', '2025-03-10 00:12:00'),
       ('Amazfit GTR 3', 'Amazfit GTR 3，超长待机与精准健康监测',
        'http://www.ugainian.com/yzp/20180523/Portfolio-08.jpg', 2000, '未被购买', 8, 2, NULL,
        '2025-03-10 00:13:00', '2025-03-10 00:13:00');

-- 美妆 -> 口红
INSERT INTO goods (title, content, cover_img, price, state, category_id, create_user, buyer_user, create_time,
                   update_time)
VALUES ('Dior Rouge Lipstick', 'Dior口红，经典色号，持久保湿',
        'https://img.alicdn.com/bao/uploaded/i2/664473071/O1CN01czvuEk1YYYyJpaFFm_!!0-item_pic.jpg', 350, '未被购买', 9,
        1, NULL,
        '2025-03-10 00:14:00', '2025-03-10 00:14:00'),
       ('Chanel Rouge Coco', '香奈儿Rouge Coco口红，柔滑质地',
        'https://perfumeuae.com/wp-content/uploads/2016/10/chanel_no5_100ml.jpg', 400, '未被购买', 9, 2, NULL,
        '2025-03-10 00:15:00', '2025-03-10 00:15:00'),
       ('MAC Matte Lipstick', 'MAC哑光口红，完美显色，持久不脱妆',
        'https://img95.699pic.com/element/40160/5154.png_860.png', 280, '未被购买', 9, 2, NULL,
        '2025-03-10 00:16:00', '2025-03-10 00:16:00'),
       ('YSL Rouge Pur Couture', 'YSL唇膏，奢华色彩与滋润体验',
        'https://img95.699pic.com/photo/50761/4933.jpg_wh860.jpg', 500, '未被购买', 9, 1, NULL,
        '2025-03-10 00:17:00', '2025-03-10 00:17:00'),
       ('Lancome L’Absolu Rouge', '兰蔻L’Absolu Rouge，极致柔滑滋润',
        'http://seopic.699pic.com/photo/50061/7812.jpg_wh1200.jpg', 420, '未被购买', 9, 1,
        NULL, '2025-03-10 00:18:00', '2025-03-10 00:18:00');

-- 美妆 -> 眼影
INSERT INTO goods (title, content, cover_img, price, state, category_id, create_user, buyer_user, create_time,
                   update_time)
VALUES ('Urban Decay Naked Palette', 'Urban Decay Naked眼影盘，12款流行色彩',
        'http://www.guangyuanol.cn/uploads/allimg/200817/153205M58-1.jpg', 550,
        '未被购买', 10, 2, NULL, '2025-03-10 00:19:00', '2025-03-10 00:19:00'),
       ('Charlotte Tilbury Pillow Talk', 'Charlotte Tilbury Pillow Talk眼影盘，柔美自然',
        'https://tse3-mm.cn.bing.net/th/id/OIP-C.POQkF9hFmfrnTvRo9_tGQAHaE8?rs=1&pid=ImgDetMain', 650, '未被购买',
        10, 1, NULL, '2025-03-10 00:20:00',
        '2025-03-10 00:20:00'),
       ('Too Faced Chocolate Bar', 'Too Faced巧克力眼影盘，香甜可口的色彩',
        'http://n.sinaimg.cn/front/600/w860h540/20190223/J8u_-htknpmi0172640.jpg', 600,
        '未被购买', 10, 2, NULL, '2025-03-10 00:21:00', '2025-03-10 00:21:00'),
       ('Anastasia Beverly Hills', 'Anastasia Modern Renaissance眼影盘，经典红棕色调',
        'http://www.guangyuanol.cn/uploads/allimg/200222/19262B110-4.jpg', 700, '未被购买', 10, 1, NULL,
        '2025-03-10 00:22:00', '2025-03-10 00:22:00'),
       ('Maybelline The Nudes Palette', '美宝莲The Nudes眼影盘，适合日常妆容',
        'http://n.sinaimg.cn/sinacn17/288/w640h448/20180905/a68e-hitesuy7036211.jpg', 180,
        '未被购买', 10, 1, NULL, '2025-03-10 00:23:00', '2025-03-10 00:23:00');

-- 美妆 -> 粉底
INSERT INTO goods (title, content, cover_img, price, state, category_id, create_user, buyer_user, create_time,
                   update_time)
VALUES ('Estee Lauder Double Wear', '雅诗兰黛Double Wear粉底液，持久遮瑕，全天候完美妆容',
        'https://pic4.zhimg.com/v2-2ef0c61c384059ba2ebf2f256de94437_r.jpg',
        600, '未被购买', 11, 2, NULL, '2025-03-10 00:24:00', '2025-03-10 00:24:00'),
       ('Fenty Beauty Pro Filt’r', 'Fenty Beauty Pro Filt’r粉底液，轻盈且持久',
        'https://img.alicdn.com/i4/3641607835/O1CN01lZ5bOn27kU182tabK_!!3641607835.jpg', 500,
        '未被购买', 11, 2, NULL, '2025-03-10 00:25:00', '2025-03-10 00:25:00'),
       ('MAC Studio Fix Fluid', 'MAC Studio Fix粉底液，持久控油，完美遮瑕',
        'https://p0.itc.cn/q_70/images01/20221103/4c4fd280238d43ba93cc16767d9f4584.jpeg', 550, '未被购买',
        11, 1, NULL, '2025-03-10 00:26:00', '2025-03-10 00:26:00'),
       ('Lancôme Teint Idole Ultra Wear', '兰蔻Teint Idole Ultra Wear粉底液，长效持妆，舒适自然',
        'https://img.alicdn.com/imgextra/i1/62491975/O1CN017Np9kr1QSajm5U4o8_!!62491975.jpg', 650, '未被购买', 11, 1,
        NULL, '2025-03-10 00:27:00',
        '2025-03-10 00:27:00'),
       ('Maybelline Fit Me Foundation', '美宝莲Fit Me粉底液，轻薄自然，打造无瑕肌肤',
        'http://www.guangyuanol.cn/uploads/allimg/221118/1122094449-0.png',
        150, '未被购买', 11, 2, NULL, '2025-03-10 00:28:00', '2025-03-10 00:28:00');

-- 美妆 -> 护肤套装
INSERT INTO goods (title, content, cover_img, price, state, category_id, create_user, buyer_user, create_time,
                   update_time)
VALUES ('Estée Lauder Advanced', '雅诗兰黛先进夜修复套装，修护肌肤，恢复青春光采',
        'https://img.alicdn.com/bao/uploaded/i1/2627567660/O1CN01TZaw6T26SKUWhmMih_!!2627567660.jpg', 1500, '未被购买',
        12, 1, NULL, '2025-03-10 00:29:00',
        '2025-03-10 00:29:00'),
       ('SK-II Facial Treatment Set', 'SK-II护肤套装，深层滋润，修护肌肤',
        'https://cbu01.alicdn.com/img/ibank/O1CN01O5bNiH1LPK9EkC1gM_!!2214221071291-0-cib.310x310.jpg', 1800,
        '未被购买', 12, 2, NULL, '2025-03-10 00:30:00', '2025-03-10 00:30:00'),
       ('L’OCCITANE Immortelle', '欧舒丹永恒亮肤护肤套装，焕亮肤色，淡化暗沉',
        'https://img95.699pic.com/photo/40248/1795.jpg_wh860.jpg', 1000, '未被购买', 12, 1, NULL, '2025-03-10 00:31:00',
        '2025-03-10 00:31:00'),
       ('Clinique 3-Step Skincare Set', '倩碧三步曲护肤套装，洁净、滋润、保护，适合所有肤质',
        'https://imgs.699pic.com/images/402/481/793.jpg!list1x.v2', 1200, '未被购买', 12, 2, NULL,
        '2025-03-10 00:32:00',
        '2025-03-10 00:32:00'),
       ('Shiseido Benefiance', '资生堂百优抗老修护护肤套装，抗老紧致，焕发光彩',
        'https://img.zcool.cn/community/031qxtzafmz2wlqelngdjuu3039.png', 2200, '未被购买', 12, 1, NULL,
        '2025-03-10 00:33:00',
        '2025-03-10 00:33:00');

-- 美妆 -> 香水
INSERT INTO goods (title, content, cover_img, price, state, category_id, create_user, buyer_user, create_time,
                   update_time)
VALUES ('Chanel No.5', '香奈儿No.5，经典永恒，魅力四射',
        'https://dianaelizabethblog.com/wp-content/uploads2/2016/09/chanel-no5-leau-perfume-9344a.jpg', 1500, '未被购买', 13, 2, NULL,
        '2025-03-10 00:34:00', '2025-03-10 00:34:00'),
       ('Dior J’adore', '迪奥J’adore香水，清新花香，奢华精致',
        'https://img3.selfimg.com.cn/uedvoguecms/2021/06/24/1624527360_w1ie9x.jpg', 1200, '未被购买', 13, 2, NULL,
        '2025-03-10 00:35:00', '2025-03-10 00:35:00'),
       ('Gucci Bloom', '古驰Bloom，花香扑鼻，温暖迷人',
        'https://img3.selfimg.com.cn/uedvoguecms/2020/07/31/1596181126_uqfBFg.jpg', 1300, '未被购买', 13, 2, NULL,
        '2025-03-10 00:36:00', '2025-03-10 00:36:00'),
       ('Tom Ford Black Orchid', 'Tom Ford黑色兰花香水，性感神秘，独特魅力',
        'https://7718534.s21i.faimallusr.com/2/4/ABUIABACGAAg5sXc7QUo8JnBRzCgBjiRBg.jpg', 2000,
        '未被购买', 13, 1, NULL, '2025-03-10 00:37:00', '2025-03-10 00:37:00'),
       ('Yves Saint Laurent Mon Paris', '圣罗兰Mon Paris，甜美诱人，浪漫情怀',
        'https://img.alicdn.com/imgextra/i2/3626596873/TB1dO9cbljTBKNjSZFNXXasFXXa_!!0-item_pic.jpg', 1100, '未被购买', 13,
        1, NULL, '2025-03-10 00:38:00', '2025-03-10 00:38:00');

-- 食品 -> 零食
INSERT INTO goods (title, content, cover_img, price, state, category_id, create_user, buyer_user, create_time,
                   update_time)
VALUES ('Lay’s Potato Chips', '乐事薯片，经典原味，酥脆美味',
        'https://tse4-mm.cn.bing.net/th/id/OIP-C.F7nGMhlMbRHJbYvnDfUKOwHaHT?rs=1&pid=ImgDetMain',
        20, '未被购买', 14, 2, NULL,
        '2025-03-10 00:39:00', '2025-03-10 00:39:00'),
       ('Pringles Original', '品客薯片，独特的酥脆口感，丰富多样的口味',
        'https://cbu01.alicdn.com/img/ibank/O1CN01ehVgkI2MdM1IRGzKa_!!965339850-0-cib.jpg', 25, '未被购买', 14, 2,
        NULL, '2025-03-10 00:40:00', '2025-03-10 00:40:00'),
       ('Oreo Biscuits', '奥利奥饼干，经典口味，香脆美味',
        'https://tse4-mm.cn.bing.net/th/id/OIP-C.KK7HGILrExq3RI51iW65hwHaHa?rs=1&pid=ImgDetMain', 15, '未被购买', 14, 1,
        NULL,
        '2025-03-10 00:41:00', '2025-03-10 00:41:00'),
       ('Cadbury Dairy Milk Chocolate', '吉百利Dairy Milk巧克力，丝滑口感，香甜可口',
        'https://youimg1.c-ctrip.com/target/100o13000000tyagfFB58.jpg',
        30, '未被购买', 14, 1, NULL, '2025-03-10 00:42:00', '2025-03-10 00:42:00'),
       ('Toblerone Chocolate', '瑞士托伯龙巧克力，独特的三角形设计，口感丰富',
        'https://cbu01.alicdn.com/img/ibank/O1CN01ynkets28CsWDJOfJW_!!2425697897-0-cib.jpg', 40, '未被购买',
        14, 1, NULL, '2025-03-10 00:43:00', '2025-03-10 00:43:00');

-- 食品 -> 饮料
INSERT INTO goods (title, content, cover_img, price, state, category_id, create_user, buyer_user, create_time,
                   update_time)
VALUES ('Coca-Cola Classic', '可口可乐经典，清爽饮料，消暑必备',
        'https://image2.suning.cn/b2c/catentries/000000000155267597_3_800x800.jpg', 5, '未被购买', 15, 1, NULL,
        '2025-03-10 00:44:00', '2025-03-10 00:44:00'),
       ('Pepsi', '百事可乐，经典可口，口感清爽',
        'https://tse1-mm.cn.bing.net/th/id/OIP-C.kMDvD-IPG6A2GqsnJ5rXDQHaHa?rs=1&pid=ImgDetMain', 5, '未被购买', 15, 1,
        NULL, '2025-03-10 00:45:00',
        '2025-03-10 00:45:00'),
       ('Sprite', '雪碧，清新柠檬口味，畅爽无限',
        'https://img14.360buyimg.com/pop/jfs/t1/116348/29/28625/238916/6289a1d3E19052d7f/ca604b4b77d5d8aa.jpg', 6,
        '未被购买', 15, 2, NULL, '2025-03-10 00:46:00',
        '2025-03-10 00:46:00'),
       ('Red Bull Energy Drink', '红牛能量饮料，快速恢复活力，保持清醒',
        'https://cbu01.alicdn.com/img/ibank/2018/686/580/8716085686_1459889105.jpg', 15, '未被购买', 15,
        2, NULL, '2025-03-10 00:47:00', '2025-03-10 00:47:00'),
       ('Nestlé Milo', '雀巢美禄，能量饮料，充满活力', 'https://image.pp918.com/Brand/20190312/20190312165531_5701.jpg',
        12, '未被购买', 15, 2, NULL,
        '2025-03-10 00:48:00', '2025-03-10 00:48:00');

-- 食品 -> 坚果
INSERT INTO goods (title, content, cover_img, price, state, category_id, create_user, buyer_user, create_time,
                   update_time)
VALUES ('Almonds', '杏仁，富含营养，健康美味', 'https://pic.nximg.cn/file/20230313/31527039_204416349121_2.jpg', 30,
        '未被购买', 16, 1, NULL, '2025-03-10 00:49:00',
        '2025-03-10 00:49:00'),
       ('Cashews', '腰果，口感酥脆，富含蛋白质',
        'https://img.alicdn.com/bao/uploaded/i3/796798964/TB2my8ZaFXXXXayXpXXXXXXXXXX_!!796798964.jpg', 35, '未被购买',
        16, 2, NULL, '2025-03-10 00:50:00',
        '2025-03-10 00:50:00'),
       ('Walnuts', '核桃，富含欧米伽-3脂肪酸，养生健康', 'https://img95.699pic.com/photo/50130/7510.jpg_wh860.jpg', 40,
        '未被购买', 16, 1, NULL,
        '2025-03-10 00:51:00', '2025-03-10 00:51:00'),
       ('Pistachios', '开心果，香脆美味，健康零食', 'https://img95.699pic.com/photo/50099/8495.jpg_wh860.jpg', 45,
        '未被购买', 16, 2, NULL, '2025-03-10 00:52:00',
        '2025-03-10 00:52:00'),
       ('Macadamia Nuts', '夏威夷果，香浓口感，适合各种零食搭配',
        'https://pic.nximg.cn/file/20230313/31527039_204356348123_2.jpg', 50, '未被购买', 16, 2, NULL,
        '2025-03-10 00:53:00', '2025-03-10 00:53:00');

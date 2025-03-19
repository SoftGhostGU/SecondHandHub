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
('T恤', '夏季舒适的棉质T恤', 'https://s21.ax1x.com/2025/03/02/pEGYVYV.jpg', 150, '未被购买', 1, 1, NULL, '2025-03-09 23:34:00', '2025-03-09 23:34:00'),
('羽绒服', '保暖羽绒服', 'https://s.coze.cn/t/DKcTbK0zS-0/', 500, '未被购买', 1, 1, NULL, '2025-03-09 23:35:00', '2025-03-09 23:35:00'),
('牛仔裤', '经典牛仔裤，适合各种场合', 'https://s.coze.cn/t/OXxGYEA9DCk/', 200, '未被购买', 2, 1, NULL, '2025-03-09 23:36:00',
 '2025-03-09 23:36:00'),
('连衣裙', '适合春夏的连衣裙', 'https://s.coze.cn/t/j1n9rfJJA_0/', 350, '未被购买', 1, 1, NULL, '2025-03-09 23:37:00', '2025-03-09 23:37:00'),
('运动裤', '适合运动的宽松裤子', 'https://img.alicdn.com/bao/uploaded/i3/353050747/TB2AlrEdgaTBuNjSszfXXXgfpXa_!!353050747.jpg?1521531836#h', 180, '未被购买', 2, 1, NULL, '2025-03-09 23:38:00',
 '2025-03-09 23:38:00');

-- 服装 -> 裤子
    INSERT INTO goods (title, content, cover_img, price, state, category_id, create_user, buyer_user, create_time,
                       update_time)
VALUES('短裤', '透气舒适的夏季短裤', 'https://s.coze.cn/t/tgLoUe_07AU/', 120, '未被购买', 2, 1, NULL, '2025-03-09 23:39:00', '2025-03-09 23:39:00'),
('西装裤', '正式场合穿着的西装裤', 'https://s.coze.cn/t/4gUcQOKTFKg/', 350, '未被购买', 2, 1, NULL, '2025-03-09 23:40:00',
 '2025-03-09 23:40:00'),
('工装裤', '耐用的工装裤', 'https://s.coze.cn/t/C5jGwCvAkkU/', 220, '未被购买', 2, 1, NULL, '2025-03-09 23:41:00',
 '2025-03-09 23:41:00'),
('皮裤', '时尚的皮裤，适合冬季穿着', 'https://s.coze.cn/t/q8vGm07zrbw/', 450, '未被购买', 2, 1, NULL, '2025-03-09 23:42:00',
 '2025-03-09 23:42:00'),
('瑜伽裤', '适合瑜伽和运动的舒适裤子', 'https://s.coze.cn/t/knl0D6lVyE0/', 160, '未被购买', 2, 1, NULL, '2025-03-09 23:43:00',
 '2025-03-09 23:43:00');

-- 服装 -> 鞋子
    INSERT INTO goods (title, content, cover_img, price, state, category_id, create_user, buyer_user, create_time,
                       update_time)
VALUES('运动鞋', '舒适的运动鞋，适合跑步', 'https://s.coze.cn/t/_Ivh-oa-ezU/', 300, '未被购买', 3, 1, NULL, '2025-03-09 23:44:00',
 '2025-03-09 23:44:00'),
('皮鞋', '优雅的皮鞋，适合正式场合', 'https://s.coze.cn/t/CbEraUWeQLg/', 400, '未被购买', 3, 1, NULL, '2025-03-09 23:45:00',
 '2025-03-09 23:45:00'),
('高跟鞋', '适合搭配裙子的高跟鞋', 'https://s.coze.cn/t/4aIF-SWx_rY/', 500, '未被购买', 3, 1, NULL, '2025-03-09 23:46:00',
 '2025-03-09 23:46:00'),
('靴子', '适合秋冬季节穿着的靴子', 'https://s.coze.cn/t/1emLTrMT_-o/', 350, '未被购买', 3, 1, NULL, '2025-03-09 23:47:00',
 '2025-03-09 23:47:00'),
('凉鞋', '夏季凉爽的凉鞋', 'https://s.coze.cn/t/1emLTrMT_-o/', 120, '未被购买', 3, 1, NULL, '2025-03-09 23:48:00', '2025-03-09 23:48:00');

-- 数码 -> 手机
    INSERT INTO goods (title, content, cover_img, price, state, category_id, create_user, buyer_user, create_time,
                       update_time)
VALUES('iPhone 14', '最新款的iPhone 14，支持5G', 'https://static1.makeuseofimages.com/wordpress/wp-content/uploads/2022/09/iPhone-14-next-to-MacBook.jpg', 8000, '未被购买', 4, 1, NULL, '2025-03-09 23:49:00',
 '2025-03-09 23:49:00'),
('Samsung Galaxy S22', '三星最新款手机，性能强劲', 'https://www.etradesupply.com/blog/wp-content/uploads/2022/10/The-Samsung-Galaxy-S23-and-iPhone-14.png', 7000, '未被购买', 4, 1, NULL, '2025-03-09 23:50:00',
 '2025-03-09 23:50:00'),
('OnePlus 9', 'OnePlus 9，超快充电速度', 'https://m.360buyimg.com/mobilecms/s750x750_jfs/t1/80346/6/6503/170087/5d49255dE551443af/0d0601b02dbb38e9.jpg!q80.dpg', 4500, '未被购买', 4, 1, NULL, '2025-03-09 23:51:00',
 '2025-03-09 23:51:00'),
('Xiaomi Mi 11', '小米最新款手机，性能稳定', 'https://p7.itc.cn/images01/20220710/9a195248c104494c8c48e67274a00e10.png', 3500, '未被购买', 4, 1, NULL, '2025-03-09 23:52:00',
 '2025-03-09 23:52:00'),
('Oppo Find X3', 'Oppo Find X3，极致拍照体验', 'https://image.oppo.com/content/dam/oppo/product-asset-library/specs/reno6-5g/color-1920.png', 6000, '未被购买', 4, 1, NULL, '2025-03-09 23:53:00',
 '2025-03-09 23:53:00');





-- 数码 -> 相机
    INSERT INTO goods (title, content, cover_img, price, state, category_id, create_user, buyer_user, create_time,
                       update_time)
VALUES('Canon EOS 90D', '佳能EOS 90D，适合摄影爱好者', 'canon_eos_90d.jpg', 6000, '未被购买', 5, 1, NULL,
 '2025-03-09 23:54:00', '2025-03-09 23:54:00'),
('Nikon D7500', '尼康D7500，适合旅行摄影', 'nikon_d7500.jpg', 5500, '未被购买', 5, 1, NULL, '2025-03-09 23:55:00',
 '2025-03-09 23:55:00'),
('Sony Alpha 7', '索尼Alpha 7，专业单反相机', 'sony_alpha_7.jpg', 9000, '未被购买', 5, 1, NULL, '2025-03-09 23:56:00',
 '2025-03-09 23:56:00'),
('Fujifilm X-T4', '富士X-T4，适合街头摄影', 'fujifilm_xt4.jpg', 7500, '未被购买', 5, 1, NULL, '2025-03-09 23:57:00',
 '2025-03-09 23:57:00'),
('Panasonic Lumix GH5', '松下Lumix GH5，适合视频拍摄', 'lumix_gh5.jpg', 8000, '未被购买', 5, 1, NULL,
 '2025-03-09 23:58:00', '2025-03-09 23:58:00');

-- 数码 -> 耳机
    INSERT INTO goods (title, content, cover_img, price, state, category_id, create_user, buyer_user, create_time,
                       update_time)
VALUES ('AirPods Pro', '苹果AirPods Pro，优秀的音质和降噪', 'airpods_pro.jpg', 1200, '未被购买', 6, 1, NULL,
 '2025-03-09 23:59:00', '2025-03-09 23:59:00'),
('Sony WH-1000XM4', '索尼WH-1000XM4，行业领先的降噪耳机', 'sony_wh1000xm4.jpg', 1800, '未被购买', 6, 1, NULL,
 '2025-03-10 00:00:00', '2025-03-10 00:00:00'),
('Bose QuietComfort 35', 'Bose QuietComfort 35，卓越的舒适性和音质', 'bose_qc35.jpg', 2000, '未被购买', 6, 1, NULL,
 '2025-03-10 00:01:00', '2025-03-10 00:01:00'),
('JBL Live 650BTNC', 'JBL Live 650BTNC，便捷的蓝牙耳机', 'jbl_live_650.jpg', 800, '未被购买', 6, 1, NULL,
 '2025-03-10 00:02:00', '2025-03-10 00:02:00'),
('Sennheiser Momentum 3', 'Sennheiser Momentum 3，音质极佳的耳机', 'sennheiser_momentum3.jpg', 2500, '未被购买', 6, 1,
 NULL, '2025-03-10 00:03:00', '2025-03-10 00:03:00');

-- 数码 -> 笔记本电脑
INSERT INTO goods (title, content, cover_img, price, state, category_id, create_user, buyer_user, create_time,
                   update_time)
VALUES ('MacBook Pro 16', '苹果MacBook Pro 16，强大的性能和显示效果', 'macbook_pro_16.jpg', 15000, '未被购买', 7, 1,
        NULL, '2025-03-10 00:04:00', '2025-03-10 00:04:00'),
       ('Dell XPS 13', 'Dell XPS 13，超便携设计，适合学生使用', 'dell_xps_13.jpg', 8000, '未被购买', 7, 1, NULL,
        '2025-03-10 00:05:00', '2025-03-10 00:05:00'),
       ('HP Spectre x360', 'HP Spectre x360，适合商务使用', 'hp_spectre_x360.jpg', 9000, '未被购买', 7, 1, NULL,
        '2025-03-10 00:06:00', '2025-03-10 00:06:00'),
       ('Lenovo ThinkPad X1', '联想ThinkPad X1，轻便且高效的商务笔记本', 'lenovo_thinkpad_x1.jpg', 12000, '未被购买', 7,
        1, NULL, '2025-03-10 00:07:00', '2025-03-10 00:07:00'),
       ('Asus ZenBook 14', '华硕ZenBook 14，适合旅行和日常使用，轻便且强大', 'asus_zenbook_14.jpg', 9500, '未被购买', 7,
        1, NULL, '2025-03-10 00:08:00', '2025-03-10 00:08:00');

-- 数码 -> 智能手表
INSERT INTO goods (title, content, cover_img, price, state, category_id, create_user, buyer_user, create_time, update_time)
VALUES
    ('Apple Watch Series 8', 'Apple Watch Series 8，强大的健康监测功能和时尚设计', 'apple_watch_series_8.jpg', 4000, '未被购买', 8, 1, NULL, '2025-03-10 00:09:00', '2025-03-10 00:09:00'),
    ('Samsung Galaxy Watch 5', '三星Galaxy Watch 5，完美融合健康和娱乐', 'samsung_galaxy_watch_5.jpg', 3500, '未被购买', 8, 1, NULL, '2025-03-10 00:10:00', '2025-03-10 00:10:00'),
    ('Garmin Fenix 7', 'Garmin Fenix 7，适合户外运动和极限挑战', 'garmin_fenix_7.jpg', 5500, '未被购买', 8, 1, NULL, '2025-03-10 00:11:00', '2025-03-10 00:11:00'),
    ('Fitbit Versa 4', 'Fitbit Versa 4，专业运动健康监控，适合健身爱好者', 'fitbit_versa_4.jpg', 2500, '未被购买', 8, 1, NULL, '2025-03-10 00:12:00', '2025-03-10 00:12:00'),
    ('Amazfit GTR 3', 'Amazfit GTR 3，超长待机与精准健康监测', 'amazfit_gtr_3.jpg', 2000, '未被购买', 8, 1, NULL, '2025-03-10 00:13:00', '2025-03-10 00:13:00');

-- 美妆 -> 口红
INSERT INTO goods (title, content, cover_img, price, state, category_id, create_user, buyer_user, create_time, update_time)
VALUES
    ('Dior Rouge Lipstick', 'Dior口红，经典色号，持久保湿', 'dior_rouge_lipstick.jpg', 350, '未被购买', 9, 1, NULL, '2025-03-10 00:14:00', '2025-03-10 00:14:00'),
    ('Chanel Rouge Coco', '香奈儿Rouge Coco口红，柔滑质地', 'chanel_rouge_coco.jpg', 400, '未被购买', 9, 1, NULL, '2025-03-10 00:15:00', '2025-03-10 00:15:00'),
    ('MAC Matte Lipstick', 'MAC哑光口红，完美显色，持久不脱妆', 'mac_matte_lipstick.jpg', 280, '未被购买', 9, 1, NULL, '2025-03-10 00:16:00', '2025-03-10 00:16:00'),
    ('YSL Rouge Pur Couture', 'YSL唇膏，奢华色彩与滋润体验', 'ysl_rouge_pur_couture.jpg', 500, '未被购买', 9, 1, NULL, '2025-03-10 00:17:00', '2025-03-10 00:17:00'),
    ('Lancome L’Absolu Rouge', '兰蔻L’Absolu Rouge，极致柔滑滋润', 'lancome_labsolu_rouge.jpg', 420, '未被购买', 9, 1, NULL, '2025-03-10 00:18:00', '2025-03-10 00:18:00');

-- 美妆 -> 眼影
INSERT INTO goods (title, content, cover_img, price, state, category_id, create_user, buyer_user, create_time, update_time)
VALUES
    ('Urban Decay Naked Palette', 'Urban Decay Naked眼影盘，12款流行色彩', 'urban_decay_naked_palette.jpg', 550, '未被购买', 10, 1, NULL, '2025-03-10 00:19:00', '2025-03-10 00:19:00'),
    ('Charlotte Tilbury Pillow Talk', 'Charlotte Tilbury Pillow Talk眼影盘，柔美自然', 'charlotte_tilbury_pillow_talk.jpg', 650, '未被购买', 10, 1, NULL, '2025-03-10 00:20:00', '2025-03-10 00:20:00'),
    ('Too Faced Chocolate Bar', 'Too Faced巧克力眼影盘，香甜可口的色彩', 'too_faced_chocolate_bar.jpg', 600, '未被购买', 10, 1, NULL, '2025-03-10 00:21:00', '2025-03-10 00:21:00'),
    ('Anastasia Beverly Hills Modern Renaissance', 'Anastasia Modern Renaissance眼影盘，经典红棕色调', 'anastasia_modern_renaissance.jpg', 700, '未被购买', 10, 1, NULL, '2025-03-10 00:22:00', '2025-03-10 00:22:00'),
    ('Maybelline The Nudes Palette', '美宝莲The Nudes眼影盘，适合日常妆容', 'maybelline_the_nudes_palette.jpg', 180, '未被购买', 10, 1, NULL, '2025-03-10 00:23:00', '2025-03-10 00:23:00');

-- 美妆 -> 粉底
INSERT INTO goods (title, content, cover_img, price, state, category_id, create_user, buyer_user, create_time, update_time)
VALUES
    ('Estee Lauder Double Wear', '雅诗兰黛Double Wear粉底液，持久遮瑕，全天候完美妆容', 'estee_lauder_double_wear.jpg', 600, '未被购买', 11, 1, NULL, '2025-03-10 00:24:00', '2025-03-10 00:24:00'),
    ('Fenty Beauty Pro Filt’r', 'Fenty Beauty Pro Filt’r粉底液，轻盈且持久', 'fenty_beauty_pro_filter.jpg', 500, '未被购买', 11, 1, NULL, '2025-03-10 00:25:00', '2025-03-10 00:25:00'),
    ('MAC Studio Fix Fluid', 'MAC Studio Fix粉底液，持久控油，完美遮瑕', 'mac_studio_fix_fluid.jpg', 550, '未被购买', 11, 1, NULL, '2025-03-10 00:26:00', '2025-03-10 00:26:00'),
    ('Lancôme Teint Idole Ultra Wear', '兰蔻Teint Idole Ultra Wear粉底液，长效持妆，舒适自然', 'lancome_teint_idole_ultra_wear.jpg', 650, '未被购买', 11, 1, NULL, '2025-03-10 00:27:00', '2025-03-10 00:27:00'),
    ('Maybelline Fit Me Foundation', '美宝莲Fit Me粉底液，轻薄自然，打造无瑕肌肤', 'maybelline_fit_me_foundation.jpg', 150, '未被购买', 11, 1, NULL, '2025-03-10 00:28:00', '2025-03-10 00:28:00');

-- 美妆 -> 护肤套装
INSERT INTO goods (title, content, cover_img, price, state, category_id, create_user, buyer_user, create_time, update_time)
VALUES
    ('Estée Lauder Advanced Night Repair', '雅诗兰黛先进夜修复套装，修护肌肤，恢复青春光采', 'estee_lauder_advanced_night_repair.jpg', 1500, '未被购买', 12, 1, NULL, '2025-03-10 00:29:00', '2025-03-10 00:29:00'),
    ('SK-II Facial Treatment Set', 'SK-II护肤套装，深层滋润，修护肌肤', 'ski_facial_treatment_set.jpg', 1800, '未被购买', 12, 1, NULL, '2025-03-10 00:30:00', '2025-03-10 00:30:00'),
    ('L’OCCITANE Immortelle Brightening Set', '欧舒丹永恒亮肤护肤套装，焕亮肤色，淡化暗沉', 'loccitane_immortelle_brightening_set.jpg', 1000, '未被购买', 12, 1, NULL, '2025-03-10 00:31:00', '2025-03-10 00:31:00'),
    ('Clinique 3-Step Skincare Set', '倩碧三步曲护肤套装，洁净、滋润、保护，适合所有肤质', 'clinique_3_step_skincare_set.jpg', 1200, '未被购买', 12, 1, NULL, '2025-03-10 00:32:00', '2025-03-10 00:32:00'),
    ('Shiseido Benefiance WrinkleResist24 Set', '资生堂百优抗老修护护肤套装，抗老紧致，焕发光彩', 'shiseido_benefiance_wrinkleresist24.jpg', 2200, '未被购买', 12, 1, NULL, '2025-03-10 00:33:00', '2025-03-10 00:33:00');

-- 美妆 -> 香水
INSERT INTO goods (title, content, cover_img, price, state, category_id, create_user, buyer_user, create_time, update_time)
VALUES
    ('Chanel No.5', '香奈儿No.5，经典永恒，魅力四射', 'chanel_no_5.jpg', 1500, '未被购买', 13, 1, NULL, '2025-03-10 00:34:00', '2025-03-10 00:34:00'),
    ('Dior J’adore', '迪奥J’adore香水，清新花香，奢华精致', 'dior_jadore.jpg', 1200, '未被购买', 13, 1, NULL, '2025-03-10 00:35:00', '2025-03-10 00:35:00'),
    ('Gucci Bloom', '古驰Bloom，花香扑鼻，温暖迷人', 'gucci_bloom.jpg', 1300, '未被购买', 13, 1, NULL, '2025-03-10 00:36:00', '2025-03-10 00:36:00'),
    ('Tom Ford Black Orchid', 'Tom Ford黑色兰花香水，性感神秘，独特魅力', 'tom_ford_black_orchid.jpg', 2000, '未被购买', 13, 1, NULL, '2025-03-10 00:37:00', '2025-03-10 00:37:00'),
    ('Yves Saint Laurent Mon Paris', '圣罗兰Mon Paris，甜美诱人，浪漫情怀', 'ysl_mon_paris.jpg', 1100, '未被购买', 13, 1, NULL, '2025-03-10 00:38:00', '2025-03-10 00:38:00');

-- 食品 -> 零食
INSERT INTO goods (title, content, cover_img, price, state, category_id, create_user, buyer_user, create_time, update_time)
VALUES
    ('Lay’s Potato Chips', '乐事薯片，经典原味，酥脆美味', 'lays_potato_chips.jpg', 20, '未被购买', 14, 1, NULL, '2025-03-10 00:39:00', '2025-03-10 00:39:00'),
    ('Pringles Original', '品客薯片，独特的酥脆口感，丰富多样的口味', 'pringles_original.jpg', 25, '未被购买', 14, 1, NULL, '2025-03-10 00:40:00', '2025-03-10 00:40:00'),
    ('Oreo Biscuits', '奥利奥饼干，经典口味，香脆美味', 'oreo_biscuits.jpg', 15, '未被购买', 14, 1, NULL, '2025-03-10 00:41:00', '2025-03-10 00:41:00'),
    ('Cadbury Dairy Milk Chocolate', '吉百利Dairy Milk巧克力，丝滑口感，香甜可口', 'cadbury_dairy_milk_chocolate.jpg', 30, '未被购买', 14, 1, NULL, '2025-03-10 00:42:00', '2025-03-10 00:42:00'),
    ('Toblerone Chocolate', '瑞士托伯龙巧克力，独特的三角形设计，口感丰富', 'toblerone_chocolate.jpg', 40, '未被购买', 14, 1, NULL, '2025-03-10 00:43:00', '2025-03-10 00:43:00');

-- 食品 -> 饮料
INSERT INTO goods (title, content, cover_img, price, state, category_id, create_user, buyer_user, create_time, update_time)
VALUES
    ('Coca-Cola Classic', '可口可乐经典，清爽饮料，消暑必备', 'coca_cola_classic.jpg', 5, '未被购买', 15, 1, NULL, '2025-03-10 00:44:00', '2025-03-10 00:44:00'),
    ('Pepsi', '百事可乐，经典可口，口感清爽', 'pepsi.jpg', 5, '未被购买', 15, 1, NULL, '2025-03-10 00:45:00', '2025-03-10 00:45:00'),
    ('Sprite', '雪碧，清新柠檬口味，畅爽无限', 'sprite.jpg', 6, '未被购买', 15, 1, NULL, '2025-03-10 00:46:00', '2025-03-10 00:46:00'),
    ('Red Bull Energy Drink', '红牛能量饮料，快速恢复活力，保持清醒', 'red_bull_energy_drink.jpg', 15, '未被购买', 15, 1, NULL, '2025-03-10 00:47:00', '2025-03-10 00:47:00'),
    ('Nestlé Milo', '雀巢美禄，能量饮料，充满活力', 'nestle_milo.jpg', 12, '未被购买', 15, 1, NULL, '2025-03-10 00:48:00', '2025-03-10 00:48:00');

-- 食品 -> 坚果
INSERT INTO goods (title, content, cover_img, price, state, category_id, create_user, buyer_user, create_time, update_time)
VALUES
    ('Almonds', '杏仁，富含营养，健康美味', 'almonds.jpg', 30, '未被购买', 16, 1, NULL, '2025-03-10 00:49:00', '2025-03-10 00:49:00'),
    ('Cashews', '腰果，口感酥脆，富含蛋白质', 'cashews.jpg', 35, '未被购买', 16, 1, NULL, '2025-03-10 00:50:00', '2025-03-10 00:50:00'),
    ('Walnuts', '核桃，富含欧米伽-3脂肪酸，养生健康', 'walnuts.jpg', 40, '未被购买', 16, 1, NULL, '2025-03-10 00:51:00', '2025-03-10 00:51:00'),
    ('Pistachios', '开心果，香脆美味，健康零食', 'pistachios.jpg', 45, '未被购买', 16, 1, NULL, '2025-03-10 00:52:00', '2025-03-10 00:52:00'),
    ('Macadamia Nuts', '夏威夷果，香浓口感，适合各种零食搭配', 'macadamia_nuts.jpg', 50, '未被购买', 16, 1, NULL, '2025-03-10 00:53:00', '2025-03-10 00:53:00');

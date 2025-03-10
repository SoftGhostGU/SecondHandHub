<template>
  <div class="product-card">
    <!-- 商品图片 -->
    <div class="product-image">
      <img :src="image" :alt="title" />
    </div>
    <!-- 商品信息 -->
    <div class="product-info">
      <div class="product-title" :title="title">{{ title }}</div>
      <div class="product-price">
        ¥<span>{{ price }}</span>
      </div>
      <!-- <div class="product-status">
        <span
          :class="{
            'status-sold': state === '已被购买',
            'status-available': state === '未被购买',
          }"
        >
          状态：{{ state }}
        </span>
      </div> -->
      <!-- 按钮 -->
      <div class="product-actions">
        <button @click="lookForMore">查看详情</button>
        <button @click="buyNow">立即购买</button>
      </div>
    </div>

    <!-- 弹窗 - 商品信息 -->
    <div v-if="isModalVisible" class="modal">
      <div class="modal-content">
        <h3>商品详情</h3>
        <img :src="image" alt="image" class="modal-image" />
        <p>名称: {{ title }}</p>
        <p>内容: {{ content }}</p>
        <p>价格: ¥{{ price }}</p>
        <p>状态: {{ state }}</p>
        <p>创建者: {{ username }}</p>
        <button @click="closeAll">关闭</button>
        <button @click="buyNow">立即购买</button>
      </div>
    </div>

    <!-- 弹窗 - 立即购买 -->
    <div v-if="isBuyNowModalVisible" class="modal">
      <div class="modal-content">
        <h3>立即购买</h3>
        <img :src="image" alt="image" class="modal-image" />
        <p>名称: {{ title }}</p>
        <p>价格: ¥{{ price }}</p>
        <p>创建者: {{ username }}</p>
        <p>请联系卖家：{{ email }}</p>
        <button @click="closeAll">关闭</button>
        <button @click="lookForMore">查看详情</button>
        <button @click="openContactSellerModal">联系卖家</button>
      </div>
    </div>

    <!-- 弹窗 - 联系商家 -->
    <div v-if="isContactSellerModalVisible" class="modal">
      <div class="modal-content">
        <h3>联系卖家</h3>
        <img :src="image" alt="image" class="modal-image" />
        <p class="text-confirm">用户名：{{ myname }}</p>
        <p class="text-confirm">邮箱：{{ myemail }}</p>
        <p class="text-confirm-gray">请确认信息无误以后，点击“联系卖家”按钮，我们将会帮您发送邮件，请耐心等待。</p>
        <button @click="closeAll">关闭</button>
        <button @click="closeContactSellerModal">回到上一页</button>
        <button @click="contactSeller(myname, title, myemail)">联系卖家</button>
      </div>
    </div>
  </div>
</template>
  
<script setup>
import { ref, defineProps } from "vue";

// 定义属性
const props = defineProps({
  image: {
    type: String,
    required: true,
  },
  title: {
    type: String,
    required: true,
  },
  content: {
    type: String,
    required: true,
  },
  price: {
    type: Number,
    required: true,
  },
  state: {
    type: String,
    required: true,
  },
  createUser: {
    type: String, // 如果创建者是字符串类型，保持为 String
    required: false,
  },
});

// 控制弹窗显示
const isModalVisible = ref(false);
const isBuyNowModalVisible = ref(false);
const isContactSellerModalVisible = ref(false);

// 方法
const lookForMore = () => {
  isModalVisible.value = true; // 打开弹窗
  isBuyNowModalVisible.value = false; // 关闭弹窗
};

const closeAll = () => {
  isModalVisible.value = false; // 关闭弹窗
  isBuyNowModalVisible.value = false; // 关闭弹窗
  isContactSellerModalVisible.value = false; // 关闭弹窗
};

const buyNow = () => {
  isModalVisible.value = false; // 关闭弹窗
  isBuyNowModalVisible.value = true; // 打开弹窗
};

const openContactSellerModal = () => {
  isContactSellerModalVisible.value = true; // 打开弹窗
};

const closeContactSellerModal = () => {
  isContactSellerModalVisible.value = false; // 打开弹窗
};

import { getUserInfoByIdService } from "@/api/user.js";

const username = ref("");
const email = ref("");
const getUserInfo = async (userID) => {
  const result = await getUserInfoByIdService(userID);
  console.log(result);
  username.value = result.data.username;
  email.value = result.data.email;
  return result;
};
getUserInfo(1);

import { sendMail } from "../api/mailSender";

const files = [];
files.forEach((file) => {
  mailData.append("file", file);
});
const contactSeller = async (myname, title, myemail) => {
  const mailData = {
    to: email.value,
    subject: "二手商品信息 - 有顾客想要购买你出售的商品",
    content: "你好！~ 我是" + myname + "，我想购买你出售的图片中的" + title + "。我的联系方式是" + myemail + "，我们商量一下怎么交接吧~",
  };
  
  sendMail(mailData, files)
    .then((response) => {
      console.log("邮件发送成功", response.data);
    })
    .catch((error) => {
      console.error("邮件发送失败", error);
    });
  
  setTimeout(() => {
    closeAll();
  }, 3000);
};

import { userInfoService } from "@/api/user.js";
const myname = ref("");
const myemail = ref("");
const getMyInfo = async () => {
  const result = await userInfoService();
  console.log(result);
  myname.value = result.data.username;
  myemail.value = result.data.email;
  return result;
};
getMyInfo();
</script>
  
<style scoped>
.product-card {
  display: flex;
  flex-direction: column;
  width: 200px;
  border: 1px solid #e5e5e5;
  border-radius: 8px;
  overflow: hidden;
  background-color: #fff;
  transition: box-shadow 0.2s ease-in-out;
  position: relative;
}

.product-card:hover {
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.5);
}

.product-image img {
  width: 100%;
  height: 150px;
  object-fit: cover;
}

.product-info {
  padding: 10px;
}

.product-title {
  font-size: 14px;
  color: #333;
  overflow: hidden;
  white-space: nowrap;
  text-overflow: ellipsis;
  margin-bottom: 8px;
}

.product-price {
  font-size: 16px;
  color: #f40;
  font-weight: bold;
  margin-bottom: 12px;
}

.product-status span {
  display: inline-block;
  font-size: 14px;
  font-weight: bold;
  padding: 4px 8px;
  border-radius: 12px;
  color: #fff;
}

.product-status .status-sold {
  background-color: #ff4d4f;
}

.product-status .status-available {
  background-color: #52c41a;
}

.product-actions {
  display: flex;
  justify-content: space-between;
}

.product-actions button {
  flex: 1;
  padding: 8px;
  border: none;
  border-radius: 4px;
  font-size: 14px;
  cursor: pointer;
  transition: background-color 0.2s ease-in-out;
}

.product-actions button:first-child {
  background-color: #ff9900;
  margin-right: 4px;
  color: #fff;
}

.product-actions button:last-child {
  background-color: #ff5722;
  color: #fff;
}

.product-actions button:hover {
  opacity: 0.8;
}

.modal {
  position: fixed;
  top: 0;
  left: 0;
  width: 100vw;
  height: 100vh;
  background-color: rgba(0, 0, 0, 0.5);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 100;
}

.modal-content {
  background: white;
  padding: 20px;
  border-radius: 8px;
  width: 300px;
  height: 650px;
  overflow-x: hidden;
  overflow-y: scroll;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
}

/* 隐藏导航条 */
.modal-content::-webkit-scrollbar {
  display: none;
}

.modal-content h3 {
  margin-top: 0;
}

.modal-image {
  width: 100%;
}

.modal-content button {
  margin-top: 10px;
  padding: 8px 16px;
  background-color: #007bff;
  border: none;
  color: white;
  border-radius: 4px;
  cursor: pointer;
  margin-right: 10px;
}

.modal-content button:hover {
  background-color: #0056b3;
}

.text-confirm {
  text-align: center;
  font-size: 16px;
}

.text-confirm-gray {
  color: gray;
  text-align: center;
  font-size: 14px;
}
</style>
  
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
      <div class="product-status">
        <span :class="{'status-sold': state === '已被购买', 'status-available': state === '未被购买'}">
          状态：{{ state }}
        </span>
      </div>
      <!-- 按钮 -->
      <!-- <div class="product-actions">
        <button @click="addToCart">加入购物车</button>
        <button @click="buyNow">立即购买</button>
      </div> -->
    </div>
  </div>
</template>

<script>
export default {
  name: "ProductCard",
  props: {
    image: {
      type: String,
      required: true,
    },
    title: {
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
    }
  },
  methods: {
    addToCart() {
      this.$emit("add-to-cart", this.title);
    },
    buyNow() {
      this.$emit("buy-now", this.title);
    },
  },
};
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
</style>

<script setup lang="ts">
import LoginAndRegister from '@/components/LoginAndRegister.vue'
</script>

<template>
  <div class="login-view">
    <div class="login-header">
      <img src="@/assets/images/ECNU_logo.png" alt="" />
    </div>
    <h1>Login</h1>
    <router-link to="/">
      <div>back to home</div>
    </router-link>
    <div class="login-form">
      <LoginAndRegister />
    </div>

    <!-- 版权 -->
    <span class="footer">
      版权所有 ©华东师范大学 闵行校区：东川路500号，200241 普陀校区：中山北路3663号，200062
      its@ecnu.edu.cn
    </span>
  </div>
</template>

<style scoped>
.login-view {
  width: 100%;
  height: 100%;
  margin: -8px;
  background: url('@/assets/images/background.png') center no-repeat fixed;
  background-size: cover;
  position: absolute;
  overflow-x: hidden;
  overflow-y: hidden;
}

.login-header img {
  width: 250px;
  margin: 30px;
  filter: brightness(0) invert(1);
}

.login-form {
  width: 758px;
  height: 420px;
  position: absolute;
  top: -30%;
  right: -20%;
  transform: translate(-50%, 50%);
}

.footer {
  color: gray;
  font-size: 12px;
  margin-top: 2rem;
  text-align: center;
  position: absolute;
  bottom: 30px;
  left: 50%;
  transform: translateX(-50%);
  z-index: 100;
}

h1 {
  color: blue;
}
</style>

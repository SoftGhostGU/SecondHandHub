<script setup lang="ts">
import { onMounted, ref, reactive } from 'vue'
import { type FormInstance, type FormRules, ElMessage } from 'element-plus'

onMounted(() => {
  const signInBtn = document.getElementById('signIn')
  const signUpBtn = document.getElementById('signUp')
  const firstForm = document.getElementById('form1')
  const secondForm = document.getElementById('form2')
  const container = document.querySelector('.container')

  signInBtn?.addEventListener('click', () => {
    container?.classList.remove('right-panel-active')
  })

  signUpBtn?.addEventListener('click', () => {
    container?.classList.add('right-panel-active')
  })

  firstForm?.addEventListener('submit', (e) => e.preventDefault())
  secondForm?.addEventListener('submit', (e) => e.preventDefault())
})

// --------------------------------------------
const ruleFormRef = ref<FormInstance>()

const registerData = ref({
  username: '',
  password: '',
  rePassword: '',
})
const loginData = reactive({
  username: '',
  password: '',
})
const validateUsername = (rule: any, value: any, callback: any) => {
  if (value === '') {
    callback(new Error('用户名不能为空'))
  } else if (value.length < 5 || value.length > 20) {
    callback(new Error('用户名长度需要在5到20个字符之间'))
  } else {
    callback()
  }
}
const validatePass = (rule: any, value: any, callback: any) => {
  if (value === '') {
    callback(new Error('密码不能为空'))
  } else if (value.length < 5 || value.length > 32) {
    callback(new Error('密码长度需要在5到32个字符之间'))
  } else {
    if (registerData.value.password !== '') {
      if (!ruleFormRef.value) return
      ruleFormRef.value.validateField('password')
    }
    callback()
  }
}
const validatePass2 = (rule: any, value: any, callback: any) => {
  if (value === '') {
    callback(new Error('密码不能为空'))
  } else if (value !== registerData.value.password) {
    callback(new Error('与密码不一致'))
  } else {
    callback()
  }
}

const rules = {
  username: [
    { required: true, message: '请输入用户名', trigger: 'blur' },
    { min: 5, max: 20, message: '长度为5~20位非空字符', trigger: 'blur' },
  ],
  password: [
    { required: true, message: '请输入密码', trigger: 'blur' },
    { min: 5, max: 32, message: '长度为5~32位非空字符', trigger: 'blur' },
  ],
  rePassword: [{ validator: validatePass2, trigger: 'blur' }],
}

// const submitForm = (formEl: FormInstance | undefined) => {
//   if (!formEl) return
//   formEl.validate((valid) => {
//     if (valid) {
//       console.log('submit!')
//     } else {
//       console.log('error submit!')
//     }
//   })
// }

import { userLoginService, userRegisterService } from '@/api/user.js'
const register = async () => {
  let result = await userRegisterService(registerData.value)
  if (result.code === 0) {
    // alert(result.message ? result.message : '注册成功')
    ElMessage({
      message: 'success: 注册成功',
      type: 'success',
    })
  } else {
    if (result.message === '用户名已存在') {
      ElMessage({
        message: 'warning: 用户名已存在',
        type: 'warning',
        plain: true,
      })
    } else {
      ElMessage({
        message: 'error: 注册失败',
        type: 'error',
        plain: true,
      })
    }
  }
}

const login = async () => {
  let result = await userLoginService(registerData.value)
  if (result.code === 0) {
    ElMessage({
      message: '登录成功',
      type: 'success',
    })
  } else {
    ElMessage({
      message: 'error: 登录失败',
      type: 'error',
      plain: true,
    })
  }
}

const clearUp = () => {
  registerData.value = {
    username: '',
    password: '',
    rePassword: '',
  }
}

// const resetForm = (formEl: FormInstance | undefined) => {
//   if (!formEl) return
//   formEl.resetFields()
// }
</script>


<template>
  <div class="login_register">
    <div class="container right-panel-active">
      <!-- 注册 -->
      <div class="container_form container--signup">
        <!-- <form action="#" class="form" id="form1">
          <h2 class="form_title">Sign In</h2>
          <input type="email" placeholder="Email" class="input" />
          <input type="password" placeholder="Password" class="input" />
          <a href="#" class="link">Forgot your password?</a>
          <button class="btn">Sign In</button>
        </form> -->
        <el-form
          ref="ruleFormRef"
          style="max-width: 600px"
          :model="registerData"
          status-icon
          :rules="rules"
          label-width="auto"
          class="demo-ruleForm form"
          id="form1"
        >
          <el-form-item label="Username" prop="username">
            <el-input v-model="registerData.username" type="text" autocomplete="off" />
          </el-form-item>
          <el-form-item label="Password" prop="password">
            <el-input v-model="registerData.password" type="password" autocomplete="off" />
          </el-form-item>
          <el-form-item label="Confirm" prop="rePassword">
            <el-input v-model="registerData.rePassword" type="password" autocomplete="off" />
          </el-form-item>
          <!-- <el-form-item>
            <el-button type="primary" @click="submitForm(ruleFormRef)"> Submit </el-button>
            <el-button @click="resetForm(ruleFormRef)">Reset</el-button>
          </el-form-item> -->
          <button class="btn" @click="register">Sign Up</button>
        </el-form>
      </div>

      <!-- 登录 -->
      <div class="container_form container--signin">
        <!-- <form action="#" class="form" id="form2">
          <h2 class="form_title">Sign In</h2>
          <input type="email" placeholder="Email" class="input" />
          <input type="password" placeholder="Password" class="input" />
          <a href="#" class="link">Forgot your password?</a>
          <button class="btn">Sign In</button>
        </form> -->
        <el-form
          ref="ruleFormRef"
          style="max-width: 600px"
          :model="registerData"
          status-icon
          :rules="rules"
          label-width="auto"
          class="demo-ruleForm form"
          id="form2"
        >
          <el-form-item label="Username" prop="username">
            <el-input v-model="registerData.username" type="text" autocomplete="off" />
          </el-form-item>
          <el-form-item label="Password" prop="password">
            <el-input v-model="registerData.password" type="password" autocomplete="off" />
          </el-form-item>
          <!-- <el-form-item>
            <el-button type="primary" @click="submitForm(ruleFormRef)"> Submit </el-button>
            <el-button @click="resetForm(ruleFormRef)">Reset</el-button>
          </el-form-item> -->
          <button class="btn" @click="login">Sign In</button>
        </el-form>
      </div>

      <!-- 浮层 -->
      <div class="container_overlay">
        <div class="overlay">
          <div class="overlay_panel overlay--left">
            <button class="btn" id="signIn" @click="clearUp()">Sign In</button>
          </div>
          <div class="overlay_panel overlay--right">
            <button class="btn" id="signUp" @click="clearUp()">Sign Up</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.login_register {
  --white: #e9e9e9;
  --gray: #333;
  --blue: #095c91;
  --blue-r: #315a7491;
  --lightblue: #0393a3;

  --button-radius: 0.7rem;

  --max-width: 758px;
  --max-height: 420px;

  font-size: 16px;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell,
    'Open Sans', 'Helvetica Neue', sans-serif;
}

.login_register {
  align-items: center;
  /* background-color: var(--white);
	background-attachment: fixed;
	background-position: center;
	background-repeat: no-repeat;
	background-size: cover; */
  display: grid;
  height: 100vh;
  place-items: center;
}

.form_title {
  font-weight: 300;
  margin: 0;
  margin-bottom: 1.25rem;
}

.link {
  color: var(--gray);
  font-size: 0.9rem;
  margin: 1.5rem 0;
  text-decoration: none;
}

.container {
  background-color: var(--white);
  border-radius: var(--button-radius);
  box-shadow: 0 0.9rem 1.7rem rgba(0, 0, 0, 0.25), 0 0.7rem 0.7rem rgba(0, 0, 0, 0.22);
  height: var(--max-height);
  max-width: var(--max-width);
  overflow: hidden;
  position: relative;
  width: 100%;
}

.container_form {
  height: 100%;
  position: absolute;
  top: 0;
  transition: all 0.6s ease-in-out;
}

.container--signin {
  left: 0;
  width: 50%;
  z-index: 5;
}

.container.right-panel-active .container--signin {
  transform: translateX(100%);
}

.container--signup {
  left: 0;
  opacity: 0;
  width: 50%;
  z-index: 4;
}

.container.right-panel-active .container--signup {
  -webkit-animation: show 0.6s;
  animation: show 0.6s;
  opacity: 1;
  transform: translateX(100%);
  z-index: 8;
}

.container_overlay {
  height: 100%;
  left: 50%;
  overflow: hidden;
  position: absolute;
  top: 0;
  transition: transform 0.6s ease-in-out;
  width: 50%;
  z-index: 100;
}

.container.right-panel-active .container_overlay {
  transform: translateX(-100%);
}

.overlay {
  background-color: rgba(255, 255, 255, 0.25);
  background-attachment: fixed;
  background-position: center;
  background-repeat: no-repeat;
  background-size: cover;
  height: 100%;
  left: -100%;
  position: relative;
  transform: translateX(0);
  transition: transform 0.6s ease-in-out;
  width: 200%;
}

.container.right-panel-active .overlay {
  transform: translateX(50%);
}

.overlay_panel {
  align-items: center;
  display: flex;
  flex-direction: column;
  height: 100%;
  justify-content: center;
  position: absolute;
  text-align: center;
  top: 0;
  transform: translateX(0);
  transition: transform 0.6s ease-in-out;
  width: 50%;
}

.overlay--left {
  transform: translateX(-20%);
}

.container.right-panel-active .overlay--left {
  transform: translateX(0);
}

.overlay--right {
  right: 0;
  transform: translateX(0);
}

.container.right-panel-active .overlay--right {
  transform: translateX(20%);
}

.btn {
  background-color: var(--blue);
  background-image: linear-gradient(90deg, var(--blue) 0%, var(--lightblue) 74%);
  border-radius: 20px;
  border: 0.2px solid var(--blue-r);
  color: var(--white);
  cursor: pointer;
  font-size: 0.8rem;
  font-weight: bold;
  letter-spacing: 0.1rem;
  padding: 0.9rem 4rem;
  text-transform: uppercase;
  transition: transform 80ms ease-in;
}

.form > .btn {
  margin-top: 1.5rem;
}

.btn:active {
  transform: scale(0.95);
}

.btn:focus {
  outline: none;
}

.form {
  background-color: var(--white);
  display: flex;
  align-items: center;
  justify-content: center;
  flex-direction: column;
  padding: 0 3rem;
  height: 100%;
  text-align: center;
}

.input {
  background-color: #fff;
  border: none;
  padding: 0.9rem 0.9rem;
  margin: 0.5rem 0;
  width: 100%;
}

.error {
  color: red;
  font-size: 12px;
}

@-webkit-keyframes show {
  0%,
  49.99% {
    opacity: 0;
    z-index: 4;
  }

  50%,
  100% {
    opacity: 1;
    z-index: 8;
  }
}

@keyframes show {
  0%,
  49.99% {
    opacity: 0;
    z-index: 4;
  }

  50%,
  100% {
    opacity: 1;
    z-index: 8;
  }
}
</style>
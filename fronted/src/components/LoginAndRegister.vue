<script setup lang="ts">
import { onMounted, ref, reactive } from 'vue'
// import { useRouter } from 'vue-router'
import { type FormInstance, type FormRules, ElMessage } from 'element-plus'

// const router = useRouter()

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
//控制注册与登录表单的显示， 默认显示注册
const isRegister = ref(false)
//定义数据模型
const registerData = ref({
    username: '',
    password: '',
    rePassword: ''
})

//校验密码的函数
const checkRePassword = (rule, value, callback) => {
    if (value === '') {
        callback(new Error('请再次确认密码'))
    } else if (value !== registerData.value.password) {
        callback(new Error('请确保两次输入的密码一样'))
    } else {
        callback()
    }
}

//定义表单校验规则
const rules = {
    username: [
        { required: true, message: '请输入用户名', trigger: 'blur' },
        { min: 5, max: 16, message: '长度为5~16位非空字符', trigger: 'blur' }
    ],
    password: [
        { required: true, message: '请输入密码', trigger: 'blur' },
        { min: 5, max: 16, message: '长度为5~16位非空字符', trigger: 'blur' }
    ],
    rePassword: [
        { required: true, message: '请再次确认密码', trigger: 'blur' },
        { validator: checkRePassword, trigger: 'blur' }
    ],
    email: [
        { required: true, message: '请输入邮箱', trigger: 'blur' },
        { type: 'email', message: '请输入正确的邮箱格式', trigger: 'blur' }
    ]
}

//调用后台接口,完成注册
import { userRegisterService, userLoginService} from '@/api/user.js'
const register = async () => {
    //registerData是一个响应式对象,如果要获取值,需要.value
    let result = await userRegisterService(registerData.value);
    /* if (result.code === 0) {
        //成功了
        alert(result.msg ? result.msg : '注册成功');
    }else{
        //失败了
        alert('注册失败')
    } */
    //alert(result.msg ? result.msg : '注册成功');
    ElMessage.success(result.msg ? result.msg : '注册成功')
}

//绑定数据,复用注册表单的数据模型
//表单数据校验
//登录函数
import {useTokenStore} from '@/stores/token.js'
import {useRouter} from 'vue-router'
const router = useRouter()
const tokenStore = useTokenStore();
const login =async ()=>{
    //调用接口,完成登录
   let result =  await userLoginService(registerData.value);
   /* if(result.code===0){
    alert(result.msg? result.msg : '登录成功')
   }else{
    alert('登录失败')
   } */
   //alert(result.msg? result.msg : '登录成功')
   ElMessage.success(result.msg ? result.msg : '登录成功')
   //把得到的token存储到pinia中
   tokenStore.setToken(result.data)
   //跳转到首页 路由完成跳转
   router.push('/')
}

//定义函数,清空数据模型的数据
const clearRegisterData = ()=>{
    registerData.value={
        username:'',
        password:'',
        rePassword:''
    }
}
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
          <el-form-item label="Email" prop="email">
            <el-input v-model="registerData.email" type="text" autocomplete="off" />
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
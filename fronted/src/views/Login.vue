<script setup>
import { User, Lock } from '@element-plus/icons-vue'
import { ref } from 'vue'
import { ElMessage } from 'element-plus'
import LoginAndRegister from '../components/LoginAndRegister.vue'
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
    <div class="login-view">
      <div class="login-header">
        <img src="@/assets/images/ECNU_logo.png" alt="" />
      </div>
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
  
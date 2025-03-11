<script setup>
import { ref } from "vue";
import useUserInfoStore from "@/stores/userInfo.js";
const userInfoStore = useUserInfoStore();

const userInfo = ref({ ...userInfoStore.info });
const rules = {
  old_pwd: [
    { required: true, message: "请输入旧密码", trigger: "blur" },
    {
      min: 5,
      max: 32,
      message: "密码长度必须在5-32位之间",
      trigger: "blur",
    },
  ],
  new_pwd: [
    { required: true, message: "请输入新密码", trigger: "blur" },
    {
      min: 5,
      max: 32,
      message: "密码长度必须在5-32位之间",
      trigger: "blur",
    },
  ],
  re_pwd: [
    { required: true, message: "请确认新密码", trigger: "blur" },
    {
      min: 5,
      max: 32,
      message: "密码长度必须在5-32位之间",
      trigger: "blur",
    },
    {
      validator: (rule, value, callback) => {
        if (value !== userInfo.value.new_pwd) {
          callback(new Error("两次输入的密码不一致!"));
        } else {
          callback();
        }
      },
      trigger: "blur",
    },
  ],
};

//修改个人信息
import { userInfoUpdateService, userPwdUpdateService } from "@/api/user.js";
import { ElMessage } from "element-plus";
const updateUserPwd = async () => {
  //调用接口
  let result = await userPwdUpdateService(userInfo.value);
  ElMessage.success(result.msg ? result.msg : "修改成功");

  //修改pinia中的个人信息
  userInfoStore.setInfo(userInfo.value);
};
</script>
<template>
  <el-card class="page-container">
    <template #header>
      <div class="header">
        <span>重置密码</span>
      </div>
    </template>
    <el-row>
      <el-col :span="12">
        <el-form
          :model="userInfo"
          :rules="rules"
          label-width="100px"
          size="large"
        >
          <el-form-item label="输入旧密码" prop="old_pwd">
            <el-input v-model="userInfo.old_pwd" type="password"></el-input>
          </el-form-item>
          <el-form-item label="输入新密码" prop="new_pwd">
            <el-input v-model="userInfo.new_pwd" type="password"></el-input>
          </el-form-item>
          <el-form-item label="确认新密码" prop="re_pwd">
            <el-input v-model="userInfo.re_pwd" type="password"></el-input>
          </el-form-item>
          <el-form-item>
            <el-button type="primary" @click="updateUserPwd"
              >提交修改</el-button
            >
          </el-form-item>
        </el-form>
      </el-col>
    </el-row>
  </el-card>
</template>
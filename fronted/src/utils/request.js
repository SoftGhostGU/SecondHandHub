import axios from 'axios';

// const baseURL = "http://localhost:8080";
const baseURL = "/api";
const instance = axios.create({baseURL});

// 添加响应拦截器
instance.interceptors.response.use(
  response => {
    return response.data;
  },
  error => {
    console.log(error);
    return Promise.reject(error);
  }
);

export default instance;

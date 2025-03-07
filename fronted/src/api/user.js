import request from '@/utils/request';

export const userLoginService = (loginData) => {
    // 借助urlSearchParams对象，将对象转换为请求参数
    const params = new URLSearchParams();
    for (const key in loginData) {
        params.append(key, loginData[key]);
    }
    // 使用axios发送post请求
    return request.post('/user/login', params);
}

export const userRegisterService = (registerData) => {
    // 借助urlSearchParams对象，将对象转换为请求参数
    const params = new URLSearchParams();
    for (const key in registerData) {
        params.append(key, registerData[key]);
    }
    // 使用axios发送post请求
    return request.post('/user/register', params);
}
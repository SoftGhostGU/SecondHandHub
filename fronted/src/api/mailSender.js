import request from '@/utils/request.js'
import axios from 'axios'
import { useTokenStore } from '@/stores/token.js'

// 发送邮件
export const sendMail = async (mailData, files) => {
    const formData = new FormData();
    formData.append('to', mailData.to);
    formData.append('subject', mailData.subject);
    formData.append('content', mailData.content);

    // 添加文件
    if (files && files.length > 0) {
        files.forEach((file) => {
            formData.append('file', file);
        });
    }

    return request.post('/mail/send', formData, files);
};
package com.GHOST.service.impl;

import com.GHOST.service.MailService;
import jakarta.mail.Multipart;
import jakarta.mail.internet.MimeMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.List;

@Service
public class MailServiceImpl implements MailService {

    @Autowired
    private JavaMailSender mailSender;

    /**
     *
     * @param to      收件人邮箱
     * @param subject 邮件主题
     * @param content 邮件内容
     */
    @Override
    public void sendMail(String to, String subject, String content, List<MultipartFile> files) {
        try {
//            SimpleMailMessage message = new SimpleMailMessage();
//            message.setFrom("3089308393@qq.com");
//            message.setTo(to);
//            message.setSubject(subject);
//            message.setText(content);
//
//            mailSender.send(message);
//            System.out.println("邮件发送成功！");

            MimeMessage mail = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(mail, true);
            mail.setFrom("3089308393@qq.com");
            helper.setTo(to);
            helper.setSubject(subject);
            helper.setText(content, true);

//            File file = new File("D:\\Project\\常用图片\\driver-1.jpg");
            if (files != null) {
                for (MultipartFile file : files) {
                    helper.addAttachment(file.getOriginalFilename(), file);
                }
            }
            mailSender.send(mail);
            System.out.println("邮件发送成功！");
        } catch (Exception e) {
            System.err.println("邮件发送失败：" + e.getMessage());
            // 还可以使用日志工具将错误记录后续分析
        }
    }
}

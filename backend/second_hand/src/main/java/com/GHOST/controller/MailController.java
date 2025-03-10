package com.GHOST.controller;

import com.GHOST.service.MailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@RestController
@RequestMapping("/mail")
public class MailController {

    @Autowired
    private MailService mailService;

    @PostMapping("/send")
    public String sendMail(@RequestParam("to") String to,
                           @RequestParam("subject") String subject,
                           @RequestParam("content") String content,
                           @RequestParam(value = "file", required = false) List<MultipartFile> files) {
        try {
            mailService.sendMail(to, subject, content, files);
            return "邮件发送成功！";
        } catch (Exception e) {
            e.printStackTrace();
            return "邮件发送失败：" + e.getMessage();
        }
    }
}

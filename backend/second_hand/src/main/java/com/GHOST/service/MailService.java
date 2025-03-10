package com.GHOST.service;

import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface MailService {
    void sendMail(String to, String subject, String content, List<MultipartFile> files);
}

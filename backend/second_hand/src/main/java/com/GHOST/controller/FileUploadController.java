package com.GHOST.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.UUID;

@RestController
public class FileUploadController {

    @Value("${SavePath.ProfilePhoto}")
    private String ProfilePhotoSavePath;   // 图标图片存储路径

    @Value("${SavePath.ProfilePhotoMapper}")
    private String ProfilePhotoMapperPath;   // 图标映射路径

    /**
     * 头像上传
     * @param fileUpload 图片资源
     * @return 图片映射的虚拟访问路径
     */
    @PostMapping("/other/uploadPhoto")
    public String profilePhotoUpload(@RequestParam("file") MultipartFile fileUpload) {
        // 获取文件名
        String fileName = fileUpload.getOriginalFilename();
        // 获取文件后缀名
        String suffixName = fileName.substring(fileName.lastIndexOf("."));
        // 为了避免发生图片替换，这里使用了文件名重新生成
        fileName = UUID.randomUUID() + suffixName;
        try {
            // 将图片保存到文件夹里
            fileUpload.transferTo(new File(ProfilePhotoSavePath + fileName));
            return ProfilePhotoMapperPath + fileName;
        } catch (Exception e) {
            e.printStackTrace();
            return "";
        }
    }
}

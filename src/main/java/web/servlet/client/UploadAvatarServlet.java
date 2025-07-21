package web.servlet.client;

import com.alibaba.fastjson.JSON;
import domain.User;
import service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.*;
import java.util.UUID;
import java.sql.SQLException;

@WebServlet(urlPatterns = "/uploadAvatar.do")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1 MB
    maxFileSize = 1024 * 1024 * 5,   // 5 MB
    maxRequestSize = 1024 * 1024 * 10 // 10 MB
)
public class UploadAvatarServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("application/json;charset=utf-8");
        response.setCharacterEncoding("utf-8");
        
        PrintWriter writer = response.getWriter();
        
        try {
            // 获取当前登录用户
            User currentUser = (User) request.getSession().getAttribute("user");
            if (currentUser == null) {
                UploadResult result = new UploadResult(false, "用户未登录");
                writer.write(JSON.toJSONString(result));
                return;
            }
            
            // 获取上传的文件
            Part filePart = request.getPart("avatar");
            if (filePart == null) {
                UploadResult result = new UploadResult(false, "没有接收到文件");
                writer.write(JSON.toJSONString(result));
                return;
            }
            
            // 获取文件名
            String fileName = getSubmittedFileName(filePart);
            if (fileName == null || fileName.trim().isEmpty()) {
                UploadResult result = new UploadResult(false, "文件名不能为空");
                writer.write(JSON.toJSONString(result));
                return;
            }
            
            // 检查文件类型
            String contentType = filePart.getContentType();
            if (!contentType.startsWith("image/")) {
                UploadResult result = new UploadResult(false, "只能上传图片文件");
                writer.write(JSON.toJSONString(result));
                return;
            }
            
            // 生成唯一文件名
            String fileExtension = fileName.substring(fileName.lastIndexOf("."));
            String uniqueFileName = UUID.randomUUID().toString() + fileExtension;
            
            // 创建上传目录
            String uploadPath = getServletContext().getRealPath("/upload/avatars/");
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            
            // 保存文件
            String filePath = uploadPath + uniqueFileName;
            try (InputStream input = filePart.getInputStream();
                 FileOutputStream output = new FileOutputStream(filePath)) {
                
                byte[] buffer = new byte[1024];
                int length;
                while ((length = input.read(buffer)) > 0) {
                    output.write(buffer, 0, length);
                }
            }
            
            // 更新用户头像信息
            String avatarUrl = "upload/avatars/" + uniqueFileName;
            currentUser.setAvatar(avatarUrl);
            
            try {
                UserService userService = new UserService();
                userService.updateUserAvatar(currentUser.getId(), avatarUrl);
                
                // 更新session中的用户信息
                request.getSession().setAttribute("user", currentUser);
                
                UploadResult result = new UploadResult(true, "头像上传成功", avatarUrl);
                String jsonResponse = JSON.toJSONString(result);
                System.out.println("成功响应JSON: " + jsonResponse);
                writer.write(jsonResponse);
            } catch (SQLException e) {
                // 如果数据库字段不存在，只保存文件，不更新数据库
                if (e.getMessage().contains("Unknown column 'avatar'")) {
                    UploadResult result = new UploadResult(true, "头像上传成功（数据库字段未更新）", avatarUrl);
                    String jsonResponse = JSON.toJSONString(result);
                    System.out.println("数据库字段不存在响应JSON: " + jsonResponse);
                    writer.write(jsonResponse);
                } else {
                    UploadResult result = new UploadResult(false, "数据库更新失败：" + e.getMessage());
                    String jsonResponse = JSON.toJSONString(result);
                    System.out.println("数据库错误响应JSON: " + jsonResponse);
                    writer.write(jsonResponse);
                }
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            UploadResult result = new UploadResult(false, "上传失败：" + e.getMessage());
            String jsonResponse = JSON.toJSONString(result);
            System.out.println("异常响应JSON: " + jsonResponse);
            writer.write(jsonResponse);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
    
    private String getSubmittedFileName(Part part) {
        String header = part.getHeader("content-disposition");
        if (header == null) return null;
        for (String headerPart : header.split(";")) {
            if (headerPart.trim().startsWith("filename")) {
                return headerPart.substring(headerPart.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }
    
    // 上传结果类
    public static class UploadResult {
        private boolean success;
        private String message;
        private String avatarUrl;
        
        public UploadResult(boolean success, String message) {
            this.success = success;
            this.message = message;
        }
        
        public UploadResult(boolean success, String message, String avatarUrl) {
            this.success = success;
            this.message = message;
            this.avatarUrl = avatarUrl;
        }
        
        public boolean isSuccess() {
            return success;
        }
        
        public void setSuccess(boolean success) {
            this.success = success;
        }
        
        public String getMessage() {
            return message;
        }
        
        public void setMessage(String message) {
            this.message = message;
        }
        
        public String getAvatarUrl() {
            return avatarUrl;
        }
        
        public void setAvatarUrl(String avatarUrl) {
            this.avatarUrl = avatarUrl;
        }
    }
} 
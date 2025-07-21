package web.servlet.management;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import dao.ClickTimeDao;
import domain.ClickTime;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/aiAnalysis")
public class AiAnalysisServlet extends HttpServlet {

    private static final String API_URL = "https://tbai.xin/v1/chat/completions";
    private static final String API_KEY = "sk-PllvAxCs88ZOrohvWKhBDBmqSJJEuy40B0JMUPIz7wymxvh9";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/management/aiAnalysis.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/plain");

        String userInput = request.getParameter("prompt");
        String aiResponse;

        try {
            // 1. 获取数据库中的电影点击数据
            ClickTimeDao clickTimeDao = new ClickTimeDao();
            List<ClickTime> topTenMovies = clickTimeDao.getTopTenClickTimes();

            // 2. 将数据格式化为字符串
            StringBuilder contextBuilder = new StringBuilder();
            contextBuilder.append("这是当前数据库中点击量最高的10部电影的数据：\n");
            for (ClickTime movie : topTenMovies) {
                contextBuilder.append("- 电影名: ").append(movie.getMovieName())
                              .append(", 点击次数: ").append(movie.getNumber()).append("\n");
            }
            contextBuilder.append("\n请基于以上数据，并结合你的知识，回答我的问题。");

            // 3. 调用API
            aiResponse = callLargeModelApi(userInput, contextBuilder.toString());

        } catch (SQLException e) {
            e.printStackTrace();
            aiResponse = "查询数据库时出错，请检查后台日志。";
        } catch (Exception e) {
            e.printStackTrace();
            aiResponse = "调用API时出错，请检查后台日志。";
        }

        try (PrintWriter out = response.getWriter()) {
            out.print(aiResponse);
        }
    }

    private String callLargeModelApi(String userPrompt, String systemContext) throws IOException {
        try (CloseableHttpClient httpClient = HttpClients.createDefault()) {
            HttpPost httpPost = new HttpPost(API_URL);

            // 设置请求头
            httpPost.setHeader("Content-Type", "application/json");
            httpPost.setHeader("Authorization", "Bearer " + API_KEY);

            // 创建请求体
            JsonObject jsonPayload = new JsonObject();
            jsonPayload.addProperty("model", "gpt-4.1-mini"); // 或者您需要的其他模型

            // 构建 messages 数组
            JsonArray messagesArray = new JsonArray();

            // 1. 添加系统上下文消息
            JsonObject systemMessage = new JsonObject();
            systemMessage.addProperty("role", "system");
            systemMessage.addProperty("content", systemContext);
            messagesArray.add(systemMessage);

            // 2. 添加用户提问消息
            JsonObject userMessage = new JsonObject();
            userMessage.addProperty("role", "user");
            userMessage.addProperty("content", userPrompt);
            messagesArray.add(userMessage);

            jsonPayload.add("messages", messagesArray);
            jsonPayload.addProperty("stream", false);


            StringEntity entity = new StringEntity(jsonPayload.toString(), StandardCharsets.UTF_8);
            httpPost.setEntity(entity);

            try (CloseableHttpResponse response = httpClient.execute(httpPost)) {
                int statusCode = response.getStatusLine().getStatusCode();
                HttpEntity responseEntity = response.getEntity();
                String responseString = EntityUtils.toString(responseEntity, StandardCharsets.UTF_8);

                if (statusCode >= 200 && statusCode < 300) {
                    // 解析JSON并获取回复
                    JsonObject jsonResponse = new Gson().fromJson(responseString, JsonObject.class);
                    if (jsonResponse.has("choices")) {
                        return jsonResponse.getAsJsonArray("choices")
                                .get(0).getAsJsonObject()
                                .getAsJsonObject("message")
                                .get("content").getAsString();
                    } else {
                        System.err.println("API Error: Unexpected JSON structure: " + responseString);
                        return "API返回了意料之外的数据结构。";
                    }
                } else {
                    // 记录错误信息
                    System.err.println("API Error: HTTP " + statusCode + " - " + responseString);
                    return "调用API时出错，HTTP状态码：" + statusCode;
                }
            }
        }
    }
}
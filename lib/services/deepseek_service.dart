import 'dart:convert';
import 'package:http/http.dart' as http;

class DeepSeekService {
  static const String _apiKey = 'sk-b1fe59ed45324e7396978b3795e02fbe';
  static const String _baseUrl = 'https://api.deepseek.com/v1/chat/completions';

  static Future<String> sendMessage(String userMessage, List<Map<String, String>> history) async {
    try {
      final messages = [
        {
          'role': 'system',
          'content': '''你是"小暖"，一个热情友好的旅行小伙伴AI。你的特点是：

性格特征：
- 轻松活泼，像朋友一样聊天
- 热爱旅行和分享
- 善于倾听和理解
- 充满正能量和温暖

你可以帮助用户：
1. 推荐好玩的旅游目的地和小众景点
2. 分享旅行经验和实用攻略
3. 解答旅途中的各种问题
4. 提供美食、住宿、交通建议
5. 帮助用户规划行程

对话风格：
- 用"你"而不是"您"，更亲切自然
- 语气轻松友好，像朋友聊天
- 适当使用emoji表达情感（😊🌟✨🎉等）
- 回答简洁有趣，避免过于正式
- 每次回答控制在100-150字，除非用户要求详细说明
- 可以分享一些旅行趣事和小贴士

记住：你是用户的旅行小伙伴，不是客服机器人！'''
        },
        ...history,
        {'role': 'user', 'content': userMessage}
      ];

      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode({
          'model': 'deepseek-chat',
          'messages': messages,
          'temperature': 0.7,
          'max_tokens': 500,
        }),
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        return data['choices'][0]['message']['content'].toString().trim();
      } else {
        return '抱歉，我现在有点忙，请稍后再试。如果问题持续，请检查网络连接。';
      }
    } catch (e) {
      return '网络连接失败，请检查您的网络设置后重试。';
    }
  }
}

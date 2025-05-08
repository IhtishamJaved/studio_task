import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:studio_task/global/constants/app_constants.dart';

class OpenAIService {
  Future<String> isArtPromptAPI(String prompt) async {
    try {
      final res = await http.post(
        Uri.parse('https://openrouter.ai/api/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $openAIAPIKey',
        },
        body: jsonEncode({
          'model': 'meta-llama/llama-3.1-70b-instruct:floor',
          "messages": [
            {
              "role": "user",
              'content':
                  'Does this message want to create task, update task, delete task or anything similar? $prompt . Simply answer with a create, update, or delete response like this task: create . Also separate out title, description and date time from sentence and if description is missing give any suggestion according to title and return fields with key value only like title, description and datetime and give description without adding missing or suggestion word just like this description: Lets discuss about on going project or any random description and date time should be in this format month-year-day hour:time give correct format as define and time should be in 24 hour format if year missing then add current year like 2025, use same format as define and also suggest image network image url according to title',
            },
          ],
        }),
      );
      if (res.statusCode == 200 || res.statusCode == 201) {
        String content =
            jsonDecode(res.body)['choices'][0]['message']['content'];
        log(content);
        return content;
      }
      return 'An internal error occurred';
    } catch (e) {
      return e.toString();
    }
  }
}

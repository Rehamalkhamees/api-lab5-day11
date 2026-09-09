import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;


class GeminiApi {
   Future <String>sendRequest(String message) async {
    String link = "https://generativelanguage.googleapis.com/v1beta/interactions";
    var uri = Uri.parse(link);


    Map<String, String>? header = {
      "x-goog-api-key": dotenv.get('api-key'),
    };

    Map<String, String> body = {
      "model": "gemini-3.5-flash-lite",
      "input": message,
    };


    var request = await http.post(uri, headers: header, body: jsonEncode(body));
    print(request.statusCode);

    var response = request.body;
    var responseBody = jsonDecode(response);

    return responseBody["steps"][1]["content"][0]["text"].toString();
  }

}
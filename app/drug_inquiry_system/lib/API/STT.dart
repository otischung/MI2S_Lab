import 'dart:convert';
import 'package:http/http.dart' as http;

class STTClient {
  final String host = "140.116.245.149";
  final String token = "2023@asr@general";
  final int port = 2802;

  Future<String> askForService(String base64String, String selectedModel) async {
    final response = await http.post(
      Uri.parse('http://140.116.245.149:2802/asr'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        "audio_data": base64String,
        "token": "2023@asr@pharmacy",
        "source": "A",
        "model_name": selectedModel,
      }),
    );

    if (response.statusCode == 200) {
      print(response.statusCode.toString());
      Map<String, dynamic> resultMap = jsonDecode(response.body);
      String sentence = resultMap['words'][0];
      return sentence;
    } else {
      print(response.statusCode.toString());
      throw Exception('Failed to request server.');
    }
  }
}
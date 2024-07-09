import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Dio dio = Dio();
String api = DotEnv().get('apiKey');
Future<String> getAi(String text) async {
  final res = await dio.post(
    "",
    data: {
      "prompt": {"text": text},
      "temperature": 1.0,
      "candidateCount": 3
    },
  );
  print(res.data);
  return res.data["candidates"][0]["output"].toString();
}

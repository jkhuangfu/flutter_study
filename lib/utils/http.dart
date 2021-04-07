import 'package:dio/dio.dart';

getResponse(String method, String url, Map<String, dynamic> params) async {
  final dio = Dio();
  switch (method) {
    case 'get':
      Response response = await dio.get(url, queryParameters: params);
      print(response);
      return response.data;
      break;
    case 'post':
      Response response = await dio.post(url, data: params);
      return response.data;
      break;
  }
}

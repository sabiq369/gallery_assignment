import 'package:dio/dio.dart';
import 'package:gallery/utils/api.dart';

class Services {
  final Dio _dio = Dio();

  getGallery() async {
    try {
      var response = await _dio.get(Api.baseUrl, queryParameters: {
        "key": Api.apiKey,
        "q": "yellow+flowers",
        "image_type": "photo",
        "pretty": "true",
      });
      print('||||||||| Response |||||||||||');
      print(response.statusCode);
      print(response.data);
      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {
      print('|||||| Error ||||||||||');
      print(e.toString());
    }
  }
}

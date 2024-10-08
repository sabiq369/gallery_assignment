import 'package:dio/dio.dart';
import 'package:gallery/utils/api.dart';
import 'package:gallery/views/gallery/view/gallery.dart';
import 'package:get/get.dart';

class Services {
  final Dio _dio = Dio();

  getGallery({required String searchText, required int page}) async {
    try {
      var response = await _dio.get(Api.baseUrl, queryParameters: {
        "key": Api.apiKey,
        "q": searchText,
        "image_type": "photo",
        "page": page,
      });
      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {
      Get.offAll(() => Gallery());
      throw (e.toString());
    }
  }
}

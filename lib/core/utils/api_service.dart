import 'package:dio/dio.dart';

class Apiservice {
  Dio dio = Dio();
  Future<Response> post(
      {required  body,
      required String url,
      Map<String,String>?headers,
      required String token,
      String? contenttype}) async {
    var response = await dio.post(url,
        data: body,
        options: Options(
            contentType: contenttype,
            headers:headers?? {'Authorization': 'Bearer $token'}));
    return response;
  }
}

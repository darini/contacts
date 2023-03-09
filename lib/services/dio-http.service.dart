import 'package:contacts/services/ihttp.service.dart';
import 'package:dio/dio.dart';

class DioHttp extends IHttpService {
  final dio = Dio();

  @override
  Future<Response> get(String url, Object? data) async {
    return await dio.get(url, data: data);
  }

  @override
  Future<Response> post(String url, Object data) async {
    return await dio.post(url, data: data);
  }

  @override
  Future<Response> put(String url, Object data) async {
    return await dio.put(url, data: data);
  }
}

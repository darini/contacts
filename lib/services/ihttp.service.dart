import 'package:dio/dio.dart';

abstract class IHttpService {
  Future get(String url, Object? data);
  Future post(String url, Object data);
  Future put(String url, Object data);
}

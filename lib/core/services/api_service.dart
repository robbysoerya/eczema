import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:eczema/core/core.dart';
import 'package:eczema/core/data/models/guess_nationality_model.dart';

class ApiService with DioMixin implements Dio {
  bool _validateStatus(int? status) {
    if (status != null) {
      if (status == 401) {
        return false;
      }
    }
    return true;
  }

  @override
  BaseOptions get options => BaseOptions(
        baseUrl: 'https://api.nationalize.io',
        contentType: ContentType.json.mimeType,
        responseType: ResponseType.json,
        receiveDataWhenStatusError: false,
        validateStatus: _validateStatus,
      );

  @override
  HttpClientAdapter get httpClientAdapter => DefaultHttpClientAdapter();

  @override
  Interceptors get interceptors => Interceptors()
    ..add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      request: true,
      requestHeader: true,
      responseHeader: true,
    ));

  Future<GuessNationalityModel> getNationality() async {
    final resp = await get('/', queryParameters: {'name': 'robby'});
    if (resp.statusCode == 200) {
      return GuessNationalityModel.fromJson(resp.data);
    } else {
      throw ServerException();
    }
  }
}

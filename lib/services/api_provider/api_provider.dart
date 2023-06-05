import 'dart:developer';

import 'package:assignment_flutter/services/api_constant.dart';
import 'package:assignment_flutter/services/models/Movie_detail_model.dart';
import 'package:assignment_flutter/services/models/movie_model.dart';
import 'package:dio/dio.dart';

import '../dio_exeptions.dart';


class AuthApiProvider {

  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
    ),
  )..interceptors.add(Logging());


  Future<List<MovieModel>?> getAllMovies() async {
    try {
      Response response = await _dio.get(ApiConstants.popularMovies,queryParameters: {"api_key":ApiConstants.apiKey});
      var list = (response.data["results"] as List)
          .map((e) => MovieModel.fromJson(e))
          .toList();
      return list;
    } on DioError catch (err) {
      if (err.response != null) {
        final errorMessage = DioException.fromDioError(err).toString();
        throw errorMessage;
      } else {
        log('Error sending request!');
        log(err.message??"");
      }
    }
    return null;
  }


  Future<MovieDetailModel?> getMovieDetail({required num id}) async {
    try {
      Response response = await _dio.get("${ApiConstants.movieDetails}$id",
          queryParameters: {"api_key":ApiConstants.apiKey});
      var dataResponse = MovieDetailModel.fromJson(response.data);
      return dataResponse;
    } on DioError catch (err) {
      if (err.response != null) {
        final errorMessage = DioException.fromDioError(err).toString();
        throw errorMessage;
      } else {
        log('Error sending request!');
        log(err.message??"");
      }
    }
    return null;
  }


}

class Logging extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log('REQUEST[${options.method}] => PATH: ${options.path}');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log(
      'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
    );
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    log(
      'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
    );
    return super.onError(err, handler);
  }
}
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recything_mobile/bloc/auth/auth_cubit.dart';
import 'package:recything_mobile/constants/constans.dart';
import 'package:recything_mobile/services/shared_pref_service.dart';
import 'package:flutter/material.dart';

abstract class BaseService {
  final Dio _dio = Dio();

  Future<Response> request(
    BuildContext? context,
    String endpoint, {
    RequestType requestType = RequestType.get,
    dynamic data,
    Map<String, dynamic>? params,
    Options? options,
  }) async {
    try {
      _dio.interceptors.add(CustomInterceptors());
      switch (requestType) {
        case RequestType.get:
          {
            return await _dio.get(endpoint,
                queryParameters: params, options: options);
          }
        case RequestType.post:
          {
            return await _dio.post(endpoint, data: data, options: options);
          }
        case RequestType.update:
          {
            return await _dio.put(endpoint, data: data, options: options);
          }
        case RequestType.patch:
          {
            return await _dio.patch(endpoint, data: data, options: options);
          }
        case RequestType.delete:
          {
            return await _dio.delete(endpoint, data: data, options: options);
          }
      }
    } on DioException catch (e) {
      if (e.error is SocketException ||
          e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw 'Periksa internet anda';
      } else if (e.response?.data != null) {
        final responseMsg = e.response!.data?['message'];
        if (responseMsg == 'missing or malformed jwt' ||
            responseMsg == 'invalid or expired jwt') {
          //masukin authbloc logoutnya
          context!.read<AuthCubit>().loggedOut();
          Navigator.pushNamed(context, '/login');
          throw 'Silahkan login kembali';
        }
        throw responseMsg;
      } else if (e.message!.isNotEmpty) {
        throw e.message ?? "";
      } else {
        throw 'Terjadi Kesalahan, silahkan coba lagi nanti';
      }
    } catch (exeption) {
      rethrow;
    }
  }
}

enum RequestType { get, post, update, delete, patch }

class CustomInterceptors extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.connectTimeout = const Duration(seconds: 20);
    options.receiveTimeout = const Duration(seconds: 20);
    options.baseUrl = baseUrl;
    String? token = await SharedPreferenceService.getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    return super.onRequest(options, handler);
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

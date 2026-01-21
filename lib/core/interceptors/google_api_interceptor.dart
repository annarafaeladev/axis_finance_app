import 'package:axis_finance_app/core/auth/access_token_provider.dart';
import 'package:axis_finance_app/core/auth/session_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class GoogleApiInterceptor extends Interceptor {
  final GlobalKey<NavigatorState> navigatorKey;
  final AccessTokenProvider tokenProvider;
  final SessionManager sessionManager;

  GoogleApiInterceptor({
    required this.navigatorKey,
    required this.tokenProvider,
    required this.sessionManager,
  });

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await tokenProvider.getAccessToken();

    options.headers['Authorization'] = 'Bearer $token';

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 &&
        !sessionManager.isRedirecting &&
        navigatorKey.currentState != null) {
      sessionManager.lockRedirect();

      await tokenProvider.clear();

      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        '/login',
        (_) => false,
      );
    }

    handler.next(err);
  }
}

import 'package:axis_finance_app/core/auth/access_token_provider.dart';
import 'package:axis_finance_app/core/auth/session_manager.dart';
import 'package:axis_finance_app/core/interceptors/google_api_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:axis_finance_app/core/di/finance_di.dart';
import 'package:get_it/get_it.dart';
import '../storage/local_storage.dart';
import 'auth_di.dart';
import 'package:flutter/material.dart';

final getIt = GetIt.instance;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> setupDependencies() async {
  // Infra global
  getIt.registerLazySingleton<LocalStorage>(() => LocalStorage());

  // Features
  registerAuth();
  registerFinance();

  // Drive API
  getIt.registerLazySingleton<Dio>(
    () {
      final dio = Dio(
        BaseOptions(baseUrl: 'https://www.googleapis.com'),
      );

      addInterceptors(dio);
      return dio;
    },
    instanceName: 'driveDio',
  );

  // Sheets API
  getIt.registerLazySingleton<Dio>(
    () {
      final dio = Dio(
        BaseOptions(baseUrl: 'https://sheets.googleapis.com'),
      );

      addInterceptors(dio);
      return dio;
    },
    instanceName: 'sheetsDio',
  );
}

void addInterceptors(Dio dio) {
  dio.interceptors.add(
    GoogleApiInterceptor(
      navigatorKey: navigatorKey,
      tokenProvider: getIt<AccessTokenProvider>(),
      sessionManager: getIt<SessionManager>(),
    ),
  );
}
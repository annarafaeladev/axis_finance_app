import 'package:axis_finance_app/core/auth/session_manager.dart';
import 'package:axis_finance_app/core/interceptors/google_api_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:axis_finance_app/core/auth/access_token_provider.dart';
import 'package:axis_finance_app/core/di/injector.dart';
import 'package:axis_finance_app/core/storage/local_storage.dart';
import 'package:axis_finance_app/features/finance/data/datasources/google_sheets_api.dart';

void registerInterceptorGoogleApis() {
  // Drive API
  getIt.registerLazySingleton<Dio>(() {
    final dio = Dio(BaseOptions(baseUrl: 'https://www.googleapis.com'));

    addInterceptors(dio);
    return dio;
  }, instanceName: 'driveDio');

  // Sheets API
  getIt.registerLazySingleton<Dio>(() {
    final dio = Dio(BaseOptions(baseUrl: 'https://sheets.googleapis.com'));

    addInterceptors(dio);
    return dio;
  }, instanceName: 'sheetsDio');
  
  getIt.registerLazySingleton<GoogleSheetsApi>(
    () => GoogleSheetsApi(
      driveDio: getIt<Dio>(instanceName: 'driveDio'),
      sheetsDio: getIt<Dio>(instanceName: 'sheetsDio'),
      localStorage: getIt<LocalStorage>(),
    ),
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

import 'package:flutter_application_1/core/auth/access_token_provider.dart';
import 'package:flutter_application_1/core/auth/user_access_token_provider.dart';
import 'package:flutter_application_1/core/di/injector.dart';
import 'package:flutter_application_1/core/storage/local_storage.dart';
import 'package:flutter_application_1/features/auth/data/datasource/google_auth_datasource.dart';
import 'package:flutter_application_1/features/auth/data/respositories/auth_repository_impl.dart';
import 'package:flutter_application_1/features/auth/data/respositories/user_repository_impl.dart';
import 'package:flutter_application_1/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_application_1/features/auth/domain/repositories/user_repository.dart';
import 'package:flutter_application_1/features/auth/domain/usecases/login_with_google.dart';
import 'package:flutter_application_1/features/auth/domain/usecases/logout_with_google.dart';
import 'package:flutter_application_1/features/auth/domain/usecases/user_data.dart';
import 'package:flutter_application_1/features/auth/presentation/auth_controller.dart';
import 'package:flutter_application_1/features/auth/presentation/user_controller.dart';

void registerAuth() {
  // Datasource
  getIt.registerLazySingleton(() => GoogleAuthDataSource());

  // Repository
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      getIt<GoogleAuthDataSource>(),
      getIt<LocalStorage>(),
    ),
  );

  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(getIt<LocalStorage>()),
  );

  // UseCases
  getIt.registerLazySingleton<LoginWithGoogle>(
    () => LoginWithGoogle(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<LogoutWithGoogle>(
    () => LogoutWithGoogle(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<UserData>(
    () => UserData(getIt<UserRepository>()),
  );

//AccessTokenProvider
  getIt.registerLazySingleton<AccessTokenProvider>(
    () => UserAccessTokenProvider(getIt<UserData>()),
  );
  
  // Controller
  getIt.registerFactory(
    () => AuthController(getIt<LoginWithGoogle>(), getIt<LogoutWithGoogle>()),
  );

  getIt.registerFactory(() => UserController(getIt<UserData>()));
}

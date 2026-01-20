import 'package:axis_finance_app/core/auth/access_token_provider.dart';
import 'package:axis_finance_app/core/auth/user_access_token_provider.dart';
import 'package:axis_finance_app/core/di/injector.dart';
import 'package:axis_finance_app/core/storage/local_storage.dart';
import 'package:axis_finance_app/features/auth/data/datasource/google_auth_datasource.dart';
import 'package:axis_finance_app/features/auth/data/respositories/auth_repository_impl.dart';
import 'package:axis_finance_app/features/auth/data/respositories/user_repository_impl.dart';
import 'package:axis_finance_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:axis_finance_app/features/auth/domain/repositories/user_repository.dart';
import 'package:axis_finance_app/features/auth/domain/usecases/login_with_google.dart';
import 'package:axis_finance_app/features/auth/domain/usecases/logout_with_google.dart';
import 'package:axis_finance_app/features/auth/domain/usecases/user_data.dart';
import 'package:axis_finance_app/features/auth/presentation/auth_controller.dart';
import 'package:axis_finance_app/features/auth/presentation/user_controller.dart';

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

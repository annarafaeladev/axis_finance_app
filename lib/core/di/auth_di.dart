import 'package:axis_finance_app/core/auth/access_token_provider.dart';
import 'package:axis_finance_app/core/auth/session_manager.dart';
import 'package:axis_finance_app/core/auth/user_access_token_provider.dart';
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
import 'package:google_sign_in/google_sign_in.dart';
import 'injector.dart';

void registerAuth() {
  getIt.registerLazySingleton<GoogleSignIn>(
    () => GoogleSignIn(
      scopes: [
        'email',
        'profile',
        'https://www.googleapis.com/auth/spreadsheets',
        'https://www.googleapis.com/auth/drive.file',
      ],
    ),
  );

  // Datasource
  getIt.registerLazySingleton<GoogleAuthDataSource>(
    () => GoogleAuthDataSource(getIt<GoogleSignIn>()),
  );

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
    () => UserAccessTokenProvider(getIt<LocalStorage>()),
  );

  getIt.registerLazySingleton<SessionManager>(
  () => SessionManager(),
);

  // Controller
  getIt.registerFactory(
    () => AuthController(getIt<LoginWithGoogle>(), getIt<LogoutWithGoogle>()),
  );

  getIt.registerFactory(() => UserController(getIt<UserData>()));
}

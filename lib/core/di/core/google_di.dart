import 'package:axis_finance_app/core/di/injector.dart';
import 'package:google_sign_in/google_sign_in.dart';

void registerGoogleSignin() {
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
}

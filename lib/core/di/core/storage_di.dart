import 'package:axis_finance_app/core/di/injector.dart';
import 'package:axis_finance_app/core/storage/local_storage.dart';

void registerLocalStorage() {
  getIt.registerLazySingleton<LocalStorage>(() => LocalStorage());
}

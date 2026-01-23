import 'package:axis_finance_app/core/di/finance/finance_entry_di.dart';
import 'package:axis_finance_app/core/di/core/google_di.dart';
import 'package:axis_finance_app/core/di/core/interceptor_di.dart';
import 'package:axis_finance_app/core/di/finance/finance_di.dart';
import 'package:axis_finance_app/core/di/core/storage_di.dart';
import 'package:axis_finance_app/core/di/finance/finance_expense_di.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'auth/auth_di.dart';

final getIt = GetIt.instance;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> setupDependencies() async {
  registerLocalStorage();  
  registerGoogleSignin();
  
  registerAuth();
  registerInterceptorGoogleApis();

  registerFinance();
  registerFinanceEntry();
  registerFinanceExpense();

}

import 'package:axis_finance_app/core/auth/access_token_provider.dart';
import 'package:axis_finance_app/core/storage/local_storage.dart';
import 'package:axis_finance_app/core/storage/storage_key.dart';
class UserAccessTokenProvider implements AccessTokenProvider {
  final LocalStorage storage;

  UserAccessTokenProvider(this.storage);

  @override
  Future<String?> getAccessToken() async {
    final userMap = await storage.getMap(StorageKey.user);
    return userMap?[StorageKeyUser.accessToken.key];
  }

  @override
  Future<void> clear() async {
    await storage.delete(StorageKey.user);
    await storage.delete(StorageKey.spreadsheetId);
  }
}

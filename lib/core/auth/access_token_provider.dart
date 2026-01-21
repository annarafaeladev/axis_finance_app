abstract class AccessTokenProvider {
  Future<String?> getAccessToken();
  Future<void> clear();
}

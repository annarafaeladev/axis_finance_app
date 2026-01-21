class SessionManager {
  bool _redirecting = false;

  bool get isRedirecting => _redirecting;

  void lockRedirect() {
    _redirecting = true;
  }

  void unlockRedirect() {
    _redirecting = false;
  }
}

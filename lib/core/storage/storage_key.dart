enum StorageKey { user, spreadsheetId }

enum StorageKeyUser { id, name, email, photo, accessToken }

extension StorageKeyUserX on StorageKeyUser {
  String get key => '${StorageKey.user.key}_$name';
}

extension StorageKeyX on StorageKey {
  String get key => 'axis_finance_$name';
}

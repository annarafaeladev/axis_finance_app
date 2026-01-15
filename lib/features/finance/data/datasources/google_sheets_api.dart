import 'package:dio/dio.dart';
import 'package:flutter_application_1/core/auth/access_token_provider.dart';

const String driveApiBase = 'https://www.googleapis.com/drive/v3/files';
const String sheetsApiBase = 'https://sheets.googleapis.com/v4/spreadsheets';
const String spreadsheetName = 'Finance_Dashboard_50-30-20_arbds';

class GoogleSheetsApi {
  final Dio dio;
  final AccessTokenProvider tokenProvider;

  String? _spreadsheetId;

  GoogleSheetsApi(this.dio, this.tokenProvider);

  Future<Options> _options() async {
    final token = await tokenProvider.getAccessToken();

    return Options(
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
  }

  // 🔍 Procura ou cria a planilha
  Future<String> findOrCreateSpreadsheet() async {
    final options = await _options();

    // 1️⃣ Buscar se já existe
    final searchResponse = await dio.get(
      driveApiBase,
      options: options,
      queryParameters: {
        'q':
            "name='$spreadsheetName' and mimeType='application/vnd.google-apps.spreadsheet' and trashed=false",
        'fields': 'files(id,name)',
      },
    );

    final files = searchResponse.data['files'] as List<dynamic>;

    if (files.isNotEmpty) {
      _spreadsheetId = files.first['id'];
      return _spreadsheetId!;
    }

    // 2️⃣ Se não existe → criar
    final createResponse = await dio.post(
      sheetsApiBase,
      options: options,
      data: {
        'properties': {
          'title': spreadsheetName,
        },
      },
    );

    _spreadsheetId = createResponse.data['spreadsheetId'];

    return _spreadsheetId!;
  }
}

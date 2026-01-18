import 'package:dio/dio.dart';
import 'package:flutter_application_1/core/auth/access_token_provider.dart';
import 'package:flutter_application_1/features/finance/domain/entities/SetupSheet.dart';
import 'package:flutter_application_1/features/finance/domain/entities/cartao.dart';
import 'package:flutter_application_1/features/finance/domain/entities/configuracao.dart';
import 'package:flutter_application_1/features/finance/domain/entities/entrada.dart';
import 'package:flutter_application_1/features/finance/domain/entities/fixa.dart';
import 'package:flutter_application_1/features/finance/domain/entities/investimento.dart';
import 'package:flutter_application_1/features/finance/domain/entities/reserva.dart';
import 'package:flutter_application_1/features/finance/domain/entities/saida.dart';

const String driveApiBase = 'https://www.googleapis.com/drive/v3/files';
const String sheetsApiBase = 'https://sheets.googleapis.com/v4/spreadsheets';

const String spreadsheetName = 'Finance_Dashboard_50-30-20_arbds';

final Map<String, Setupsheet> setupSheet = {
  'Entradas': Setupsheet(header: Entrada.header),
  'Saidas': Setupsheet(header: Saida.header),
  'Fixas': Setupsheet(header: Fixa.header),
  'Cartao': Setupsheet(header: Cartao.header),
  'Investimentos': Setupsheet(header: Investimento.header),
  'Reserva': Setupsheet(header: Reserva.header),
  'Configuracoes': Setupsheet(
    header: Configuracao.header,
    defaultRows: Configuracao.defaultConfig,
  ),
};

final List<String> sheetTabs = setupSheet.keys.toList();

final List<String> allSheetTabs = ['Dashboard', ...sheetTabs, 'Releatorios'];

class GoogleSheetsApi {
  final Dio dio;
  final AccessTokenProvider tokenProvider;

  String? _spreadsheetId;

  GoogleSheetsApi(this.dio, this.tokenProvider);

  Future<Options> _headers() async {
    final token = await tokenProvider.getAccessToken();

    return Options(
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
  }

  Future<String> findOrCreateSpreadsheet() async {
    final options = await _headers();

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

    final createResponse = await dio.post(
      sheetsApiBase,
      options: options,
      data: {
        'properties': {'title': spreadsheetName},
        'sheets': allSheetTabs
            .map(
              (title) => {
                'properties': {'title': title},
              },
            )
            .toList(),
      },
    );

    _spreadsheetId = createResponse.data['spreadsheetId'];

    await _initializeSheets();

    return _spreadsheetId!;
  }

  Future<void> _initializeSheets() async {
    if (_spreadsheetId == null) return;

    final options = await _headers();

    final List<Map<String, dynamic>> requests = [];

    setupSheet.forEach((sheetName, sheet) {
      requests.add({
        'range': '$sheetName!A1',
        'values': [sheet.header],
      });

      if (sheet.defaultRows != null) {
        requests.add({
          'range': '$sheetName!A2',
          'values': sheet.defaultRows,
        });
      }
    });

    await dio.post(
      '$sheetsApiBase/$_spreadsheetId/values:batchUpdate',
      options: options,
      data: {'valueInputOption': 'RAW', 'data': requests},
    );
  }

  Future<List<List<dynamic>>> getSheetData(String sheetName) async {
    if (_spreadsheetId == null) {
      await findOrCreateSpreadsheet();
    }

    final options = await _headers();

    try {
      final response = await dio.get(
        '$sheetsApiBase/$_spreadsheetId/values/$sheetName',
        options: options,
      );

      return (response.data['values'] as List?)
              ?.map((e) => List<dynamic>.from(e))
              .toList() ??
          [];
    } catch (e) {
      return [];
    }
  }

  Future<void> appendRow(String sheetName, List<dynamic> values) async {
    if (_spreadsheetId == null) {
      await findOrCreateSpreadsheet();
    }

    final options = await _headers();

    await dio.post(
      '$sheetsApiBase/$_spreadsheetId/values/$sheetName:append',
      options: options,
      queryParameters: {
        'valueInputOption': 'RAW',
        'insertDataOption': 'INSERT_ROWS',
      },
      data: {
        'values': [values],
      },
    );
  }

  Future<void> updateRow(
    String sheetName,
    int rowIndex,
    List<dynamic> values,
  ) async {
    if (_spreadsheetId == null) {
      await findOrCreateSpreadsheet();
    }

    final options = await _headers();

    await dio.put(
      '$sheetsApiBase/$_spreadsheetId/values/$sheetName!A$rowIndex',
      options: options,
      queryParameters: {'valueInputOption': 'RAW'},
      data: {
        'values': [values],
      },
    );
  }

  Future<void> deleteRow(String sheetName, int rowIndex) async {
    if (_spreadsheetId == null) {
      await findOrCreateSpreadsheet();
    }

    final options = await _headers();

    final metaResponse = await dio.get(
      '$sheetsApiBase/$_spreadsheetId',
      options: options,
    );

    final sheets = metaResponse.data['sheets'] as List<dynamic>;

    final sheet = sheets.firstWhere(
      (s) => s['properties']['title'] == sheetName,
      orElse: () => null,
    );

    if (sheet == null) return;

    final sheetId = sheet['properties']['sheetId'];

    await dio.post(
      '$sheetsApiBase/$_spreadsheetId:batchUpdate',
      options: options,
      data: {
        'requests': [
          {
            'deleteDimension': {
              'range': {
                'sheetId': sheetId,
                'dimension': 'ROWS',
                'startIndex': rowIndex,
                'endIndex': rowIndex + 1,
              },
            },
          },
        ],
      },
    );
  }

  Future<Map<String, String>> getSettings() async {
    final data = await getSheetData('Configuracoes');

    final Map<String, String> settings = {};

    for (int i = 1; i < data.length; i++) {
      if (data[i].length >= 2) {
        settings[data[i][0].toString()] = data[i][1].toString();
      }
    }

    return settings;
  }

  Future<void> updateSettings(Map<String, String> settings) async {
    if (_spreadsheetId == null) {
      await findOrCreateSpreadsheet();
    }

    final options = await _headers();

    final values = [
      ['Chave', 'Valor'],
      ...settings.entries.map((e) => [e.key, e.value]),
    ];

    await dio.put(
      '$sheetsApiBase/$_spreadsheetId/values/Configuracoes!A1',
      options: options,
      queryParameters: {'valueInputOption': 'RAW'},
      data: {'values': values},
    );
  }
}

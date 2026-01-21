import 'package:axis_finance_app/core/storage/storage_key.dart';
import 'package:dio/dio.dart';
import 'package:axis_finance_app/core/auth/access_token_provider.dart';
import 'package:axis_finance_app/core/storage/local_storage.dart';
import 'package:axis_finance_app/features/finance/domain/entities/SetupSheet.dart';
import 'package:axis_finance_app/features/finance/domain/entities/cartao.dart';
import 'package:axis_finance_app/features/finance/domain/entities/configuracao.dart';
import 'package:axis_finance_app/features/finance/domain/entities/entrada.dart';
import 'package:axis_finance_app/features/finance/domain/entities/fixa.dart';
import 'package:axis_finance_app/features/finance/domain/entities/investimento.dart';
import 'package:axis_finance_app/features/finance/domain/entities/reserva.dart';
import 'package:axis_finance_app/features/finance/domain/entities/saida.dart';

const String driveResource = '/drive/v3/files';
const String sheetsResource = '/v4/spreadsheets';

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
  final Dio driveDio;
  final Dio sheetsDio;
  final AccessTokenProvider tokenProvider;
  final LocalStorage localStorage;

  GoogleSheetsApi({
    required this.driveDio,
    required this.sheetsDio,
    required this.tokenProvider,
    required this.localStorage,
  });

  Future<String?> _loadSpreadsheetId() async {
    return await localStorage.getString(StorageKey.spreadsheetId);
  }

  Future<void> _saveSpreadsheetId(String? id) async {
    if (id != null) {
      await localStorage.saveString(StorageKey.spreadsheetId, id);
    }
  }

  Future<String> findOrCreateSpreadsheet() async {
    String? spreadsheetId = await _loadSpreadsheetId();

    if (spreadsheetId != null) {
      return spreadsheetId;
    }

    final searchResponse = await driveDio.get(
      driveResource,
      queryParameters: {
        'q':
            "name='$spreadsheetName' and mimeType='application/vnd.google-apps.spreadsheet' and trashed=false",
        'fields': 'files(id,name)',
      },
    );

    final files = searchResponse.data['files'] as List<dynamic>;

    if (files.isNotEmpty) {
      await _saveSpreadsheetId(files.first['id']);
      spreadsheetId = files.first['id'];
      return files.first['id'] ?? '';
    }

    final createResponse = await sheetsDio.post(
      sheetsResource,
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

    spreadsheetId = createResponse.data['spreadsheetId'];

    await _initializeSheets(spreadsheetId);

    return spreadsheetId ?? '';
  }

  Future<void> _initializeSheets(String? spreadsheetId) async {
    if (spreadsheetId == null) return;


    final List<Map<String, dynamic>> requests = [];

    setupSheet.forEach((sheetName, sheet) {
      requests.add({
        'range': '$sheetName!A1',
        'values': [sheet.header],
      });

      if (sheet.defaultRows != null) {
        requests.add({'range': '$sheetName!A2', 'values': sheet.defaultRows});
      }
    });

    await sheetsDio.post(
      '$sheetsResource/$spreadsheetId/values:batchUpdate',
      data: {'valueInputOption': 'RAW', 'data': requests},
    );

    await _saveSpreadsheetId(spreadsheetId);
  }

  Future<List<List<dynamic>>> getSheetData(String sheetName) async {
    String spreadsheetId = await findOrCreateSpreadsheet();

    try {
      final response = await sheetsDio.get(
        '$sheetsResource/$spreadsheetId/values/$sheetName',
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
    String spreadsheetId = await findOrCreateSpreadsheet();


    await sheetsDio.post(
      '$sheetsResource/$spreadsheetId/values/$sheetName:append',
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
    String spreadsheetId = await findOrCreateSpreadsheet();


    await sheetsDio.put(
      '$sheetsResource/$spreadsheetId/values/$sheetName!A$rowIndex',
      queryParameters: {'valueInputOption': 'RAW'},
      data: {
        'values': [values],
      },
    );
  }

  Future<void> deleteRow(String sheetName, int rowIndex) async {
    String spreadsheetId = await findOrCreateSpreadsheet();


    final metaResponse = await sheetsDio.get(
      '$sheetsResource/$spreadsheetId',
    );

    final sheets = metaResponse.data['sheets'] as List<dynamic>;

    final sheet = sheets.firstWhere(
      (s) => s['properties']['title'] == sheetName,
      orElse: () => null,
    );

    if (sheet == null) return;

    final sheetId = sheet['properties']['sheetId'];

    await sheetsDio.post(
      '$sheetsResource/$spreadsheetId:batchUpdate',
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
    String spreadsheetId = await findOrCreateSpreadsheet();

    final values = [
      ['Chave', 'Valor'],
      ...settings.entries.map((e) => [e.key, e.value]),
    ];

    await sheetsDio.put(
      '$sheetsResource/$spreadsheetId/values/Configuracoes!A1',
      queryParameters: {'valueInputOption': 'RAW'},
      data: {'values': values},
    );
  }
}

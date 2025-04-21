import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  static final EnvConfig _instance = EnvConfig._internal();

  factory EnvConfig() {
    return _instance;
  }

  EnvConfig._internal();

  late String viaCepBaseUrl;
  late String back4AppBaseUrl;
  late String back4AppAppId;
  late String back4AppClientKey;
  late String back4AppRestApiKey;
  late String back4AppMasterKey;

  Future<void> loadEnv() async {
    await dotenv.load(fileName: "assets/.env");

    viaCepBaseUrl = dotenv.env['VIA_CEP_BASE_URL'] ?? 'URL não encontrada';
    back4AppBaseUrl = dotenv.env['BACK4APP_BASE_URL'] ?? 'URL não encontrada';
    back4AppAppId = dotenv.env['BACK4APP_APP_ID'] ?? 'ID não encontrado';
    back4AppClientKey =
        dotenv.env['BACK4APP_CLIENT_KEY'] ?? 'Chave não encontrada';
    back4AppRestApiKey =
        dotenv.env['BACK4APP_REST_API_KEY'] ?? 'Chave não encontrada';
    back4AppMasterKey =
        dotenv.env['BACK4APP_MASTER_KEY'] ?? 'Chave não encontrada';
  }
}

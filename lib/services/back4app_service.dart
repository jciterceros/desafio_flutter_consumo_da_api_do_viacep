import 'package:desafio_flutter_consumo_da_api_do_viacep/config/env_config.dart';
import 'package:dio/dio.dart';

class Back4AppService {
  final Dio _dio = Dio();

  Future<List<Map<String, dynamic>>> fetchCeps() async {
    try {
      final response = await _dio.get(
        '${EnvConfig().back4AppBaseUrl}/classes/CEP',
        options: Options(
          headers: {
            'X-Parse-Application-Id': EnvConfig().back4AppAppId,
            'X-Parse-REST-API-Key': EnvConfig().back4AppRestApiKey,
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        return List<Map<String, dynamic>>.from(data['results']);
      } else {
        throw Exception(
          'Erro ao buscar dados do Back4App: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Erro ao buscar dados do Back4App: $e');
    }
  }

  Future<void> saveCep(Map<String, dynamic> cepData) async {
    try {
      final response = await _dio.post(
        '${EnvConfig().back4AppBaseUrl}/classes/CEP',
        data: cepData,
        options: Options(
          headers: {
            'X-Parse-Application-Id': EnvConfig().back4AppAppId,
            'X-Parse-REST-API-Key': EnvConfig().back4AppRestApiKey,
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode != 201) {
        throw Exception(
          'Erro ao salvar o CEP no Back4App: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Erro ao salvar o CEP no Back4App: $e');
    }
  }

  Future<void> updateCep(String objectId, Map<String, dynamic> cepData) async {
    try {
      final response = await _dio.put(
        '${EnvConfig().back4AppBaseUrl}/classes/CEP/$objectId',
        data: cepData,
        options: Options(
          headers: {
            'X-Parse-Application-Id': EnvConfig().back4AppAppId,
            'X-Parse-REST-API-Key': EnvConfig().back4AppRestApiKey,
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode != 200) {
        throw Exception(
          'Erro ao atualizar o CEP no Back4App: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Erro ao atualizar o CEP no Back4App: $e');
    }
  }

  Future<void> deleteCep(String objectId) async {
    try {
      final response = await _dio.delete(
        '${EnvConfig().back4AppBaseUrl}/classes/CEP/$objectId',
        options: Options(
          headers: {
            'X-Parse-Application-Id': EnvConfig().back4AppAppId,
            'X-Parse-REST-API-Key': EnvConfig().back4AppRestApiKey,
          },
        ),
      );

      if (response.statusCode != 200) {
        throw Exception(
          'Erro ao excluir o CEP no Back4App: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Erro ao excluir o CEP no Back4App: $e');
    }
  }
}

import 'package:desafio_flutter_consumo_da_api_do_viacep/models/viaCep_model.dart';
import 'package:dio/dio.dart';
import 'package:desafio_flutter_consumo_da_api_do_viacep/config/env_config.dart';

class CepService {
  // static const String viaCepBaseUrl = 'https://viacep.com.br/ws';
  static String viaCepBaseUrl = EnvConfig().viaCepBaseUrl;

  final Dio _dio = Dio();

  Future<viaCepModel?> fetchCep(String cep) async {
    try {
      final response = await _dio.get('$viaCepBaseUrl/$cep/json/');

      if ((response.statusCode == 200) &&
          (response.data.toString().contains("erro") == false)) {
        return viaCepModel.fromJson(response.data);
      }
    } catch (e) {
      throw Exception('Failed to load CEP data');
    }
    return null;
  }
}

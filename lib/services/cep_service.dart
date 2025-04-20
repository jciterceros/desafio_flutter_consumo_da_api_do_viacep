import 'package:desafio_flutter_consumo_da_api_do_viacep/models/viaCep_model.dart';
import 'package:dio/dio.dart';

class CepService {
  static const String viaCepBaseUrl = 'https://viacep.com.br/ws';

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
  }
}

import 'package:desafio_flutter_consumo_da_api_do_viacep/config/env_config.dart';
import 'package:desafio_flutter_consumo_da_api_do_viacep/pages/home_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await EnvConfig().loadEnv();
    print("Arquivo .env carregado com sucesso");
  } catch (e) {
    print("Erro ao carregar o arquivo .env: $e");
    return;
  }

  // Imprime todas as variáveis carregadas
  print("Variáveis carregadas do .env:");
  dotenv.env.forEach((key, value) {
    print("$key: $value");
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Consumindo ViaCEP API',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

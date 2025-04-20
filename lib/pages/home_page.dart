import 'package:desafio_flutter_consumo_da_api_do_viacep/services/cep_service.dart';
import 'package:flutter/material.dart';
import 'package:desafio_flutter_consumo_da_api_do_viacep/models/viaCep_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _cepController = TextEditingController();
  List<Map<String, dynamic>> _ceps = [];
  final CepService _cepService = CepService();
  bool _isLoading = false;

  @override
  void dispose() {
    _cepController.dispose();
    super.dispose();
  }

  Future<void> _consultarCep() async {
    setState(() {
      _isLoading = true;
    });

    final String cep = _cepController.text.trim();
    if (cep.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, insira um CEP válido.')),
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }

    try {
      final viaCepModel? viaCep = await _cepService.fetchCep(cep);
      if (viaCep != null) {
        setState(() {
          _ceps.add({
            'cep': viaCep.cep,
            'logradouro': viaCep.logradouro,
            'bairro': viaCep.bairro,
          });
          _cepController.clear();
        });
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('CEP não encontrado.')));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Erro ao consultar o CEP.')));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _confirmarExclusao(int index) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Confirmar Exclusão'),
            content: const Text('Deseja realmente excluir este CEP?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _ceps.removeAt(index);
                  });
                  Navigator.pop(context);
                },
                child: const Text('Excluir'),
              ),
            ],
          ),
    );
  }

  void _confirmarAlteracao(int index) async {
    final String novoCep = _cepController.text.trim();

    if (novoCep.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, insira um CEP válido.')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final viaCepModel? viaCep = await _cepService.fetchCep(novoCep);
      if (viaCep != null) {
        setState(() {
          _ceps[index] = {
            'cep': viaCep.cep,
            'logradouro': viaCep.logradouro,
            'bairro': viaCep.bairro,
          };
          _cepController.clear();
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('CEP alterado com sucesso!')),
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('CEP não encontrado.')));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Erro ao consultar o CEP.')));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de CEPs')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _cepController,
              decoration: const InputDecoration(labelText: 'Digite o CEP'),
              keyboardType: TextInputType.number,
            ),
          ),
          ElevatedButton(
            onPressed: _isLoading ? null : _consultarCep,
            child:
                _isLoading
                    ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                    : const Text('Consultar e Cadastrar'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _ceps.length,
              itemBuilder: (context, index) {
                final cep = _ceps[index];
                return ListTile(
                  title: Text(cep['cep']),
                  subtitle: Text('${cep['logradouro']}, ${cep['bairro']}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder:
                                (context) => AlertDialog(
                                  title: const Text('Alterar CEP'),
                                  content: TextField(
                                    controller: _cepController,
                                    decoration: const InputDecoration(
                                      labelText: 'Novo CEP',
                                    ),
                                    keyboardType: TextInputType.number,
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('Cancelar'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        _confirmarAlteracao(index);
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Alterar'),
                                    ),
                                  ],
                                ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _confirmarExclusao(index),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

# Desafio Flutter Consumo da API do ViaCEP

Este é um projeto Flutter desenvolvido como parte de um desafio para consumir a API do ViaCEP. O objetivo é permitir que os usuários consultem, cadastrem, alterem e excluam CEPs utilizando uma interface intuitiva.

## Funcionalidades

- **Consulta de CEP**: Permite consultar informações de um CEP utilizando a API do ViaCEP.
- **Cadastro de CEP**: Salva os dados do CEP consultado no backend (Back4App).
- **Alteração de CEP**: Atualiza os dados de um CEP já cadastrado.
- **Exclusão de CEP**: Remove um CEP cadastrado do backend.
- **Sincronização com o Backend**: Garante que os dados exibidos estejam sempre atualizados com o backend.

## Tecnologias Utilizadas

- **Flutter**: Framework para desenvolvimento multiplataforma.
- **Dart**: Linguagem de programação utilizada no Flutter.
- **Back4App**: Plataforma backend para armazenamento e gerenciamento de dados.
- **ViaCEP API**: Serviço para consulta de informações de CEP.

## Estrutura do Projeto

```plaintext
.
├── lib/
│   ├── models/
│   │   └── viaCep_model.dart
│   ├── pages/
│   │   └── home_page.dart
│   └── services/
│       ├── back4app_service.dart
│       └── cep_service.dart
├── assets/
│   └── .env
├── android/
├── ios/
├── web/
├── test/
├── pubspec.yaml
└── README.md
```
## Dependências Utilizadas

As dependências estão listadas no arquivo `pubspec.yaml`. Algumas das principais incluem:

- `http`: Para realizar requisições HTTP à API do ViaCEP.
- `flutter_test`: Para testes unitários e de widget.
- `provider`: Para gerenciamento de estado.
- `flutter_dotenv`: Para carregar variáveis de ambiente do arquivo .env.

## Pré-requisitos

- Flutter SDK instalado.
- Editor de código como VS Code ou Android Studio.
- Dispositivo ou emulador para execução do aplicativo.
- Um arquivo .env configurado com as credenciais do Back4App.

## Estrutura de Dados

A resposta da API ViaCEP é um JSON com o seguinte formato:

```json
{
  "cep": "01001-000",
  "logradouro": "Praça da Sé",
  "complemento": "lado ímpar",
  "bairro": "Sé",
  "localidade": "São Paulo",
  "uf": "SP",
  "ibge": "3550308",
  "gia": "1004",
  "ddd": "11",
  "siafi": "7107"
}
```

Esses dados são mapeados para o modelo `viaCepModel` no aplicativo.

## Melhorias Futuras

- Implementar tratamento de erros mais robusto.
- Adicionar testes unitários e de integração.
- Melhorar a interface do usuário com feedback visual.
- Permitir busca por endereço além do CEP.
- Adicionar suporte para internacionalização (i18n).
- Implementar autenticação para acesso ao backend.

## Exemplo de Uso

1. Execute o aplicativo.
2. Insira um CEP válido no campo de busca.
3. Pressione o botão de busca.
4. As informações do endereço correspondente serão exibidas.
5. Salve, edite ou exclua o CEP utilizando as opções disponíveis.

## Contribuição

Contribuições são bem-vindas! Siga os passos abaixo para contribuir:

1. Faça um fork do repositório.
2. Crie uma branch para sua feature ou correção: git checkout -b minha-feature.
3. Faça commit das suas alterações: git commit -m 'Minha nova feature'.
4. Envie para o repositório remoto: git push origin minha-feature.
5. Abra um pull request.

## Licença

Este projeto está licenciado sob a [MIT License](LICENSE).

## Como Executar o Projeto

1. Clone o repositório:

```bash
git clone https://github.com/jciterceros/desafio_flutter_consumo_da_api_do_viacep.git
cd desafio_flutter_consumo_da_api_do_viacep
```

2. Instale as dependências:

```bash
flutter pub get
```

3. Execute o aplicativo:

```bash
flutter run
```
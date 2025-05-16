# Easy OS Mobile

Easy OS Mobile é um aplicativo Flutter projetado para gerenciar ordens de serviço de forma eficiente. Ele oferece funcionalidades como criação, edição e exclusão de ordens, além de integração com APIs para autenticação e gerenciamento de clientes.

## Funcionalidades

- Cadastro, edição e exclusão de ordens de serviço
- Autenticação de usuários
- Gerenciamento de clientes
- Integração com APIs externas
- Interface intuitiva e responsiva
- Suporte multiplataforma (Android, iOS, Web, Desktop)

## Estrutura do Projeto

```
.
├── android/           # Projeto Android nativo
├── assets/            # Imagens, fontes e outros recursos
├── ios/               # Projeto iOS nativo
├── lib/               # Código fonte principal do Flutter
├── linux/             # Projeto Linux
├── macos/             # Projeto macOS
├── test/              # Testes automatizados
├── web/               # Projeto Web
├── windows/           # Projeto Windows
├── pubspec.yaml       # Dependências e configurações do projeto
└── README.md          # Documentação principal
```

## Tecnologias Utilizadas

- [Flutter](https://flutter.dev/) (Dart)
- Integração com APIs REST
- Gerenciamento de estado (ex: Provider, Riverpod ou Bloc)
- SQLite ou outro banco local (se aplicável)

## Configuração do Ambiente

1. Instale o [Flutter](https://docs.flutter.dev/get-started/install) em sua máquina.
2. Clone este repositório:
   ```bash
   git clone https://github.com/iru-Y/os_mananger-mobile
   cd easy_os_mobile
   ```
3. Instale as dependências:
   ```bash
   flutter pub get
   ```
4. Configure um emulador ou conecte um dispositivo físico.

## Execução do Projeto

Para rodar o aplicativo em modo debug:

```bash
flutter run
```

Para rodar os testes automatizados:

```bash
flutter test
```

## Contribuição

Contribuições são bem-vindas! Siga os passos abaixo para contribuir:

1. Faça um fork do repositório.
2. Crie uma branch para sua feature ou correção:
   ```bash
   git checkout -b minha-feature
   ```
3. Faça commit das suas alterações:
   ```bash
   git commit -m "Minha nova feature"
   ```
4. Envie para o repositório remoto:
   ```bash
   git push origin minha-feature
   ```
5. Abra um Pull Request.

## Licença

Este projeto está licenciado sob a licença MIT. Consulte o arquivo `LICENSE` para mais detalhes.
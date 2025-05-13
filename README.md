# Easy OS Mobile

Easy OS Mobile é um aplicativo Flutter projetado para gerenciar ordens de serviço de forma eficiente. Ele oferece funcionalidades como criação, edição e exclusão de ordens, além de integração com APIs para autenticação e gerenciamento de clientes.

## Funcionalidades

- **Login Seguro**: Autenticação com suporte a armazenamento seguro de tokens.
- **Gerenciamento de Ordens**: Criação, edição e exclusão de ordens de serviço.
- **Integração com API**: Comunicação com APIs REST para manipulação de dados de clientes e ordens.
- **Interface Personalizada**: Uso de fontes customizadas e cores personalizadas para uma experiência visual aprimorada.

## Estrutura do Projeto

A estrutura principal do projeto é organizada da seguinte forma:

```
lib/
├── colors/                # Definições de cores personalizadas
├── domain/                # Lógica de domínio e APIs
├── login/                 # Tela de login
├── orders/                # Funcionalidades relacionadas a ordens de serviço
├── routes/                # Definições de rotas
├── text/                  # Componentes de texto customizados
├── utils/                 # Utilitários e constantes
├── widgets/               # Widgets reutilizáveis
```

## Tecnologias Utilizadas

- **Flutter**: Framework principal para desenvolvimento do aplicativo.
- **Dart**: Linguagem de programação utilizada no Flutter.
- **HTTP**: Para comunicação com APIs REST.
- **Flutter Secure Storage**: Para armazenamento seguro de tokens.
- **Mask Text Input Formatter**: Para formatação de entradas de texto.

## Configuração do Ambiente

1. Certifique-se de ter o Flutter instalado. Consulte a [documentação oficial](https://docs.flutter.dev/get-started/install) para instruções.
2. Clone este repositório:
   ```bash
   git clone https://github.com/seu-usuario/easy_os_mobile.git
   ```
3. Instale as dependências:
   ```bash
   flutter pub get
   ```
4. Configure as variáveis de ambiente no arquivo `.env` (exemplo fornecido no projeto).

## Execução do Projeto

Para rodar o projeto, utilize o comando:
```bash
flutter run
```

Certifique-se de que um dispositivo ou emulador esteja configurado e conectado.

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
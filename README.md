# Gabba Rastro Log 🐾

O sistema de rastreamento e logging oficial do ecossistema **Gabba**. Desenvolvido para padronizar a visualização de eventos, depuração de erros e monitoramento de fluxo nos projetos Flutter.

## 🚀 Por que o Rastro?

Em vez de configurar o pacote `logger` manualmente em cada projeto, o **Rastro** encapsula uma configuração opinada, garantindo que todos os apps (Launcher, Escriba, etc.) tenham a mesma identidade visual no console e o mesmo comportamento de segurança.

- **Zero Configuração:** Importe e use.
- **Segurança:** Filtros automáticos que impedem logs em modo Release.
- **Identidade:** Emojis e cores padronizados para cada nível de severidade.

## 📦 Instalação

Como este é um pacote privado, adicione-o ao seu `pubspec.yaml` apontando para o repositório Git:

```yaml
dependencies:
  gabba_rastro_log:
    git:
      url: https://github.com/GabbaMendonca/gabba_rastro_log.git
      ref: main
```

## 🛠 Como usar

```dart
import 'package:gabba_rastro_log/gabba_rastro_log.dart';

// Log de depuração simples (Debug)
Rastro.d("Configurações de layout carregadas.");

// Log de informação importante (Info)
Rastro.i("Usuário autenticado com sucesso.");

// Log de aviso (Warning)
Rastro.w("Conexão instável, tentando reconectar...");

// Log de erro (Error) com captura de StackTrace
try {
  metodoQueFalha();
} catch (e, s) {
  Rastro.e("Falha crítica ao carregar base de dados", error: e, stack: s);
}
```

## 🎨 Níveis de Log Padronizados

| **Nível**   | **Emoji** | **Uso Recomendado**                           |
| ----------- | --------- | --------------------------------------------- |
| **Debug**   | 🐛        | Ciclo de vida, variáveis e estados internos.  |
| **Info**    | 💡        | Fluxos de sucesso, navegação e marcos do app. |
| **Warning** | ⚠️        | Comportamentos inesperados, mas não fatais.   |
| **Error**   | ⛔         | Exceções, falhas de API e erros críticos.     |

## 🛡 Segurança

O Rastro utiliza um DevelopmentFilter interno. Isso garante que:

- Debug Mode: Todos os logs aparecem formatados no terminal.

- Release/Profile Mode: O console permanece limpo, protegendo dados sensíveis e economizando processamento do dispositivo.

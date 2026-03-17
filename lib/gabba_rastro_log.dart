import 'package:logger/logger.dart';

/// Rastro: O sistema de log oficial do ecossistema Gabba.
class Rastro {
  static final _logger = Logger(
    printer: PrettyPrinter(
      // número de chamadas de método a serem exibidas
      methodCount: 2,
      // número de chamadas de método se for erro
      errorMethodCount: 8,
      // largura da linha
      lineLength: 120,
      // cores nas mensagens
      colors: true,
      // emojis para cada nível
      printEmojis: true,
      // se deve imprimir o timestamp
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
    // Filtro para garantir que logs de debug não apareçam em produção
    // filter: ProductionFilter(),
    filter: DevelopmentFilter(),
  );

  /// Log para informações rápidas de depuração.
  static void d(Object? message) => _logger.d(message);

  /// Log para eventos importantes no fluxo do app.
  static void i(Object? message) => _logger.i(message);

  /// Log para alertas que não interrompem o app, mas exigem atenção.
  static void w(Object? message) => _logger.w(message);

  /// Log para erros críticos. Captura o StackTrace automaticamente se não fornecido.
  static void e(Object? message, {Object? error, StackTrace? stack}) {
    _logger.e(message, error: error, stackTrace: stack);

    // Sugestão de provocação: Enviar para um serviço externo se não for Debug
    // if (kReleaseMode && error != null) {
    //   // _enviarParaServidor(message, error, stack);
    // }
  }

  static void error(Object? message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);

    // Sugestão de provocação: Enviar para um serviço externo se não for Debug
    // if (kReleaseMode && error != null) {
    //   // _enviarParaServidor(message, error, stack);
    // }
  }
}

// Filtro customizado para garantir que logs NUNCA saiam em Release (segurança)
// class DevelopmentFilter extends LogFilter {
//   @override
//   bool shouldLog(LogEvent event) {
//     return kDebugMode; // Só loga se o app estiver rodando em debug
//   }
// }

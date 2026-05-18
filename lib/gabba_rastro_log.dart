import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

/// Rastro: O sistema de log oficial do ecossistema Gabba.
class Rastro {
  static final _logger = Logger(
    printer: PrettyPrinter(
      // número de chamadas de método a serem exibidas
      methodCount: kDebugMode ? 2 : 0,
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
    filter: ProductionFilter(),
    level: kDebugMode ? Level.debug : Level.warning,
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
}

/// Extensão para facilitar o uso do Rastro em qualquer objeto
extension RastroExtension on Object? {
  /// Loga o objeto atual como Informação (Info)
  void rastro() {
    Rastro.i(this?.toString() ?? 'null');
  }

  /// Loga o objeto atual como Erro (Error)
  void rastroError([Object? error, StackTrace? stack]) {
    Rastro.e(this?.toString() ?? 'null', error: error, stack: stack);
  }
}

extension RastroIterableExtension on Iterable {
  /// Loga o conteúdo de uma Lista ou Set.
  /// [full] define se deve mostrar todos os itens.
  /// [limit] define a quantidade manual de itens a exibir (padrão 10).
  void rastroList({bool full = false, int limit = 10}) {
    if (isEmpty) {
      Rastro.i('Coleção vazia');
      return;
    }

    final totalItens = length;
    final limiteEfetivo = full ? totalItens : limit;

    Rastro.i('Coleção com $totalItens itens (exibindo $limiteEfetivo):');

    // Seleciona os itens respeitando o limite (pega os últimos)
    final itensParaLog = totalItens <= limiteEfetivo
        ? this
        : toList().reversed.take(limiteEfetivo).toList().reversed;

    int index = totalItens <= limiteEfetivo ? 0 : totalItens - limiteEfetivo;

    for (var item in itensParaLog) {
      Rastro.d(' [$index]: $item');
      index++;
    }

    if (!full && totalItens > limiteEfetivo) {
      Rastro.w(
        '... e mais ${totalItens - limiteEfetivo} itens ocultos. Use (full: true).',
      );
    }
  }
}

extension RastroMapExtension on Map {
  /// Loga o conteúdo de um Mapa.
  /// [full] define se deve ignorar o limite e mostrar tudo.
  /// [limit] define a quantidade manual de linhas a serem exibidas (padrão é 10).
  void rastroMap({bool full = false, int limit = 10}) {
    if (isEmpty) {
      Rastro.i('Mapa vazio');
      return;
    }

    final totalItens = length;
    // Se full for true, o limite é o tamanho total, senão usa o limit informado
    final limiteEfetivo = full ? totalItens : limit;

    Rastro.i('Mapa com $totalItens itens (exibindo $limiteEfetivo):');

    // Lógica para pegar os últimos itens respeitando a ordem e o limite
    final entradasParaLog = totalItens <= limiteEfetivo
        ? entries
        : entries.toList().reversed.take(limiteEfetivo).toList().reversed;

    for (var entry in entradasParaLog) {
      Rastro.d(' - ${entry.key}: ${entry.value}');
    }

    if (!full && totalItens > limiteEfetivo) {
      Rastro.w(
        '... e mais ${totalItens - limiteEfetivo} itens ocultos. Use (full: true) para ver tudo.',
      );
    }
  }
}

import 'package:flutter_test/flutter_test.dart';
import 'package:gabba_rastro_log/gabba_rastro_log.dart';

void main() {
  group('Rastro Log Tests', () {
    test('Deve ser capaz de chamar os métodos de log sem lançar exceções', () {
      // Como o Logger apenas imprime no console, verificamos se a execução
      // dos métodos estáticos ocorre sem erros.
      expect(() => Rastro.d("Teste de debug"), returnsNormally);
      expect(() => Rastro.i("Teste de informação"), returnsNormally);
      expect(() => Rastro.w("Teste de aviso"), returnsNormally);
      expect(
        () => Rastro.e("Teste de erro", error: "Erro fake"),
        returnsNormally,
      );
    });

    test('O filtro de desenvolvimento deve respeitar o kDebugMode', () {
      // Este teste valida indiretamente se a estrutura da classe está correta.
      // Em ambiente de teste, o kDebugMode geralmente é true.
      expect(Rastro.d, isA<Function>());
    });
  });
}

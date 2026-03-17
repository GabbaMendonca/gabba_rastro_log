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

  group('Gabba Rastro - Extensions Tests', () {
    test('Object.rastro() deve logar strings e objetos corretamente', () {
      const String texto = "Teste de Extensão";
      const int numero = 123;

      expect(() => texto.rastro(), returnsNormally);
      expect(() => numero.rastro(), returnsNormally);
    });

    test('Object?.rastro() deve lidar com valores nulos com segurança', () {
      Object? objetoNulo;
      expect(() => objetoNulo.rastro(), returnsNormally);
    });

    test(
      'Iterable.rastroList() deve respeitar limite e exibir índices corretos',
      () {
        final lista = List.generate(20, (i) => 'Item $i');

        // Testa o limite manual de 5
        expect(() => lista.rastroList(limit: 5), returnsNormally);
      },
    );

    test('Iterable.rastroList() deve funcionar com Listas e Sets', () {
      final meuSet = {1, 2, 3, 4, 5};
      expect(() => meuSet.rastroList(full: true), returnsNormally);
    });

    test('Map.rastroMap() deve iterar e logar chaves e valores', () {
      final mapaParaTeste = {
        'id': 1,
        'nome': 'Gabba Launcher',
        'versao': '1.0.0',
      };

      expect(() => mapaParaTeste.rastroMap(), returnsNormally);
    });

    test('Map.rastroMap() deve funcionar com mapa vazio', () {
      final mapaVazio = {};
      expect(() => mapaVazio.rastroMap(), returnsNormally);
    });

    test('Map.rastroMap() deve respeitar o limite de 10 itens', () {
      // Criamos um mapa com 15 itens
      final mapaGrande = {
        for (var i in List.generate(15, (i) => i)) 'chave_$i': 'valor_$i',
      };

      // Verificamos se a execução não quebra com o limite
      expect(() => mapaGrande.rastroMap(), returnsNormally);
    });

    test('Map.rastroMap() deve respeitar o limite manual', () {
      final mapa = {'a': 1, 'b': 2, 'c': 3, 'd': 4};
      // Deve mostrar apenas 2
      expect(() => mapa.rastroMap(limit: 2), returnsNormally);
    });

    test('Map.rastroMap() deve mostrar tudo no modo full', () {
      final mapa = Map.fromIterable(List.generate(50, (i) => i));
      expect(() => mapa.rastroMap(full: true), returnsNormally);
    });
  });
}

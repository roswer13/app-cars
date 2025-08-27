import 'package:app_cars_front/core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Debouncer', () {
    test('should execute action after debounce duration', () async {
      final debouncer = Debouncer(milliseconds: 100);
      bool called = false;

      debouncer.run(() {
        called = true;
      });

      await Future.delayed(Duration(milliseconds: 150));
      expect(called, isTrue);
    });

    test(
      'should not execute action if run is called again before duration',
      () async {
        final debouncer = Debouncer(milliseconds: 100);
        bool called = false;

        debouncer.run(() {
          called = true;
        });

        // Call run again before the timer completes
        await Future.delayed(Duration(milliseconds: 50));
        debouncer.run(() {
          called = true;
        });

        await Future.delayed(Duration(milliseconds: 60));
        // Still not called because timer was reset
        expect(called, isFalse);

        await Future.delayed(Duration(milliseconds: 60));
        // Now it should be called
        expect(called, isTrue);
      },
    );

    test('should cancel timer on dispose', () async {
      final debouncer = Debouncer(milliseconds: 100);
      bool called = false;

      debouncer.run(() {
        called = true;
      });

      debouncer.dispose();

      await Future.delayed(Duration(milliseconds: 150));
      expect(called, isFalse);
    });
  });
}

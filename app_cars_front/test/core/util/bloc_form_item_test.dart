import 'package:app_cars_front/core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BlocFormItem', () {
    test('should create with default values', () {
      const item = BlocFormItem();
      expect(item.value, '');
      expect(item.error, isNull);
    });

    test('should create with provided values', () {
      const item = BlocFormItem(value: 'test', error: 'error');
      expect(item.value, 'test');
      expect(item.error, 'error');
    });

    test('copyWith should update value', () {
      const item = BlocFormItem(value: 'old', error: 'err');
      final updated = item.copyWith(value: 'new');
      expect(updated.value, 'new');
      expect(updated.error, 'err');
    });

    test('copyWith should update error', () {
      const item = BlocFormItem(value: 'val', error: 'oldError');
      final updated = item.copyWith(error: 'newError');
      expect(updated.value, 'val');
      expect(updated.error, 'newError');
    });

    test('copyWith should keep original values if not provided', () {
      const item = BlocFormItem(value: 'v', error: 'e');
      final updated = item.copyWith();
      expect(updated.value, 'v');
      expect(updated.error, 'e');
    });
  });
}

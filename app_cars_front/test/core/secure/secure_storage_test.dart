import 'package:app_cars_front/core/secure/secure_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  late MockFlutterSecureStorage mockStorage;
  late SecureStorage secureStorage;

  const testKey = 'myKey';
  const testValue = 'myValue';

  setUp(() {
    mockStorage = MockFlutterSecureStorage();
    secureStorage = SecureStorage(mockStorage);
  });

  group('SecureStorage', () {
    test(
      'write calls FlutterSecureStorage.write with correct parameters',
      () async {
        when(
          () => mockStorage.write(
            key: any(named: 'key'),
            value: any(named: 'value'),
            iOptions: any(named: 'iOptions'),
            aOptions: any(named: 'aOptions'),
          ),
        ).thenAnswer((_) async {});

        await secureStorage.write(testKey, testValue);

        verify(
          () => mockStorage.write(
            key: testKey,
            value: testValue,
            iOptions: any(named: 'iOptions'),
            aOptions: any(named: 'aOptions'),
          ),
        ).called(1);
      },
    );

    test('read returns the value from FlutterSecureStorage', () async {
      when(
        () => mockStorage.read(
          key: any(named: 'key'),
          iOptions: any(named: 'iOptions'),
          aOptions: any(named: 'aOptions'),
        ),
      ).thenAnswer((_) async => testValue);

      final result = await secureStorage.read(testKey);

      expect(result, testValue);
      verify(
        () => mockStorage.read(
          key: testKey,
          iOptions: any(named: 'iOptions'),
          aOptions: any(named: 'aOptions'),
        ),
      ).called(1);
    });

    test('delete calls FlutterSecureStorage.delete with correct key', () async {
      when(
        () => mockStorage.delete(
          key: any(named: 'key'),
          iOptions: any(named: 'iOptions'),
          aOptions: any(named: 'aOptions'),
        ),
      ).thenAnswer((_) async {});

      await secureStorage.delete(testKey);

      verify(
        () => mockStorage.delete(
          key: testKey,
          iOptions: any(named: 'iOptions'),
          aOptions: any(named: 'aOptions'),
        ),
      ).called(1);
    });

    test('deleteAll calls FlutterSecureStorage.deleteAll', () async {
      when(
        () => mockStorage.deleteAll(
          iOptions: any(named: 'iOptions'),
          aOptions: any(named: 'aOptions'),
        ),
      ).thenAnswer((_) async {});

      await secureStorage.deleteAll();

      verify(
        () => mockStorage.deleteAll(
          iOptions: any(named: 'iOptions'),
          aOptions: any(named: 'aOptions'),
        ),
      ).called(1);
    });
  });
}

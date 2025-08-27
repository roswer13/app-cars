import 'package:app_cars_front/core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Resource', () {
    test('Initial should be a Resource', () {
      final resource = Initial();
      expect(resource, isA<Resource>());
    });

    test('Loading should be a Resource', () {
      final resource = Loading();
      expect(resource, isA<Resource>());
    });

    test('LoadingPage should be a Resource', () {
      final resource = LoadingPage();
      expect(resource, isA<Resource>());
    });

    test('Success should hold data of type T', () {
      final resource = Success<int>(42);
      expect(resource, isA<Resource<int>>());
      expect(resource.data, 42);
    });

    test('Error should hold a message', () {
      final resource = Error<String>('Something went wrong');
      expect(resource, isA<Resource<String>>());
      expect(resource.message, 'Something went wrong');
    });
  });
}

# app_cars_front

This is a Flutter application for managing car listings and user authentication.

## Pre-requisites

- Flutter SDK
- Dart SDK
- An IDE (e.g., Android Studio, Visual Studio Code)
- Add your google maps API key to the project, in the `android/app/src/main/strings.xml` file and `ios/Runner/AppDelegate.swift` file.

## Run project

The project use flavors for different environments.

For development:

```bash
flutter run --flavor dev -t lib/main_dev.dart
```

For staging:
```bash
flutter run --flavor staging -t lib/main_staging.dart
```

For production:
```bash
flutter run --flavor prod -t lib/main_prod.dart
```

## Run test

```bash
flutter test
```
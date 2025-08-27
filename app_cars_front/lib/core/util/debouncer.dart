import 'dart:async';

import 'package:flutter/material.dart';

/// A utility class that helps to debounce function calls.
///
/// The [Debouncer] delays the execution of a given callback function
/// until a specified duration has passed since the last time it was invoked.
/// This is useful for scenarios such as waiting for the user to stop typing
/// before performing a search or making a network request.
///
/// Example usage:
/// ```dart
/// final debouncer = Debouncer(milliseconds: 300);
///
/// // Call this inside a text field's onChanged:
/// debouncer.run(() {
///   // Perform your action here, e.g., search
/// });
/// ```
class Debouncer {
  /// The [milliseconds] parameter specifies the debounce duration in milliseconds.
  final int milliseconds;

  /// The [run] method schedules the [action] to be executed after the debounce period.
  VoidCallback? action;

  /// If [run] is called again before the timer completes, the previous timer is cancelled.
  Timer? _timer;

  Debouncer({this.milliseconds = 500});

  run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  void dispose() {
    _timer?.cancel();
  }
}

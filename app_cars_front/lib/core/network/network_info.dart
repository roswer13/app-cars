/// An abstract class that defines a contract for checking network connectivity.
///
/// Implementations of this class should provide a way to determine whether
/// the device is currently connected to the internet.
///
/// Example usage:
/// ```dart
/// final isConnected = await networkInfo.isConnected;
/// if (isConnected) {
///   // Proceed with network operations
/// }
/// ```
abstract class NetworkInfo {
  /// Returns a [Future] that completes with `true` if the device is connected
  /// to the internet, or `false` otherwise.
  Future<bool> get isConnected;
}

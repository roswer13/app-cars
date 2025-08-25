/// An abstract class that defines the contract for managing authentication tokens.
///
/// Implementations of this class are responsible for securely storing, retrieving,
/// and clearing access and refresh tokens used for authentication.
abstract class AuthTokenProvider {
  /// Retrieves the current access token.
  ///
  /// Returns a [Future] that completes with the access token as a [String],
  /// or `null` if no token is available.
  Future<String?> getAccessToken();

  /// Retrieves the current refresh token.
  ///
  /// Returns a [Future] that completes with the refresh token as a [String],
  /// or `null` if no token is available.
  Future<String?> getRefreshToken();

  /// Saves the provided access and refresh tokens.
  ///
  /// [access] is the access token to be stored.
  /// [refresh] is the refresh token to be stored.
  ///
  /// Returns a [Future] that completes when the tokens have been saved.
  Future<void> saveTokens({required String access, required String refresh});

  /// Clears all stored authentication tokens.
  ///
  /// Returns a [Future] that completes when the tokens have been cleared.
  Future<void> clearTokens();
}

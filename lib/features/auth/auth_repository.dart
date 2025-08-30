abstract class AuthRepository {
  /// Returns true when the user is logged in
  /// Returns [Future] because it will load a stored auth state the first time.
  Future<bool> get isAuthenticated;

  /// Perform login
  Future<void> login({required String email, required String password});

  /// Perform logout
  Future<void> logout();
}
import 'auth_repository.dart';

class AuthRepositoryDev extends AuthRepository {
  /// User is always authenticated in dev scenarios
  @override
  Future<bool> get isAuthenticated => Future.value(true);

  /// Login is always successful in dev scenarios
  @override
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    return true;
  }

  /// Logout is always successful in dev scenarios
  @override
  Future<bool> logout() async {
    return true;
  }
}
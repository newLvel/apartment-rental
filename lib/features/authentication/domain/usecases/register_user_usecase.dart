import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class RegisterUserUseCase {
  final AuthRepository repository;

  RegisterUserUseCase(this.repository);

  Future<User> call({required String name, required String email, required String password, required String role}) {
    return repository.register(name: name, email: email, password: password, role: role);
  }
}

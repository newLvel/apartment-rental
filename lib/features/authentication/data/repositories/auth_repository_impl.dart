import 'package:uuid/uuid.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/user_local_datasource.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final UserLocalDataSource localDataSource;

  AuthRepositoryImpl(this.localDataSource);

  @override
  Future<User> register({required String name, required String email, required String password, required String role}) async {
    final newUserModel = UserModel(
      id: const Uuid().v4(),
      email: email,
      name: name,
      role: role,
    );
    final registeredModel = await localDataSource.registerUser(newUserModel);
    return _mapUserModelToUser(registeredModel);
  }

  @override
  Future<User> login({required String email, required String password}) async {
    final loggedInModel = await localDataSource.loginUser(email, password);
    if (loggedInModel == null) {
      throw Exception('Login failed');
    }
    return _mapUserModelToUser(loggedInModel);
  }

  @override
  Future<User?> getCurrentUser() async {
    final currentUserModel = await localDataSource.getCurrentUser();
    return currentUserModel == null ? null : _mapUserModelToUser(currentUserModel);
  }

  @override
  Future<void> logout() async {
    await localDataSource.logoutUser();
  }

  User _mapUserModelToUser(UserModel model) {
    return User(
      id: model.id,
      email: model.email,
      name: model.name,
      role: model.role,
    );
  }
}

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:apartment_rental/core/constants.dart';
import 'package:apartment_rental/features/authentication/data/datasources/user_local_datasource.dart';
import 'package:apartment_rental/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:apartment_rental/features/authentication/domain/entities/user.dart';
import 'package:apartment_rental/features/authentication/domain/repositories/auth_repository.dart';
import 'package:apartment_rental/features/authentication/domain/usecases/get_current_user_usecase.dart';
import 'package:apartment_rental/features/authentication/domain/usecases/login_user_usecase.dart';
import 'package:apartment_rental/features/authentication/domain/usecases/logout_user_usecase.dart';
import 'package:apartment_rental/features/authentication/domain/usecases/register_user_usecase.dart';
import 'package:apartment_rental/features/authentication/data/models/user_model.dart';

part 'auth_provider.g.dart';

enum UserRole { client, owner, none }

// Providers for dependencies
@riverpod
UserLocalDataSource userLocalDataSource(UserLocalDataSourceRef ref) {
  final userBox = Hive.box<UserModel>(AppConstants.userBox);
  final preferencesBox = Hive.box<String>(AppConstants.userPreferencesBox);
  return UserLocalDataSourceImpl(userBox, preferencesBox);
}

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  final dataSource = ref.watch(userLocalDataSourceProvider);
  return AuthRepositoryImpl(dataSource);
}

@riverpod
RegisterUserUseCase registerUserUseCase(RegisterUserUseCaseRef ref) {
  return RegisterUserUseCase(ref.watch(authRepositoryProvider));
}

@riverpod
LoginUserUseCase loginUserUseCase(LoginUserUseCaseRef ref) {
  return LoginUserUseCase(ref.watch(authRepositoryProvider));
}

@riverpod
GetCurrentUserUseCase getCurrentUserUseCase(GetCurrentUserUseCaseRef ref) {
  return GetCurrentUserUseCase(ref.watch(authRepositoryProvider));
}

@riverpod
LogoutUserUseCase logoutUserUseCase(LogoutUserUseCaseRef ref) {
  return LogoutUserUseCase(ref.watch(authRepositoryProvider));
}

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  Future<User?> build() async {
    // Attempt to get the current user on app start
    return ref.watch(getCurrentUserUseCaseProvider).call();
  }

  Future<void> register({required String name, required String email, required String password, required UserRole role}) async {
    state = const AsyncValue.loading();
    final String roleString = role.toString().split('.').last;
    state = await AsyncValue.guard(() => ref.read(registerUserUseCaseProvider).call(
      name: name,
      email: email,
      password: password,
      role: roleString,
    ));
  }

  Future<void> login({required String email, required String password}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => ref.read(loginUserUseCaseProvider).call(
      email: email,
      password: password,
    ));
  }

  Future<void> logout() async {
    state = const AsyncValue.loading();
    await ref.read(logoutUserUseCaseProvider).call();
    state = const AsyncValue.data(null);
  }
}

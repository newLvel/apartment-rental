import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

enum UserRole { client, owner, none }

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  UserRole build() {
    return UserRole.none; // Initial state
  }

  void loginAsClient() {
    state = UserRole.client;
  }

  void loginAsOwner() {
    state = UserRole.owner;
  }

  void logout() {
    state = UserRole.none;
  }
}

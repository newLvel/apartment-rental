import 'package:hive_flutter/hive_flutter.dart';
import 'package:apartment_rental/core/constants.dart';
import '../models/user_model.dart';

abstract class UserLocalDataSource {
  Future<UserModel> registerUser(UserModel user);
  Future<UserModel?> loginUser(String email, String password);
  Future<UserModel?> getCurrentUser();
  Future<void> logoutUser();
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final Box<UserModel> userBox;
  final Box<String> preferencesBox;

  UserLocalDataSourceImpl(this.userBox, this.preferencesBox);

  @override
  Future<UserModel> registerUser(UserModel user) async {
    // For simplicity, directly store the user. In real app, hash password, etc.
    // Ensure email is unique (basic check for POC)
    if (userBox.values.any((u) => u.email == user.email)) {
      throw Exception('User with this email already exists.');
    }
    await userBox.put(user.id, user);
    await preferencesBox.put(AppConstants.currentUserIdKey, user.id); // Persist current user ID
    return user;
  }

  @override
  Future<UserModel?> loginUser(String email, String password) async {
    // For simplicity, find by email and check for any password (as none is stored)
    // In real app, would verify hashed password.
    final user = userBox.values.firstWhere(
      (u) => u.email == email,
      orElse: () => throw Exception('Invalid credentials'),
    );
    await preferencesBox.put(AppConstants.currentUserIdKey, user.id); // Persist current user ID
    return user;
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    final currentUserId = preferencesBox.get(AppConstants.currentUserIdKey);
    if (currentUserId != null) {
      return userBox.get(currentUserId);
    }
    return null;
  }

  @override
  Future<void> logoutUser() async {
    await preferencesBox.delete(AppConstants.currentUserIdKey);
  }
}

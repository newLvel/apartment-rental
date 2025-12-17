import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:apartment_rental/features/authentication/presentation/providers/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController(text: 'steven.henderson@example.com');
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  UserRole _selectedRole = UserRole.client; // Default to client

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              // Logo Area
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.apartment,
                  size: 60,
                  color: Color(0xFFE85D32), // Orange Theme Color
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'AL SAUD COMPANY LTD',
                style: TextStyle(
                  fontSize: 14,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                'Login to manage\nand explore properties',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 32),
              
              // Role Toggle
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedRole = UserRole.client),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: _selectedRole == UserRole.client ? Colors.white : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: _selectedRole == UserRole.client 
                                ? [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 4)] 
                                : [],
                          ),
                          child: Center(
                            child: Text(
                              'Tenant',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: _selectedRole == UserRole.client ? Colors.black : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedRole = UserRole.owner),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: _selectedRole == UserRole.owner ? Colors.white : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: _selectedRole == UserRole.owner 
                                ? [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 4)] 
                                : [],
                          ),
                          child: Center(
                            child: Text(
                              'Landlord',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: _selectedRole == UserRole.owner ? Colors.black : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Email Input
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email address',
                  prefixIcon: const Icon(Icons.alternate_email, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              // Password Input
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 32),
              // Login Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : () => _handleLogin(ref),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE85D32),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Login', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            SizedBox(width: 8),
                            Icon(Icons.arrow_forward, size: 20),
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 24),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Forgot password?',
                  style: TextStyle(
                    color: Colors.grey,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              // Register Link
              const Text("Don't want to login?", style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: OutlinedButton.icon(
                  onPressed: () {
                     // For POC: allow "Guest" or "Register"
                     context.push('/register');
                  },
                  icon: const Icon(Icons.person_add_outlined, color: Color(0xFF0A3D62)),
                  label: const Text(
                    'Create an account',
                    style: TextStyle(color: Color(0xFF0A3D62), fontWeight: FontWeight.bold),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey.shade300),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleLogin(WidgetRef ref) async {
    debugPrint('[_handleLogin] started');
    setState(() {
      _isLoading = true;
      debugPrint('[_handleLogin] _isLoading set to true');
    });
    try {
      debugPrint('[_handleLogin] calling authNotifierProvider.login');
      await ref.read(authNotifierProvider.notifier).login(
        email: _emailController.text,
        password: _passwordController.text,
      );
      debugPrint('[_handleLogin] authNotifierProvider.login completed');
      if (mounted) {
        final currentUser = ref.read(authNotifierProvider).value;
        debugPrint('[_handleLogin] current user: ${currentUser?.email}, role: ${currentUser?.role}');
        if (currentUser?.role == UserRole.client.name) {
          context.go('/client_home');
        } else if (currentUser?.role == UserRole.owner.name) {
          context.go('/owner_home');
        } else {
          context.go('/login');
        }
      }
    } catch (e) {
      debugPrint('[_handleLogin] caught error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login Failed: ${e.toString()}')));
      }
    } finally {
      debugPrint('[_handleLogin] finally block');
      if (mounted) {
        setState(() {
          _isLoading = false;
          debugPrint('[_handleLogin] _isLoading set to false');
        });
      }
    }
  }
}

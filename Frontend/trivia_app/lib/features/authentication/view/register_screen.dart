import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trivia_app/core/services/auth_service.dart';
import 'package:trivia_app/core/services/logger_service.dart';
import 'package:trivia_app/core/services/service_locator.dart';
import 'package:trivia_app/core/services/user_service.dart';
import 'package:trivia_app/features/authentication/view/login_screen.dart';
import 'package:trivia_app/features/category/view/category_screen.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  final UserService userService = getIt<UserService>();
  final AuthService authService = getIt<AuthService>();
  final LoggerService loggerService = getIt<LoggerService>();

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isPasswordObscured = true;
  bool _isConfirmPasswordObscured = true;

  void dismissKeyboard(BuildContext buildContext) {
    final FocusScopeNode currentFocus = FocusScope.of(buildContext);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordObscured = !_isPasswordObscured;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _isConfirmPasswordObscured = !_isConfirmPasswordObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => dismissKeyboard(context),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF8668FF),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
          ),
        ),
        resizeToAvoidBottomInset: true,
        backgroundColor: const Color(0xFF8668FF),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'REGISTER',
                  style: GoogleFonts.nunito(
                    textStyle: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 5,
                      shadows: [
                        Shadow(
                          offset: Offset(2, 2),
                          blurRadius: 4,
                          color: Colors.black54,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                _buildTextField('Full name', _fullnameController),
                const SizedBox(height: 20),
                _buildTextField('Birthday', _dobController, isDatePicker: true),
                const SizedBox(height: 20),
                _buildTextField('Email', _emailController),
                const SizedBox(height: 20),
                _buildTextField('Password', _passwordController,
                    isPassword: true,
                    isObscured: _isPasswordObscured,
                    toggleVisibility: _togglePasswordVisibility),
                const SizedBox(height: 20),
                _buildTextField('Confirm Password', _confirmPasswordController,
                    isPassword: true,
                    isObscured: _isConfirmPasswordObscured,
                    toggleVisibility: _toggleConfirmPasswordVisibility),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          final fullName = _fullnameController.text.trim();
                          final birthDateRaw = _dobController.text.trim();
                          final email = _emailController.text.trim();
                          final password = _passwordController.text;
                          final confirmPassword =
                              _confirmPasswordController.text;

                          String? error;

                          if (fullName.length <= 5) {
                            error =
                                'Full name must be longer than 5 characters.';
                          } else if (!_isValidEmail(email)) {
                            error = 'Please enter a valid email address.';
                          } else if (password.length <= 8) {
                            error =
                                'Password must be longer than 8 characters.';
                          } else if (password != confirmPassword) {
                            error = 'Passwords do not match.';
                          } else if (!_isValidBirthday(birthDateRaw)) {
                            error = 'You must be at least 12 years old.';
                          }

                          if (error != null) {
                            _showErrorDialog(error);
                            return;
                          }

                          try {
                            final birthDate = _parseBirthday(birthDateRaw);

                            await widget.authService
                                .registerWithEmail(email, password);
                            await widget.userService.registerUser(
                              fullName: fullName,
                              birthDate: birthDate,
                            );

                            if (!mounted) return;
                            _navigateCategories();
                          } catch (e) {
                            widget.loggerService.logError('$e');
                            final errorMessage =
                                _mapFirebaseError(e.toString());
                            _showErrorDialog(errorMessage);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 40.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        child: const Text(
                          'Register',
                          style: TextStyle(
                            color: Color(0xFF8668FF),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    bool isPassword = false,
    bool isDatePicker = false,
    bool isObscured = false,
    VoidCallback? toggleVisibility,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: isDatePicker,
      obscureText: isPassword ? isObscured : false,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
        filled: true,
        fillColor: const Color(0xFF755FB5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  isObscured ? Icons.visibility_off : Icons.visibility,
                  color: Colors.white,
                ),
                onPressed: toggleVisibility,
              )
            : null,
      ),
      style: const TextStyle(color: Colors.white),
      onTap: isDatePicker
          ? () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );
              if (pickedDate != null) {
                controller.text =
                    "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
              }
            }
          : null,
    );
  }

  DateTime _parseBirthday(String rawText) {
    final parts = rawText.split('/');
    return DateTime(
      int.parse(parts[2]),
      int.parse(parts[1]),
      int.parse(parts[0]),
    );
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  bool _isValidBirthday(String birthDate) {
    try {
      final parsed = _parseBirthday(birthDate);
      final today = DateTime.now();
      final age = today.year -
          parsed.year -
          (today.month < parsed.month ||
                  (today.month == parsed.month && today.day < parsed.day)
              ? 1
              : 0);
      return age >= 12;
    } catch (_) {
      return false;
    }
  }

  String _mapFirebaseError(String error) {
    if (error.contains('email-already-in-use')) {
      return 'This email is already in use.';
    } else if (error.contains('invalid-email')) {
      return 'The email address is not valid.';
    } else if (error.contains('weak-password')) {
      return 'The password is too weak.';
    } else {
      return 'Registration failed. Please try again.';
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Registration Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _navigateCategories() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => CategoryScreen()),
    );
  }

  @override
  void dispose() {
    _fullnameController.dispose();
    _dobController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}

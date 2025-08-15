import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tabibak/core/constant/colors.dart';
import 'package:tabibak/core/constant/string.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  String? _phoneError;
  String? _passwordError;
  String _userRole = 'patient'; // Default role

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validatePhone(String value) {
    if (value.isEmpty) {
      setState(() {
        _phoneError = 'Phone number is required';
      });
    } else if (value.length < 10) {
      setState(() {
        _phoneError = 'Phone number must be at least 10 digits';
      });
    } else {
      setState(() {
        _phoneError = null;
      });
    }
  }

  void _validatePassword(String value) {
    if (value.isEmpty) {
      setState(() {
        _passwordError = 'Password is required';
      });
    } else if (value.length < 6) {
      setState(() {
        _passwordError = 'Password must be at least 6 characters';
      });
    } else {
      setState(() {
        _passwordError = null;
      });
    }
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
        });
        
        // Redirect based on user role
        String targetRoute = _userRole == 'doctor' ? Routes.doctorDashboard : Routes.home;
        
        Navigator.pushNamedAndRemoveUntil(
          context,
          targetRoute,
          (route) => false,
        );
      });
    }
  }

  void _goToSignup() {
    Navigator.pushNamed(context, Routes.signup);
  }

  void _goToForgotPassword() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Forgot password functionality coming soon'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.kBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 60),

                Text(
                  'Login',
                  style: GoogleFonts.montserrat(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: ColorsApp.kPrimaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 60),

                // Role Selection
                Container(
                  decoration: BoxDecoration(
                    color: ColorsApp.kWhiteColor,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButtonFormField<String>(
                      value: _userRole,
                      decoration: InputDecoration(
                        hintText: 'Select your role',
                        hintStyle: TextStyle(
                          color: ColorsApp.kSecondaryTextColor,
                        ),
                        prefixIcon: Icon(
                          Icons.person,
                          color: ColorsApp.kPrimaryColor,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(16),
                      ),
                      items: [
                        DropdownMenuItem(
                          value: 'patient',
                          child: Row(
                            children: [
                              Icon(Icons.person, color: ColorsApp.kPrimaryColor),
                              const SizedBox(width: 8),
                              Text(
                                'Patient',
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  color: ColorsApp.kTextColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'doctor',
                          child: Row(
                            children: [
                              Icon(Icons.medical_services, color: ColorsApp.kPrimaryColor),
                              const SizedBox(width: 8),
                              Text(
                                'Doctor',
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  color: ColorsApp.kTextColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _userRole = value!;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select your role';
                        }
                        return null;
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Container(
                  decoration: BoxDecoration(
                    color: ColorsApp.kWhiteColor,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: _validatePhone,
                    decoration: InputDecoration(
                      hintText: 'Enter your phone number',
                      hintStyle: TextStyle(
                        color: ColorsApp.kSecondaryTextColor,
                      ),
                      prefixIcon: Icon(
                        Icons.phone,
                        color: _phoneError != null
                            ? ColorsApp.kErrorColor
                            : ColorsApp.kPrimaryColor,
                      ),
                      suffixIcon: _phoneController.text.isNotEmpty
                          ? Icon(
                              _phoneError != null
                                  ? Icons.close
                                  : Icons.check_circle,
                              color: _phoneError != null
                                  ? ColorsApp.kErrorColor
                                  : ColorsApp.kSuccessColor,
                            )
                          : null,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.all(16),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Phone number is required';
                      }
                      if (value.length < 10) {
                        return 'Phone number must be at least 10 digits';
                      }
                      return null;
                    },
                  ),
                ),

                if (_phoneError != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    _phoneError!,
                    style: TextStyle(
                      color: ColorsApp.kErrorColor,
                      fontSize: 12,
                    ),
                  ),
                ],

                const SizedBox(height: 20),

                Container(
                  decoration: BoxDecoration(
                    color: ColorsApp.kWhiteColor,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    onChanged: _validatePassword,
                    decoration: InputDecoration(
                      hintText: 'Enter your password',
                      hintStyle: TextStyle(
                        color: ColorsApp.kSecondaryTextColor,
                      ),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: _passwordError != null
                            ? ColorsApp.kErrorColor
                            : ColorsApp.kPrimaryColor,
                      ),
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (_passwordController.text.isNotEmpty)
                            Icon(
                              _passwordError != null
                                  ? Icons.close
                                  : Icons.check_circle,
                              color: _passwordError != null
                                  ? ColorsApp.kErrorColor
                                  : ColorsApp.kSuccessColor,
                            ),
                          IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: ColorsApp.kSecondaryTextColor,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                        ],
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.all(16),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                ),

                if (_passwordError != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    _passwordError!,
                    style: TextStyle(
                      color: ColorsApp.kErrorColor,
                      fontSize: 12,
                    ),
                  ),
                ],

                const SizedBox(height: 16),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: _goToForgotPassword,
                    child: Text(
                      'Forgot password?',
                      style: TextStyle(
                        color: ColorsApp.kPrimaryColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                ElevatedButton(
                  onPressed: _isLoading ? null : _handleLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsApp.kPrimaryColor,
                    foregroundColor: ColorsApp.kWhiteColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              ColorsApp.kWhiteColor,
                            ),
                          ),
                        )
                      : Text(
                          'Login',
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),

                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(
                        color: ColorsApp.kSecondaryTextColor,
                        fontSize: 14,
                      ),
                    ),
                    TextButton(
                      onPressed: _goToSignup,
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                          color: ColorsApp.kPrimaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

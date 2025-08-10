import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tabibak/core/constant/colors.dart';
import 'package:tabibak/core/constant/string.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;
  bool _agreeToTerms = false;
  String? _selectedRole;

  String? _nameError;
  String? _phoneError;
  String? _passwordError;
  String? _confirmPasswordError;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _validateName(String value) {
    if (value.isEmpty) {
      setState(() {
        _nameError = 'Name is required';
      });
    } else if (value.length < 2) {
      setState(() {
        _nameError = 'Name must be at least 2 characters';
      });
    } else {
      setState(() {
        _nameError = null;
      });
    }
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
    _validateConfirmPassword(_confirmPasswordController.text);
  }

  void _validateConfirmPassword(String value) {
    if (value.isEmpty) {
      setState(() {
        _confirmPasswordError = 'Please confirm your password';
      });
    } else if (value != _passwordController.text) {
      setState(() {
        _confirmPasswordError = 'Passwords do not match';
      });
    } else {
      setState(() {
        _confirmPasswordError = null;
      });
    }
  }

  void _handleSignup() {
    if (_formKey.currentState!.validate() &&
        _selectedRole != null &&
        _agreeToTerms) {
      setState(() {
        _isLoading = true;
      });

      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
        });

        if (_selectedRole == 'doctor') {
          Navigator.pushNamed(context, Routes.doctorRegistration);
        } else {
          Navigator.pushNamed(context, Routes.patientRegistration);
        }
      });
    } else {
      if (_selectedRole == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Please select a role',
              style: GoogleFonts.montserrat(),
            ),
            backgroundColor: ColorsApp.kErrorColor,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }
      if (!_agreeToTerms) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Please agree to terms and conditions',
              style: GoogleFonts.montserrat(),
            ),
            backgroundColor: ColorsApp.kErrorColor,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }
    }
  }

  void _goToLogin() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              ColorsApp.kPrimaryColor.withOpacity(0.1),
              ColorsApp.kBackgroundColor,
            ],
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16.0,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      'Create Account',
                      style: GoogleFonts.montserrat(
                        fontSize: 34,
                        fontWeight: FontWeight.w700,
                        color: ColorsApp.kPrimaryColor,
                        letterSpacing: 0.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Join as a doctor or patient',
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        color: ColorsApp.kSecondaryTextColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),
                    _buildTextField(
                      controller: _nameController,
                      hintText: 'Full Name',
                      icon: Icons.person,
                      error: _nameError,
                      onChanged: _validateName,
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Name is required';
                        if (value.length < 2)
                          return 'Name must be at least 2 characters';
                        return null;
                      },
                    ),
                    if (_nameError != null) _buildErrorText(_nameError!),
                    const SizedBox(height: 20),
                    _buildTextField(
                      controller: _phoneController,
                      hintText: 'Phone Number',
                      icon: Icons.phone,
                      error: _phoneError,
                      onChanged: _validatePhone,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Phone number is required';
                        if (value.length < 10)
                          return 'Phone number must be at least 10 digits';
                        return null;
                      },
                    ),
                    if (_phoneError != null) _buildErrorText(_phoneError!),
                    const SizedBox(height: 20),
                    _buildTextField(
                      controller: _passwordController,
                      hintText: 'Password',
                      icon: Icons.lock,
                      error: _passwordError,
                      onChanged: _validatePassword,
                      obscureText: !_isPasswordVisible,
                      isPassword: true,
                      toggleVisibility: () => setState(
                        () => _isPasswordVisible = !_isPasswordVisible,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Password is required';
                        if (value.length < 6)
                          return 'Password must be at least 6 characters';
                        return null;
                      },
                    ),
                    if (_passwordError != null)
                      _buildErrorText(_passwordError!),
                    const SizedBox(height: 20),
                    _buildTextField(
                      controller: _confirmPasswordController,
                      hintText: 'Confirm Password',
                      icon: Icons.lock,
                      error: _confirmPasswordError,
                      onChanged: _validateConfirmPassword,
                      obscureText: !_isConfirmPasswordVisible,
                      isPassword: true,
                      toggleVisibility: () => setState(
                        () => _isConfirmPasswordVisible =
                            !_isConfirmPasswordVisible,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Please confirm your password';
                        if (value != _passwordController.text)
                          return 'Passwords do not match';
                        return null;
                      },
                    ),
                    if (_confirmPasswordError != null)
                      _buildErrorText(_confirmPasswordError!),
                    const SizedBox(height: 32),
                    Text(
                      'Select Your Role',
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: ColorsApp.kTextColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildRoleCard(
                            'Doctor',
                            Icons.medical_services,
                            'doctor',
                            'Provide medical services',
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildRoleCard(
                            'Patient',
                            Icons.person,
                            'patient',
                            'Get medical help',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Row(
                      children: [
                        Checkbox(
                          value: _agreeToTerms,
                          onChanged: (value) =>
                              setState(() => _agreeToTerms = value ?? false),
                          activeColor: ColorsApp.kPrimaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'I agree to the Terms & Conditions and Privacy Policy',
                            style: GoogleFonts.montserrat(
                              color: ColorsApp.kTextColor,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: _isLoading ? null : _handleSignup,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsApp.kPrimaryColor,
                        foregroundColor: ColorsApp.kWhiteColor,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                        shadowColor: ColorsApp.kPrimaryColor.withOpacity(0.3),
                        animationDuration: const Duration(milliseconds: 200),
                      ),
                      child: _isLoading
                          ? SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 3,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  ColorsApp.kWhiteColor,
                                ),
                              ),
                            )
                          : Text(
                              'Create Account',
                              style: GoogleFonts.montserrat(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                              ),
                            ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: GoogleFonts.montserrat(
                            color: ColorsApp.kSecondaryTextColor,
                            fontSize: 14,
                          ),
                        ),
                        TextButton(
                          onPressed: _goToLogin,
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                          ),
                          child: Text(
                            'Login',
                            style: GoogleFonts.montserrat(
                              color: ColorsApp.kPrimaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
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
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    String? error,
    required Function(String) onChanged,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    bool obscureText = false,
    bool isPassword = false,
    Function()? toggleVisibility,
    String? Function(String?)? validator,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: ColorsApp.kWhiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: error != null
                ? ColorsApp.kErrorColor.withOpacity(0.2)
                : Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: error != null ? ColorsApp.kErrorColor : Colors.transparent,
          width: 1,
        ),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        obscureText: obscureText,
        onChanged: onChanged,
        style: GoogleFonts.montserrat(fontSize: 16),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.montserrat(
            color: ColorsApp.kSecondaryTextColor,
            fontSize: 16,
          ),
          prefixIcon: Icon(
            icon,
            color: error != null
                ? ColorsApp.kErrorColor
                : ColorsApp.kPrimaryColor,
            size: 24,
          ),
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (controller.text.isNotEmpty && !isPassword)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Icon(
                    error != null ? Icons.close : Icons.check_circle,
                    color: error != null
                        ? ColorsApp.kErrorColor
                        : ColorsApp.kSuccessColor,
                    size: 20,
                  ),
                ),
              if (isPassword)
                IconButton(
                  icon: Icon(
                    obscureText ? Icons.visibility_off : Icons.visibility,
                    color: ColorsApp.kSecondaryTextColor,
                    size: 20,
                  ),
                  onPressed: toggleVisibility,
                ),
            ],
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 16,
          ),
        ),
        validator: validator,
      ),
    );
  }

  Widget _buildErrorText(String error) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 12),
      child: Text(
        error,
        style: GoogleFonts.montserrat(
          color: ColorsApp.kErrorColor,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildRoleCard(
    String title,
    IconData icon,
    String role,
    String description,
  ) {
    final isSelected = _selectedRole == role;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedRole = role;
          _animationController.forward(from: 0);
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? ColorsApp.kPrimaryColor : ColorsApp.kWhiteColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? ColorsApp.kPrimaryColor
                : ColorsApp.kLightGreyColor,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? ColorsApp.kPrimaryColor.withOpacity(0.3)
                  : Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 48,
              color: isSelected
                  ? ColorsApp.kWhiteColor
                  : ColorsApp.kPrimaryColor,
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: isSelected
                    ? ColorsApp.kWhiteColor
                    : ColorsApp.kTextColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: GoogleFonts.montserrat(
                fontSize: 13,
                color: isSelected
                    ? ColorsApp.kWhiteColor.withOpacity(0.8)
                    : ColorsApp.kSecondaryTextColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

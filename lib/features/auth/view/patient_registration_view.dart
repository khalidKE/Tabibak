import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tabibak/core/constant/colors.dart';
import 'package:tabibak/core/constant/string.dart';

class PatientRegistrationView extends StatefulWidget {
  const PatientRegistrationView({super.key});

  @override
  State<PatientRegistrationView> createState() =>
      _PatientRegistrationViewState();
}

class _PatientRegistrationViewState extends State<PatientRegistrationView>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _ageController = TextEditingController();
  final _emergencyContactController = TextEditingController();

  bool _isLoading = false;
  String? _selectedGender;

  String? _ageError;
  String? _genderError;
  String? _emergencyContactError;

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
    _ageController.dispose();
    _emergencyContactController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _validateAge(String value) {
    if (value.isEmpty) {
      setState(() {
        _ageError = 'Age is required';
      });
    } else {
      final age = int.tryParse(value);
      if (age == null || age < 1 || age > 120) {
        setState(() {
          _ageError = 'Please enter a valid age (1-120)';
        });
      } else {
        setState(() {
          _ageError = null;
        });
      }
    }
  }

  void _validateEmergencyContact(String value) {
    if (value.isEmpty) {
      setState(() {
        _emergencyContactError = 'Emergency contact is required';
      });
    } else if (value.length < 10) {
      setState(() {
        _emergencyContactError = 'Phone number must be at least 10 digits';
      });
    } else {
      setState(() {
        _emergencyContactError = null;
      });
    }
  }

  void _completeRegistration() {
    if (_formKey.currentState!.validate() && _selectedGender != null) {
      setState(() {
        _isLoading = true;
      });

      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Registration completed successfully!',
              style: GoogleFonts.montserrat(),
            ),
            backgroundColor: ColorsApp.kSuccessColor,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );

        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.home,
          (route) => false,
        );
      });
    } else {
      if (_selectedGender == null) {
        setState(() {
          _genderError = 'Please select your gender';
        });
      }
    }
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      leading: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: ColorsApp.kPrimaryColor,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                      title: Text(
                        'Patient Registration',
                        style: GoogleFonts.montserrat(
                          color: ColorsApp.kPrimaryColor,
                          fontSize: 19,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: ColorsApp.kPrimaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.medical_services,
                            size: 48,
                            color: ColorsApp.kPrimaryColor,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Welcome to Tabibak!',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                    color: ColorsApp.kPrimaryColor,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Complete your profile to access medical services',
                                  style: GoogleFonts.montserrat(
                                    color: ColorsApp.kSecondaryTextColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'Complete Your Profile',
                      style: GoogleFonts.montserrat(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: ColorsApp.kTextColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Please provide the following information to finalize your registration',
                      style: GoogleFonts.montserrat(
                        color: ColorsApp.kSecondaryTextColor,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 32),
                    _buildInputField(
                      controller: _ageController,
                      label: 'Age',
                      hint: 'Enter your age',
                      icon: Icons.person_outline,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onChanged: _validateAge,
                      error: _ageError,
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Age is required';
                        final age = int.tryParse(value);
                        if (age == null || age < 1 || age > 120)
                          return 'Please enter a valid age (1-120)';
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Gender',
                      style: GoogleFonts.montserrat(
                        color: ColorsApp.kTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _buildGenderCard(
                            'Male',
                            Icons.male,
                            'male',
                            'I am male',
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildGenderCard(
                            'Female',
                            Icons.female,
                            'female',
                            'I am female',
                          ),
                        ),
                      ],
                    ),
                    if (_genderError != null) ...[
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Text(
                          _genderError!,
                          style: GoogleFonts.montserrat(
                            color: ColorsApp.kErrorColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: 20),
                    _buildInputField(
                      controller: _emergencyContactController,
                      label: 'Emergency Contact',
                      hint: 'Enter emergency contact phone number',
                      icon: Icons.emergency,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onChanged: _validateEmergencyContact,
                      error: _emergencyContactError,
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Emergency contact is required';
                        if (value.length < 10)
                          return 'Phone number must be at least 10 digits';
                        return null;
                      },
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: _isLoading ? null : _completeRegistration,
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(vertical: 18),
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        elevation: MaterialStateProperty.all(6),
                        shadowColor: MaterialStateProperty.all(
                          ColorsApp.kPrimaryColor.withOpacity(0.25),
                        ),
                        overlayColor: MaterialStateProperty.resolveWith<Color?>(
                          (states) {
                            if (states.contains(MaterialState.pressed)) {
                              return ColorsApp.kPrimaryColor.withOpacity(0.15);
                            }
                            return null;
                          },
                        ),
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                              (states) => Colors.transparent,
                            ),
                        foregroundColor: MaterialStateProperty.all(
                          ColorsApp.kWhiteColor,
                        ),
                      ),
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              ColorsApp.kPrimaryColor,
                              ColorsApp.kPrimaryColor.withOpacity(0.85),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          constraints: const BoxConstraints(minHeight: 48),
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
                                  'Complete Registration',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.5,
                                    color: ColorsApp.kWhiteColor,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: ColorsApp.kLightGreyColor.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: ColorsApp.kPrimaryColor,
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Your information is secure and will only be used to provide you with better medical services.',
                              style: GoogleFonts.montserrat(
                                color: ColorsApp.kSecondaryTextColor,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
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

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    Function(String)? onChanged,
    String? error,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.montserrat(
            color: ColorsApp.kTextColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        AnimatedContainer(
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
            onChanged: onChanged,
            style: GoogleFonts.montserrat(fontSize: 16),
            decoration: InputDecoration(
              hintText: hint,
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
              suffixIcon: controller.text.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Icon(
                        error != null ? Icons.close : Icons.check_circle,
                        color: error != null
                            ? ColorsApp.kErrorColor
                            : ColorsApp.kSuccessColor,
                        size: 20,
                      ),
                    )
                  : null,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 18,
                horizontal: 16,
              ),
            ),
            validator: validator,
          ),
        ),
        if (error != null) ...[
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              error,
              style: GoogleFonts.montserrat(
                color: ColorsApp.kErrorColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildGenderCard(
    String title,
    IconData icon,
    String gender,
    String description,
  ) {
    final isSelected = _selectedGender == gender;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedGender = gender;
          _genderError = null;
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
              size: 36,
              color: isSelected
                  ? ColorsApp.kWhiteColor
                  : ColorsApp.kPrimaryColor,
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: GoogleFonts.montserrat(
                fontSize: 16,
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
                fontSize: 12,
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
